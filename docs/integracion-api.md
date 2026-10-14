# Integración de la app con el API de Parkea

Estado al 13/10/2026, rama `beta/redesign` (commits `3599ea8` a `1c27555`).
Todo lo descrito aquí se probó en el emulador de Android contra el API local.

## Entorno local

| | |
|---|---|
| URL base (emulador Android) | `http://10.0.2.2:8080/api/v1/` |
| URL base (simulador iOS / escritorio) | `http://localhost:8080/api/v1/` |
| Otra URL | `--dart-define=API_BASE_URL=http://<host>:8080/api/v1/` |
| Datos de prueba | `podman exec parkea_api_web_1 python manage.py seed_demo --reset` (40 eventos y 5 promociones) |
| Enlace de reset de contraseña (no hay SMTP) | `podman logs parkea_api_web_1 \| grep parkea://` |
| Cuentas de prueba | `qa203250` (PERSON, sin verificar) y `qa_commerce` (COMMERCE, verificada, puede crear eventos) |

Contrato general del API:
- Todas las respuestas llegan con HTTP 200 y el envelope `{"status": <int>, "body": ...}`. La app decide con `body.status`.
- Todos los paths llevan barra final.
- Los endpoints protegidos usan `Authorization: Bearer <access>`.

## Lo que está integrado

### Autenticación y sesión
- **Login** con usuario o email (`user/login/`), y después se carga el perfil (`user/profile/`).
- **Registro** (`user/register/`):
  - El email es opcional.
  - En la app se aplican las mismas reglas de contraseña que el backend (Django 4.2): parecido con usuario o email, mínimo 8 caracteres, lista de 20.000 contraseñas comunes y solo números. Lo cubre el test `test/password_policy_test.dart`.
  - Los errores del API aparecen debajo de cada campo.
- **Logout** (`logout/`): manda el refresh token a la blacklist y borra la sesión local aunque el API falle.
- **Reset de contraseña**:
  - Solicitud con `user/password/reset/` y confirmación con `user/password/reset/confirm/`.
  - El deep link `parkea://reset-password?uid=..&token=..` está registrado en Android e iOS.
  - En debug hay una pantalla para pegar `uid` y `token` a mano.
- **Tokens**:
  - El access dura 60 min y el refresh 7 días; el refresh rota en cada uso.
  - `ApiClient` reintenta una vez con refresh si el API responde `token_not_valid`, y nunca hace dos refresh en paralelo.
  - Si el refresh es rechazado, la sesión se cierra y la app vuelve a la pantalla de auth.
  - Al volver a la app desde segundo plano también se revisa si el refresh expiró.

### Home
- **Feed de eventos** estilo Instagram con scroll infinito (`events/all/?page=N`):
  - Más recientes primero, 20 por página.
  - Pull-to-refresh, reintento si falla una página y mensaje al llegar al final.
- **Categorías** (`?category=MUSIC|CAMPING|ADVENTURE|WORKSHOPS`).
- **Búsqueda** (`?search=`):
  - Busca en nombre, descripciones, lugar, dirección y ciudad.
  - Espera 400 ms después de escribir y se combina con la categoría.
- **Promociones**: carrusel de banners 2:1 (`promotions/`). Si la promoción tiene evento enlazado, abre su detalle.

### Detalle de evento (`event/details/?id=`)
- Fecha con hora local, organizador, descripción, precio con su moneda (`currency`) y cupos disponibles.
- **Ubicación**:
  - Muestra lugar, dirección, ciudad y país.
  - Si hay coordenadas, un mapa de OpenStreetMap (`flutter_map`).
  - El botón "Cómo llegar" abre la app de mapas.

### Barra inferior
- Etiquetas de texto y soporte para lectores de pantalla, 64 px de alto y una píldora detrás del tab activo.
- Al volver a tocar Inicio, el feed sube al principio; si ya está arriba, se refresca.
- Un número sobre Tickets indica cuántos tickets próximos hay.
- El botón **+ Crear evento** aparece solo si `is_verified == true`.

