# Flujo de pantallas

Diagramas de navegación por pantalla, sacados del código (`lib/domain/routers/app_router.dart` y las llamadas `pushNamed`/`goNamed`/`showDialog` de cada pantalla). Están en Mermaid: GitHub y Android Studio los muestran como diagramas.

**Leyenda:** los rectángulos son pantallas, los rombos son decisiones, los bloques redondeados son diálogos u hojas inferiores, y las líneas punteadas salen de la app (navegador, mapas, ajustes del sistema).

## 1. Mapa general

La sesión decide dónde empieza la app: el `redirect` del router escucha el estado de `restAuthUC`.

```mermaid
flowchart TD
    start(["Abrir la app"]) --> splash["Splash<br/>/auth/splash"]
    splash --> status{"Estado de la sesión"}
    status -->|"primer uso"| welcome["Bienvenida<br/>/welcome"]
    status -->|"sin sesión"| auth["Auth<br/>/auth"]
    status -->|"error de login"| login["Login"]
    status -->|"con sesión"| shell

    welcome -->|"Comenzar"| auth
    auth -->|"inicia sesión o se registra"| shell

    subgraph shell["Barra inferior (StatefulShellRoute)"]
        direction LR
        home["Inicio<br/>/"]
        map["Mapa<br/>/map"]
        create(("+ Crear"))
        tickets["Tickets<br/>/tickets"]
        profile["Perfil<br/>/profile"]
    end

    create -.->|"solo cuentas verificadas"| createPage["Crear evento<br/>pantalla completa"]
    home & map & tickets --> detail["Detalle del evento"]
    profile --> detail
```

## 2. Autenticación

Usa `AuthTheme` (el diseño anterior, congelado). Con sesión, cualquier ruta de auth redirige al Inicio.

```mermaid
flowchart TD
    auth["Auth<br/>logo y dos botones"] -->|"Iniciar sesión"| login["Login<br/>usuario o email + contraseña"]
    auth -->|"Registrarse"| signup["Registro"]

    login -->|"¿Olvidaste tu contraseña?"| reset["Recuperar contraseña<br/>email"]
    login -->|"credenciales correctas"| home["Inicio"]
    login -->|"error"| loginErr(["Snackbar con el error<br/>se queda en Login"])

    signup -->|"cuenta creada"| home
    signup -->|"errores por campo"| signup

    reset -->|"correo enviado"| login
    reset -->|"Ya tengo el código"| confirm["Nueva contraseña<br/>uid + token"]
    deeplink(["Enlace del correo<br/>parkea://reset-password"]) --> confirm
    confirm -->|"contraseña cambiada"| login
```

## 3. Barra inferior

Inicio, Mapa, Tickets y Perfil son ramas del router y cada una conserva su pila. "Crear" es una acción: solo aparece si `is_verified`, y entonces queda al centro. Sin verificar, la barra tiene 4 tabs.

```mermaid
flowchart LR
    bar{"Toque en la barra"} -->|"otro tab"| switchTab["Cambia de rama<br/>conserva su estado"]
    bar -->|"el tab activo"| reselect["Vuelve a la raíz de la rama<br/>Inicio: sube al principio<br/>Mapa: recentra"]
    bar -->|"+ Crear"| createPage["Crear evento"]
    back{"Botón atrás<br/>en la raíz"} --> exit(["Pide confirmar<br/>y sale de la app"])
```

## 4. Inicio

```mermaid
flowchart TD
    home["Inicio<br/>saludo, promociones y feed"] --> search["Buscador<br/>filtra al escribir"]
    home --> cats["Chips de categoría<br/>Música, Camping, Aventura,<br/>Talleres, Voluntariado"]
    home --> loc(["Hoja: país y ciudad<br/>events/locations/"])
    search & cats & loc --> feed["Feed filtrado<br/>scroll infinito"]

    home -->|"toca una promoción"| detail["Detalle del evento"]
    feed -->|"toca un evento"| detail
    home -->|"desliza hacia abajo"| refresh(["Recarga el feed<br/>y las promociones"])
```

## 5. Mapa

```mermaid
flowchart TD
    open["Mapa"] --> perm{"Permiso de ubicación"}
    perm -->|"concedido"| near["Eventos ordenados por distancia<br/>vista: usuario + 5 más cercanos"]
    perm -->|"negado"| banner["Aviso: Activar<br/>vista: todos los eventos"]
    perm -->|"bloqueado o GPS apagado"| bannerSettings["Aviso: Ajustes"]

    banner -->|"Activar"| perm
    bannerSettings -.->|"Ajustes"| sysSettings(["Ajustes del sistema"])
    sysSettings -.-> perm

    near & banner & bannerSettings --> bubble{"Toca una burbuja"}
    bubble --> card["Tarjeta del evento<br/>foto, fecha, precio y distancia"]
    card -->|"toca la tarjeta"| detail["Detalle del evento"]
    card -->|"toca el mapa"| near

    near -->|"Mi ubicación o tocar el tab Mapa"| recenter(["Recentra"])
```

