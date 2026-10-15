# Propuesta de gamificación para Parkea

Estado: **para decidir**. No hay nada implementado salvo la barra inferior (`31e4220`): ya usa tokens de color para "recompensa" y el contador de Tickets salta al inscribirse.

## Resumen

Parkea es una app para **descubrir eventos, inscribirse y asistir**, y para que los organizadores verificados los publiquen. La propuesta premia lo que genera valor real:

- **Asistentes:** ir a eventos, no solo inscribirse.
- **Organizadores:** publicar eventos completos y llenarlos.

Son 4 mecánicas en 3 fases. La primera se puede hacer ya con los datos que existen. Las otras dependen de que el backend registre la **asistencia** (check-in).

## El ciclo

> **Disparador** (un evento cerca de ti, de tu categoría) → **acción** (inscribirse y asistir) → **recompensa** (progreso visible, logro desbloqueado) → **inversión** (tu perfil refleja qué tipo de asistente eres y la app te recomienda mejor).

Para el organizador: **publica** → **completa el evento y llena cupos** → **celebra el lleno** → **vuelve a publicar**.

## Qué existe hoy y qué falta

| Dato | Estado |
|---|---|
| Inscripciones del usuario, con fecha, categoría, ciudad y país del evento | ✅ `ticket/user/all/` |
| Conteo de tickets próximos y pasados | ✅ `ticket/user/count/` |
| Cupos del evento (`capacity`, `available_spots`) | ✅ en todos los eventos |
| Código único por ticket (`code`) para el QR | ✅ desde `dae3031` |
| Estado del ticket `ACTIVE / CANCELLED / USED` | ✅ el campo existe, pero **nada marca `USED`** |
| **Check-in**: el organizador escanea el QR y el ticket pasa a `USED` | ❌ falta endpoint y pantalla |
| Progreso y logros del usuario calculados en el servidor | ❌ falta |

**Por qué la asistencia importa:** si se premia la inscripción, el sistema invita a inscribirse en todo y no ir. Eso deja a los organizadores con cupos ocupados por personas que no llegan. Por eso, las recompensas de asistente cuentan solo los tickets `USED`.

## Mecánicas propuestas

### 1. Progreso del organizador (fase 1, solo app)
Usa datos que ya existen, así que es la de menor costo y mayor impacto inmediato.
- **Evento completo**: en el formulario de crear y editar, una barra de "tu evento está al 80 %". Cuenta imagen, descripción, ubicación con mapa, categoría y cupo. La barra dice qué falta ("agrega una imagen: los eventos con imagen se ven más en el feed").
- **Cupos ocupados**: en el detalle de su evento, una barra "12 de 20 inscritos".
- **Hito "¡Evento lleno!"**: una celebración cuando `available_spots` llega a 0. Se muestra la próxima vez que el organizador abre el evento, no con una notificación.

### 2. Ticket como pase (fase 2, requiere check-in)
- El detalle del ticket muestra el **QR** (`code`) y una **cuenta regresiva** ("faltan 3 días").
- El organizador tiene un **escáner** en su evento. Al validar un ticket, el asistente ve "¡Asistencia registrada!" con una celebración breve.
- Es la base de las mecánicas 3 y 4. Además, sirve aunque no se haga la gamificación.

### 3. Logros por hitos (fase 3)
Son pocos, con hitos reales y variados. Están bloqueados hasta lograrlos y muestran cómo conseguirlos.

| Logro | Condición (tickets `USED`) |
|---|---|
| Primer evento | 1 asistencia |
| Habitual | 5 asistencias |
| Fiel | 15 asistencias |
| Explorador | eventos de las 4 categorías |
| Viajero | eventos en 3 ciudades distintas |
| Organizador | primer evento publicado con al menos 1 asistente |
| Casa llena | un evento propio lleno |

### 4. Nivel de asistente (fase 3)
- **Nuevo → Habitual (5) → Fan (15) → Embajador (30 asistencias)**. En el perfil siempre dice cuánto falta: "te faltan 3 eventos para Fan".
- **Beneficios**: en una primera etapa, solo reconocimiento (insignia en el perfil). Los beneficios reales los decide el negocio. Por ejemplo:
  - Inscripción anticipada en eventos con cupo limitado.
  - Prioridad en lista de espera, que hoy no existe.
  - Descuentos cuando haya pagos.