### Tickets (`ticket/user/all/`)
- Próximos y anteriores, separados en la app por la fecha del evento y agrupados por mes.
- En el detalle del ticket se puede ver el evento y **cancelar la inscripción** (`DELETE ticket/cancel/<id>/`).

### Perfil
- **Eventos**: los eventos creados por el usuario (`events/owner/`).
- **Inscritos**: los eventos de sus tickets.
- **Foto de perfil**: al tocar el avatar se elige y sube una foto (`PUT user/profile/image/`, multipart `avatar`).

### Crear evento (`events/create/` y `events/update/image/<id>/`)
- Formulario con imagen, nombre, descripciones, fecha y hora, lugar, categoría, tipo de acceso, precio, moneda y cupo.
- Validaciones en la app: nombre obligatorio, fecha futura, precio mayor que 0 si es PAID, moneda ISO de 3 letras y cupo mayor o igual a 0.
- Los errores del API aparecen debajo de cada campo.
- Al publicar se refrescan el feed y "Mis eventos", y se abre el evento creado.

### Transversal
- Los textos nuevos están traducidos a los 7 idiomas (es, en, de, fr, pt, ru, zh).
- Enums del API en texto:
  - `cost_type`: `FREE | PAID | INVITATION | PRIVATE`
  - `category`: `MUSIC | CAMPING | ADVENTURE | WORKSHOPS`
  - `user_type`: `PERSON | COMMERCE`
- `EventDTO` acepta tanto el formato del API como el de los mocks, para las pantallas que aún usan mocks. Lo cubre el test `test/event_dto_test.dart`.

## Pasos que siguen

### App (no dependen del backend)
1. **Inscribirse a un evento desde el detalle.** El API ya tiene `POST ticket/enroll/`, con el payload envuelto en `{"body": {...}}` y `otp` para eventos PRIVATE. Hoy el botón "Get ticket" lleva a una compra que sigue en mock.
2. **Compra de tickets** (`ticket_purchase_page.dart`): sigue en mock. Además, el backend todavía no acepta inscripciones a eventos PAID ni INVITATION.
3. **Editar y borrar mis eventos** (`events/update/<id>/`). El backend ya lo permite y `events/owner/` devuelve el `otp` de los eventos PRIVATE.
4. **Filtros por ciudad y país** en el home (`?city=`, `?country=`). El API ya los tiene.
5. **"Eventos similares"** en el detalle: está comentado y usa el mock `FetchEventsUC`.
6. **Textos sin traducir**:
   - Los mensajes de error de los use cases están en español fijo.
   - Las etiquetas "All", "Promociones!", "Buen día!!" y otras del home están fijas.
   - Los errores que vienen del API llegan en inglés (Django).
7. **Limpieza de código**:
   - `second_home_feed_page.dart` no se usa.
   - `FetchEventsUC` y los mocks de `mock_data_utils.dart` solo los usan pantallas pendientes.
   - Hay imports y campos sin uso que señala `flutter analyze`.
8. **Tests**:
   - `test/widget_test.dart` es la plantilla del contador y siempre falla.
   - Faltan tests de los use cases (feed paginado, tickets, crear evento) con repositorios simulados.

### Dependen del backend (pendientes de decisión)
- **Filtro de tickets próximos y su conteo.** Hoy la app los separa y cuenta por su cuenta, con un máximo de 100 tickets por página.
- **Estado, precio pagado y código QR** de los tickets. Hoy solo se muestra el número de ticket.
- **Guardados / favoritos.** La pestaña está oculta y el corazón del detalle no hace nada.
- **Inscripción a eventos PAID e INVITATION**, y pagos.
- **Avatar del organizador** en el listado. Hoy el API solo manda el username y la app muestra su inicial.

### Antes de producción
- Configurar la URL de producción (HTTPS) con `API_BASE_URL`. El HTTP sin TLS solo está permitido en el manifest de debug.
- Revisar la política de uso de los tiles de OpenStreetMap para el volumen esperado. Con mucho tráfico conviene un proveedor de tiles propio o con clave.
- Revisar los logs: en debug se imprimen las respuestas completas, incluidos los tokens. En release el logger está apagado.
