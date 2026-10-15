# Integración de la app con el API de Parkea

Estado al 14/10/2026, rama `beta/redesign` (hasta `9fe8418`).
Todo lo descrito aquí se probó en el emulador de Android contra el API local.

## Entorno local

| | |
|---|---|
| URL base (emulador Android) | `http://10.0.2.2:8080/api/v1/` |
| URL base (simulador iOS / escritorio) | `http://localhost:8080/api/v1/` |
| Otra URL | `--dart-define=API_BASE_URL=http://<host>:8080/api/v1/` |
| Datos de prueba | `podman exec parkea_api_web_1 python manage.py seed_demo --reset` (eventos en AR, CO y MX, 5 promociones y los eventos "Demo: …") |
| Enlace de reset de contraseña (no hay SMTP) | `podman logs parkea_api_web_1 \| grep parkea://` |
| Cuentas de prueba | `demo_user` / `demo1234` (tiene tickets y guardados del seed), `qa203250` (PERSON, sin verificar) y `qa_commerce` (COMMERCE, verificada, puede crear eventos) |
| Evento privado del seed | "Demo: privado", código `DEMO2345` |

Notas:
- Los ids de los eventos cambian con cada `--reset`: hay que buscarlos por nombre.
- El contenedor web tiene el código dentro de la imagen. Para probar cambios del backend hay que reconstruirla; eso lo hace la sesión del backend.
- Si el emulador deja de llegar a `10.0.2.2` ("Network is unreachable"), reiniciarlo con cold boot.

Contrato general del API:
- Todas las respuestas llegan con HTTP 200 y el envelope `{"status": <int>, "body": ...}`. La app decide con `body.status`.
- Todos los paths llevan barra final.
- Los endpoints protegidos usan `Authorization: Bearer <access>`.
- La app manda `Accept-Language` con su idioma y el API responde sus mensajes traducidos (sin el header responde en español).

## Lo que está integrado

### Autenticación y sesión
- **Login** con usuario o email (`user/login/`), y después se carga el perfil (`user/profile/`).
- **Registro** (`user/register/`):
  - El email es opcional.
  - En la app se aplican las mismas reglas de contraseña que el backend (Django 4.2). Lo cubre el test `test/password_policy_test.dart`.
  - Los errores del API aparecen debajo de cada campo.
- **Logout** (`logout/`): manda el refresh token a la blacklist y borra la sesión local aunque el API falle.
- **Reset de contraseña**: `user/password/reset/` y `user/password/reset/confirm/`, con el deep link `parkea://reset-password?uid=..&token=..` en Android e iOS.
- **Tokens**:
  - El access dura 60 min y el refresh 7 días; el refresh rota en cada uso.
  - `ApiClient` reintenta una vez con refresh si el API responde `token_not_valid`, y nunca hace dos refresh en paralelo.
  - Si el refresh es rechazado, la sesión se cierra y la app vuelve a la pantalla de auth.

### Home
- **Feed de eventos** con scroll infinito (`events/all/?page=N&upcoming=true`):
  - Solo eventos que no han pasado. Orden por fecha de creación, más recientes primero.
  - Pull-to-refresh, reintento si falla una página y mensaje al llegar al final.
- **Categorías** (`?category=`), **búsqueda** (`?search=`, espera 400 ms) y **ubicación** (`?country=&city=`). Se combinan entre sí.
- **Selector de ubicación**: un chip junto a "Eventos para ti" abre los países y ciudades con eventos próximos (`events/locations/`) y cuántos tiene cada uno.
- **Promociones**: carrusel de banners 2:1 (`promotions/`).
- El saludo cambia según la hora (buenos días, tardes o noches).

### Detalle de evento (`event/details/?id=`)
- Fecha, organizador, descripción, precio con su moneda, cupos y ubicación con mapa de OpenStreetMap.
- **Inscripción** (`POST ticket/enroll/`, payload `{"body": {"event": id, "otp": ...}}`):
  - FREE: "Inscribirme · Gratis" inscribe directo.
  - PRIVATE: pide el código de acceso; si es inválido, el error sale en el campo.
  - Si ya está inscrito: "Ver mi ticket" abre el ticket.
  - Deshabilitado con el motivo: evento pasado, propio, agotado, solo por invitación o de pago ("Pago próximamente").
- **Organizador del evento**:
  - "Editar evento" usa el formulario de crear, ya lleno (`PATCH events/update/<id>/`). Solo manda los campos del formulario, así no borra dirección ni coordenadas.
  - Borrar evento (`DELETE events/delete/<id>/`) con confirmación; borra también las inscripciones.
  - En eventos PRIVATE ve el código de acceso con un botón para copiarlo.