## Lo que no se hace

- **Rachas diarias o semanales**: nadie va a eventos todos los días, y solo generarían culpa.
- **Rankings públicos**: exponen qué eventos y en qué ciudades está cada persona.
- **Urgencia falsa**: el "quedan N cupos" solo se muestra con el número real del API.
- **Notificaciones de culpa** ("¡no pierdas tu nivel!"). Los logros y niveles **nunca se pierden**.
- **Premiar inscripciones sin asistencia**, ni cancelar y volver a inscribirse para sumar.
- **Logros visibles para otros:** por defecto son privados. Mostrarlos en el perfil público es una opción del usuario.

## Diseño en la app

- **Tokens**: la barra ya usa `reward` / `onReward` en `ParkeaColors`. Faltaría agregar los colores de las insignias (oro, plata, bronce) y `success`.
- **Componentes**, en `lib/app/widgets/gamification/`:
  - `ProgressBar`: el progreso del evento y los cupos.
  - `AchievementTile` / `AchievementGrid`: logros bloqueados y desbloqueados.
  - `LevelBadge`: el nivel en el encabezado del perfil.
  - `RewardToast` / `MilestoneDialog`: las celebraciones.
  - `TicketPass`: el QR con la cuenta regresiva.
- **Dónde va cada cosa:**
  - **Perfil:** nivel y una pestaña "Logros", junto a Eventos e Inscritos.
  - **Detalle del ticket:** el pase con el QR.
  - **Formulario de evento y detalle propio:** las barras de progreso del organizador.
  - **El home no cambia,** para que el feed siga limpio.
- **Celebraciones proporcionales:**
  - **Inscribirse:** el salto del contador, que ya existe.
  - **Asistencia o logro:** un mensaje breve.
  - **Subir de nivel o "evento lleno":** un diálogo.
  - En todos los casos hay vibración, y nada se anima si el sistema reduce las animaciones.
- **Accesibilidad:** lectura en voz alta de las barras y los logros ("Habitual, 3 de 5 eventos"), contraste AA y botones de al menos 48 dp.
- **Paquetes:** ninguno nuevo. Alcanza con las animaciones implícitas de Flutter. Lottie ya está en el proyecto para la celebración grande.

## Cambios en el backend (fases 2 y 3)

1. **Check-in**: `POST ticket/checkin/` con `{"code": "..."}`. Solo lo puede usar el dueño del evento, el mismo día del evento. Pasa el ticket a `USED` y es idempotente. Responde los datos básicos del asistente.
2. **Progreso del usuario**: `GET user/progress/` responde `{"attended": n, "level": "...", "next_level_at": n, "achievements": [{"code": "...", "unlocked_at": "..."}]}`.
   - El servidor es la fuente de verdad: evita trampas y no se pierde al reinstalar.
   - La app guarda una copia para mostrarla al instante.
3. **Logros nuevos**: aparecen en la respuesta del check-in, para celebrarlos en el momento.

## Fases y esfuerzo estimado

| Fase | Contenido | Depende de | Esfuerzo app |
|---|---|---|---|
| 1 | Progreso del organizador (mecánica 1) | nada | 1-2 días |
| 2 | Pase con QR y escáner de check-in (mecánica 2) | endpoint de check-in | 2-3 días |
| 3 | Logros y niveles (mecánicas 3 y 4) | check-in en uso + `user/progress/` | 3-4 días |

## Cómo medirlo

- **Asistencia:** % de inscripciones que terminan en `USED`. Debe subir y no bajar.
- **Frecuencia:** eventos asistidos por usuario al mes.
- **Retención:** % de usuarios que vuelven a inscribirse dentro de 30 días.
- **Calidad de los eventos:** % de eventos publicados completos (con imagen, descripción y ubicación).

## Decisiones que necesito

1. **Fases:** ¿empezamos por la 1? Es la que no depende del backend.
2. **Check-in:** ¿se hace? Además de la gamificación, sirve para controlar la entrada a los eventos.
3. **Niveles:** ¿solo reconocimiento al principio, o con beneficios reales? Si hay beneficios, ¿cuáles?
4. **Nombres:** ¿los nombres de niveles y logros te sirven, o prefieres otro tono?
5. **Visibilidad:** ¿los logros son privados por defecto, como propongo?