## 6. Detalle del evento

Es el mismo para todos; cambian las acciones según quién lo ve y el tipo de acceso.

```mermaid
flowchart TD
    detail["Detalle del evento<br/>banner, fecha, lugar, organizador,<br/>descripción, ubicación y similares"] --> who{"¿Es el organizador?"}

    who -->|"no"| enroll{"Botón Inscribirse"}
    enroll -->|"ya tiene ticket"| myTicket(["Hoja: mi ticket"])
    enroll -->|"pasado, propio, invitación,<br/>sin cupos o de pago"| blocked["Botón deshabilitado<br/>con el motivo"]
    enroll -->|"gratis o voluntariado"| enrolled(["Inscrito<br/>snackbar y cupos actualizados"])
    enroll -->|"privado"| code(["Diálogo: código de acceso"])
    code -->|"código válido"| enrolled
    code -->|"código inválido"| code

    who -->|"sí"| owner["Tarjeta de inscritos<br/>y código del evento privado"]
    owner -->|"evento lleno, primera vez"| party(["Diálogo: ¡Evento lleno!"])
    owner -->|"Editar evento"| edit["Editar evento"]
    owner -->|"Eliminar"| confirmDel(["Diálogo: confirmar"])
    confirmDel -->|"eliminado"| back(["Vuelve atrás"])

    detail -.->|"Cómo llegar o tocar el mapa"| maps(["Google Maps"])
    detail -->|"evento similar"| detail
    detail -->|"desliza hacia abajo"| reload(["Recarga evento, tickets y cupos"])
```

> El pago (`YappyPaymentPage`) existe en el código, pero ninguna pantalla lo abre todavía: los eventos de pago muestran "Pagos próximamente".

## 7. Crear y editar evento

A pantalla completa, sin la barra inferior.

```mermaid
flowchart TD
    form["Crear o editar evento<br/>banner, nombre, descripciones,<br/>fecha, lugar y cupo"] --> cat{"Categoría"}
    cat -->|"Voluntariado"| free["Acceso fijo: Gratis<br/>aviso en lugar del selector"]
    cat -->|"otra o ninguna"| access{"Tipo de acceso"}
    access -->|"Pago"| price["Precio y moneda"]
    access -->|"Gratis, Invitación o Privado"| ready
    free & price --> ready["Tarjeta de evento completo<br/>sugiere lo que falta"]

    ready -->|"Publicar o Guardar"| valid{"¿Válido?"}
    valid -->|"errores en la app o del API"| form
    valid -->|"creado"| newDetail["Cierra y abre<br/>el detalle del evento nuevo"]
    valid -->|"editado"| backDetail["Vuelve al detalle"]
```

## 8. Tickets

```mermaid
flowchart TD
    tickets["Tickets"] --> tabs{"Pestaña"}
    tabs -->|"Próximos"| upcoming["Agrupados por mes<br/>el más cercano primero"]
    tabs -->|"Anteriores"| past["Agrupados por mes<br/>en gris"]
    upcoming & past -->|"toca un ticket"| sheet(["Hoja: detalle del ticket<br/>QR del pase si es próximo y sin usar"])
    sheet -->|"Ver evento"| detail["Detalle del evento"]
    sheet -->|"Cancelar inscripción<br/>solo próximos"| confirm(["Diálogo: confirmar"])
    confirm -->|"cancelado"| tickets
```

## 9. Perfil, Editar perfil y Ajustes

```mermaid
flowchart TD
    profile["Perfil<br/>encabezado de marca, nombre,<br/>descripción y web"] -->|"toca el avatar"| gallery(["Galería: elegir foto<br/>y subirla"])
    profile -->|"Editar perfil"| editProfile["Editar perfil<br/>descripción y web"]
    profile -.->|"toca la web"| browser(["Navegador"])
    profile -->|"Mis eventos"| detail["Detalle del evento"]
    profile -->|"engranaje"| settings["Ajustes"]

    editProfile -->|"guardado"| profile
    editProfile -->|"errores por campo"| editProfile

    settings --> theme["Switch claro / oscuro"]
    settings -->|"Idioma"| language(["Hoja: del dispositivo,<br/>Español o English"])
    settings -->|"Acerca de"| about(["Diálogo: Acerca de"])
    settings -->|"Cerrar sesión"| logoutConfirm(["Diálogo: confirmar"])
    logoutConfirm -->|"sí"| auth["Auth"]
```

La tarjeta "Tu perfil" y las filas Notificaciones, Ayuda y Privacidad de Ajustes todavía no llevan a ninguna pantalla.