- **Eventos similares**: hasta 10 eventos próximos de la misma categoría y país.

### Tickets (`ticket/user/all/`)
- Próximos y anteriores, agrupados por mes, con un número sobre la pestaña Tickets.
- En el detalle del ticket se puede ver el evento y **cancelar la inscripción** (`DELETE ticket/cancel/<id>/`).

### Perfil
- **Eventos**: los eventos creados por el usuario (`events/owner/`).
- **Inscritos**: los eventos de sus tickets.
- **Foto de perfil** (`PUT user/profile/image/`, multipart `avatar`).

### Crear evento (`events/create/` y `events/update/image/<id>/`)
- Solo cuentas verificadas (`is_verified`), desde el botón **+** de la barra inferior.
- Validaciones en la app y errores del API debajo de cada campo.

### Transversal
- **Idiomas**: todos los textos de la app están en los 7 idiomas (es, en, de, fr, pt, ru, zh), incluidos los errores de los use cases (por `S.current`).
- **Errores**:
  - Sin red, la app muestra "No se pudo conectar con el servidor" y un botón de reintentar. `ApiClient` convierte el fallo de red en el mismo 408 de un timeout.
  - Los reintentos automáticos de Riverpod están desactivados, así los errores se ven enseguida.
- **Enums del API en texto**: `cost_type` (`FREE | PAID | INVITATION | PRIVATE`), `category` (`MUSIC | CAMPING | ADVENTURE | WORKSHOPS`) y `user_type` (`PERSON | COMMERCE`).
- **Calidad**:
  - `flutter analyze` sin avisos (`lib/generated` está excluido).
  - Se borraron las pantallas, mocks y datos de ejemplo que ya no se usaban. La integración con Yappy se conserva para pagos.
- **Tests**: 59. Los use cases reciben sus repositorios por providers (`lib/domain/usecases/repositories.dart`) y los tests usan una capa HTTP falsa (`test/helpers/fake_api.dart`).

## Backend: disponible y todavía sin usar en la app

Está en la rama `feat/mobile-tickets-saved` del API. El commit `dae3031` tiene los puntos del 1 al 5. Las ubicaciones (`events/locations/`) y la traducción de mensajes **todavía no tienen commit** y esperan revisión. Todo se validó con curl contra el contenedor local.

1. **`event/details/`** agrega `my_ticket_id`, `is_owner`, `is_saved` y `owner_avatar`. La app ya usa `is_owner`; para saber si el usuario está inscrito todavía busca en su lista de tickets.
2. **Tickets**: `ticket/user/all/?when=upcoming|past` y `ticket/user/count/` (`{"upcoming": n, "past": n}`). La app sigue separando y contando por su cuenta.
3. **Datos del ticket**: `code` (para el QR), `status` (`ACTIVE | CANCELLED | USED`), `price_paid` y `currency`.
4. **Guardados**: `POST` y `DELETE events/saved/<id>/`, `GET events/saved/`, e `is_saved` en todos los eventos.
5. **Avatar del organizador**: `owner_avatar` en todos los eventos.

## Pasos que siguen

### App (el backend ya lo permite)
1. **Guardados / favoritos**: activar el corazón del detalle y mostrar la pestaña de guardados.
2. **Ticket con QR**: mostrar el `code` como QR y el estado del ticket.
3. **Avatar del organizador** en el feed y el detalle.
4. **Usar `my_ticket_id`, `?when=` y `ticket/user/count/`**, en lugar de calcularlo en la app.

### Decisiones pendientes
- **Chino**: la app usa chino tradicional y el API responde en simplificado (`zh-hans`).
- **Provincia en el registro**: el formulario la pide pero no se envía al API. ¿Se quita o se guarda en el backend?
- **Abrir la app sin red** lleva a la pantalla de login. La sesión se conserva, pero convendría mostrar "sin conexión" con reintentar.
- **Pagos e inscripción a eventos PAID e INVITATION**: el backend preparó una propuesta para decidir.
- **Orden del feed**: hoy es por fecha de creación. El backend puede agregar `?ordering=` para mostrar primero los más cercanos.
- **Nombres de países**: hoy se muestran con bandera y código (CO, MX).

### Antes de producción
- Configurar la URL de producción (HTTPS) con `API_BASE_URL`. El HTTP sin TLS solo está permitido en el manifest de debug.
- Revisar la política de uso de los tiles de OpenStreetMap para el volumen esperado.
- Revisar los logs: en debug se imprimen las respuestas completas, incluidos los tokens. En release el logger está apagado.
