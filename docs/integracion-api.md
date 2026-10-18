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
- **Organizador**: su foto (`owner_avatar`) en el detalle y en las tarjetas del feed; sin foto, su inicial.

### Tickets (`ticket/user/all/?when=upcoming|past`)
- Próximos y anteriores (una petición por pestaña), agrupados por mes. El número sobre la pestaña Tickets sale de `ticket/user/count/`.
- **Pase con QR**: en los tickets próximos y sin usar, el detalle muestra el `code` como QR (`parkea://tickets/<code>`) y como texto. Un ticket `USED` dice "Ya usaste este ticket"; si se pagó, se muestra `price_paid`. Al cancelar, el API borra el ticket.
- En el detalle del ticket se puede ver el evento y **cancelar la inscripción** (`DELETE ticket/cancel/<id>/`).
- El detalle del evento usa `my_ticket_id` para mostrar "Ver mi ticket" sin esperar la lista de tickets.

### Perfil
- **Eventos y Guardados**, en dos pestañas: los eventos creados por el usuario (`events/owner/`) y los que guardó con el corazón del detalle (`events/saved/`; `POST` y `DELETE events/saved/<id>/`). Los eventos en los que está inscrito se ven en la pestaña Tickets.
- **Foto de perfil** (`PUT user/profile/image/`, multipart `avatar`).
- **Editar perfil**: descripción corta (`bio`, máx. 160) y web (`link`, http/https, máx. 200) con `PATCH user/profile/update/`; la app antepone `https://` si falta y un link vacío lo borra. La web se muestra en el perfil y abre el navegador.

### Crear evento (`events/create/` y `events/update/image/<id>/`)
- Solo cuentas verificadas (`is_verified`), desde el botón **+** de la barra inferior.
- Validaciones en la app y errores del API debajo de cada campo.
- **Voluntariado** (`category: VOLUNTEERING`: siembra de árboles, ayuda social…): siempre gratis y abierto a todos. Al elegirlo, la app fija `cost_type: FREE` y oculta el selector de acceso. El API rechaza otro `cost_type` con 400 en ese campo y guarda el precio en 0. Las categorías de la app están en `EventCategory`.

### Transversal
- **Idiomas**: español (principal) e inglés, los mismos que el API. Todos los textos de la app están en los dos, incluidos los errores de los use cases (por `S.current`).
- **Errores**:
  - Sin red, la app muestra "No se pudo conectar con el servidor" y un botón de reintentar. `ApiClient` convierte el fallo de red en el mismo 408 de un timeout.
  - Los reintentos automáticos de Riverpod están desactivados, así los errores se ven enseguida.
- **Enums del API en texto**: `cost_type` (`FREE | PAID | INVITATION | PRIVATE`), `category` (`MUSIC | CAMPING | ADVENTURE | WORKSHOPS`) y `user_type` (`PERSON | COMMERCE`).
- **Calidad**:
  - `flutter analyze` sin avisos (`lib/generated` está excluido).
  - Se borraron las pantallas, mocks y datos de ejemplo que ya no se usaban. La integración con Yappy se conserva para pagos.
- **Tests**: 59. Los use cases reciben sus repositorios por providers (`lib/domain/usecases/repositories.dart`) y los tests usan una capa HTTP falsa (`test/helpers/fake_api.dart`).

## Pasos que siguen

### Gamificación (ver `docs/propuesta-gamificacion.md`)

**Fase 1: progreso del organizador** (solo app, terminada)
- [x] Tokens de color para progreso y hitos en `ParkeaColors`
- [x] Componente de barra de progreso animada y accesible
- [x] Barra de "evento completo" en el formulario de crear y editar, con la sugerencia de qué falta
- [x] Barra de inscritos en el detalle del evento propio ("12 de 20"; sin cupo límite, solo el número)
- [x] Celebración "¡Evento lleno!" la primera vez que el organizador abre su evento lleno
- [x] Textos en español e inglés
- [x] Tests de la lógica y de los componentes
- [x] Prueba en el emulador (claro, oscuro y animaciones reducidas)

**Fase 2: ticket como pase** (depende del backend)
- [ ] Backend: `POST ticket/checkin/` que pasa el ticket a `USED`
- [ ] QR del ticket con cuenta regresiva
- [ ] Escáner de check-in para el organizador

**Fase 3: logros y niveles** (depende del check-in en uso)
- [ ] Backend: `GET user/progress/` con asistencias, nivel y logros
- [ ] Pestaña "Logros" y nivel en el perfil
- [ ] Celebraciones de logro y de nivel

### Decisiones pendientes
- **Provincia en el registro**: el formulario la pide pero no se envía al API. ¿Se quita o se guarda en el backend?
- **Abrir la app sin red** lleva a la pantalla de login. La sesión se conserva, pero convendría mostrar "sin conexión" con reintentar.
- **Pagos e inscripción a eventos PAID e INVITATION**: el backend preparó una propuesta para decidir.
- **Orden del feed**: hoy es por fecha de creación. El backend puede agregar `?ordering=` para mostrar primero los más cercanos.
- **Nombres de países**: hoy se muestran con bandera y código (CO, MX).

### Antes de producción
Necesario para publicar en App Store y Google Play:
- **Eliminar cuenta**: las dos tiendas lo exigen a toda app con registro. Hace falta un endpoint en el backend y la opción en Ajustes.
- **Política de privacidad y términos**: las tiendas piden el enlace a la política de privacidad. La fila "Datos y privacidad" de Ajustes todavía no abre nada, y el registro no pide aceptar los términos.
- **Dominio para los enlaces**: compartir un evento manda `parkea://events/<id>`, que WhatsApp y otras apps no muestran como enlace. Con un dominio HTTPS se pueden usar App Links (Android) y Universal Links (iOS).

Además:
- Configurar la URL de producción (HTTPS) con `API_BASE_URL`. El HTTP sin TLS solo está permitido en el manifest de debug.
- Revisar la política de uso de los tiles de OpenStreetMap para el volumen esperado.
- Revisar los logs: en debug se imprimen las respuestas completas, incluidos los tokens. En release el logger está apagado.
