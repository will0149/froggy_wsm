# Propuesta de design system para Parkea

Estado: **aprobada con las opciones recomendadas** (barra blanca, Inscribirse azul, fondo gris cálido y modo oscuro en la misma pasada). Fase 1 implementada. Las pantallas de auth (bienvenida, login, registro y recuperar contraseña) **no cambian**.

## Resumen

El login ya tiene un lenguaje claro: **azul petróleo para todo lo que se toca**, superficie blanca, campos tipo píldora y el **naranja como marca**, en la forma del fondo y no en los controles. El resto de la app no sigue esa regla: el naranja aparece en botones, textos, switches, la barra inferior y los encabezados, mezclado con grises sueltos de Material.

La propuesta convierte esa regla del login en tokens y componentes del tema, y después migra las pantallas para que dejen de definir colores a mano.

> **Azul = acción. Naranja = marca y emoción. Neutros = estructura.**

## Diagnóstico

| Problema | Dato |
|---|---|
| Colores puestos a mano en pantallas | **123** usos de `Colors.grey/white/black/red…` y **63** de `parkeaOrange` en `lib/app`. Solo 6 pantallas leen `colors(context)`. |
| El naranja hace de todo | botón por defecto (`ElevatedButton` = `secondary`), Inscribirse, switch, cerrar sesión, encabezado de Tickets, barra inferior, precio, filtros. No queda claro qué es acción y qué es decoración. |
| **Contraste insuficiente** (WCAG AA pide 4.5:1 para texto) | Blanco sobre naranja `#FB820F`: **2.53:1**, en las etiquetas de la barra inferior, el botón Inscribirse y los badges. Naranja sobre blanco: 2.53:1, en el precio del mapa y "Cerrar sesión". |
| Modo oscuro | El azul `#037E9C` sobre el fondo oscuro `#332F2F` da **2.81:1**. Los botones y links casi no se leen. |
| Radios | 12 valores distintos (2, 4, 5, 8, 10, 12, 15, 16, 20, 22, 24, 30). |
| Botones | 4 tipos con estilos sueltos: 24 `ElevatedButton`, 10 `FilledButton`, 5 `OutlinedButton` y 18 `TextButton`. Muchos llevan colores locales. |
| Campos | El tema global usa píldora (radio 30, borde azul de 2.5). En campos de varias líneas (descripción) la píldora se deforma, y algunos formularios la sobrescriben (Editar perfil usa el borde por defecto de Material). |
| Tipografía | `text_theme.dart` solo asigna color: no hay escala de tamaños ni pesos propios. Cada pantalla hace `copyWith(fontWeight: bold)`. |
| Dos sistemas de modo oscuro | `tickets_page` y `user_settings` leen `appThemeModeProvider` para elegir colores en vez de usar el tema. |

## Principios

1. **Un color de acción.** Botones, links, foco, selección y el tab activo usan azul. Si es azul, se puede tocar.
2. **El naranja no lleva texto chico.** Va en el logo, las ilustraciones, las formas de fondo, el botón "Crear" de la barra, las celebraciones y los acentos. Si un elemento naranja lleva texto, el texto es oscuro (5.2:1) o el fondo es el naranja profundo `#C2410C` con texto blanco (5.2:1).
3. **Neutros con calidez.** Una escala derivada del negro de marca `#332F2F`, en vez de `Colors.grey[400/600]`.
4. **Nada de colores en las pantallas.** Las pantallas usan `Theme.of(context)` y `colors(context)`, nunca `Colors.x` ni `parkeaOrange`.

## Tokens

### Color

| Token | Claro | Oscuro | Uso |
|---|---|---|---|
| `primary` | `#037791` (5.2:1 sobre blanco, 4.8:1 sobre `background`) | `#4FB3CB` (7.0:1 sobre el fondo) | botones, links, foco, tab activo. Es el azul del login un tono más oscuro: `#037E9C` da 4.3:1 sobre el fondo gris y no alcanza para los links. |
| `onPrimary` | `#FFFFFF` | `#0B2A33` | texto sobre `primary` |
| `primaryContainer` | `#E6F3F6` | `#0E3D4A` | chip seleccionado, fondos suaves |
| `onPrimaryContainer` | `#055E74` | `#CDEBF2` | texto sobre el container |
| `brand` | `#FB820F` | `#FB820F` | forma de fondo, ilustración, botón Crear, celebraciones; **sin texto blanco** |
| `brandStrong` | `#C2410C` (5.2:1 con blanco) | `#FB923C` | cuando el naranja lleva texto: insignia de precio, contador del badge |
| `brandContainer` | `#FFF4E8` | `#3D2A1A` | fondo de logros y recompensas |
| `onBrandContainer` | `#9A3412` (6.7:1) | `#FED7AA` | texto sobre el container |
| `surface` | `#FFFFFF` | `#1E1B1B` | tarjetas, hojas, inputs |
| `background` | `#F7F5F4` | `#151313` | fondo de pantalla, para separar las tarjetas sin sombra fuerte |
| `onSurface` | `#332F2F` (13.2:1) | `#F2EFEE` | texto principal |
| `onSurfaceMuted` | `#6B6464` (5.3:1 sobre `background`) | `#B3ABAA` | texto secundario (reemplaza `grey[600]`) |
| `outline` | `#D9D3D1` | `#4A4545` | bordes y divisores (reemplaza `grey[300]`) |
| `success` / `warning` / `error` | `#2E7D32` / `#B45309` / `#B3261E` | `#66BB6A` / `#FBBF24` / `#F2B8B5` | estados |

Los tokens `navBar`, `reward` y `progress` de `ParkeaColors` pasan a ser alias de estos.

### Forma, espacio y tipografía

- **Radios**: `sm 8` (badges), `md 12` (botones e inputs de varias líneas), `lg 16` (tarjetas y hojas), `xl 24` (encabezados y hojas inferiores) y `full` (píldoras: inputs de una línea y chips).
- **Espacios**: escala de 4 (4, 8, 12, 16, 24, 32), con 16 de margen lateral en todas las pantallas.
- **Tipografía (GothicA1)**:
  - Títulos: `headlineSmall` 24/w700 y `titleLarge` 20/w700.
  - Subtítulos: `titleMedium` 16/w600.
  - Texto: `bodyLarge` 16/w400 y `bodyMedium` 14/w400.
  - Etiquetas: `labelLarge` 14/w600, que se usa en los botones.

  Con esta escala, cada pantalla deja de hacer `copyWith(fontWeight: bold)`.

## Componentes

Se definen una vez en `app_theme.dart`.

| Componente | Propuesta |
|---|---|
| **Botón principal** | `FilledButton` azul, alto 48, radio 12 y texto `labelLarge`. Ocupa todo el ancho en formularios. Reemplaza los `ElevatedButton` naranjas. |
| **Secundario** | `OutlinedButton` con borde azul de 1.5. |
| **Terciario** | `TextButton` azul. |
| **Destructivo** | `FilledButton` con `error` (cancelar inscripción, cerrar sesión). |
| **Input de una línea** | Píldora como el login: relleno `surface`, borde `outline` de 1.5 en reposo, **azul de 2.5 al enfocar** y `error` de 2.5. La etiqueta es azul solo al enfocar; en reposo usa `onSurfaceMuted`. |
| **Input de varias líneas** | Mismo estilo con radio 12, para que la descripción no se deforme. |
| **Chips (filtros)** | Píldora con borde `outline`. Seleccionado: `primaryContainer` y texto `onPrimaryContainer`. Los filtros de categoría y ubicación hoy son naranjas. |
| **Tarjetas** | `surface` sobre `background`, radio 16, sombra suave o solo borde `outline`. |
| **Encabezados** | AppBar `surface` con título `onSurface`. Se quitan los encabezados de gradiente naranja (Tickets) y azul (Perfil). La marca aparece en un solo lugar: el encabezado del Perfil con la forma naranja del login. |
| **Barra inferior** | `surface` con borde superior `outline`. Tab activo azul con indicador `primaryContainer`. **"Crear"** es un círculo `brand` con el "+" en `#332F2F` (5.2:1) y es el único acento de marca. El "+" naranja sobre blanco de hoy da 2.5:1 y no llega al 3:1 que piden los íconos. |
| **Badge y recompensas** | `brandStrong` con texto blanco. Las celebraciones usan `brandContainer`. |
| **Snackbars y diálogos** | Snackbar `onSurface` invertido y error con `error`. Diálogos de radio 24 con acciones azules. |
| **Precio** | Insignia `brandContainer` con texto `onBrandContainer`: el naranja se ve, pero se lee bien. |

## Cómo queda cada pantalla

- **Home**: chips de categoría y ubicación en azul suave. Las tarjetas mantienen la imagen y el precio va en la insignia naranja clara.
- **Detalle de evento**: "Inscribirse" con el botón principal azul. El precio y la fecha van en insignias. Los botones sobre la imagen (volver y compartir) quedan como están.
- **Tickets**: AppBar plano y tabs con indicador azul. El QR y la cuenta regresiva, cuando existan, usan `brandContainer`.
- **Perfil**: el encabezado toma la forma naranja del login sobre el azul, que es el único lugar donde se repite la identidad de auth. "Editar perfil" es un botón secundario.
- **Ajustes**: secciones con tarjetas `surface` y `outline`. El switch es azul y "Cerrar sesión" usa el estilo destructivo, no naranja.
- **Crear o editar evento y Editar perfil**: los mismos inputs y un botón principal de ancho completo.
- **Mapa**: la burbuja seleccionada tiene borde azul y el punto del usuario sigue azul.

## Plan de implementación

Cada fase es un commit y se valida en el emulador.

1. ✅ **Tokens y login congelado.**
   - Nuevo `ParkeaColors`, y `ColorScheme` construido desde los tokens (sin `fromSeed`, para que no invente tonos).
   - `ParkeaRadius`, `ParkeaSpacing` y la escala tipográfica.
   - `AuthScaffold` envuelve sus formularios en un `Theme` con los valores actuales, para que **el login no cambie**.
2. **Componentes del tema**: botones, inputs, chips, tarjetas, AppBar, barra inferior, snackbars y diálogos. Con esto ya cambia gran parte de la app sin tocar las pantallas.
3. **Migración de pantallas.** Se quitan los `Colors.x`, `parkeaOrange` y los `isDarkMode` locales, en este orden: Ajustes, Detalle, Tickets, Perfil, Home, Crear evento y Mapa.
4. **Guardia.** Un test que busque `Colors.grey`, `parkeaOrange` y `Color(0x` fuera de `lib/app/themes/` y falle si aparecen. Así el sistema no se vuelve a romper.

## Decisiones

1. **Barra inferior**: ¿blanca con "Crear" naranja (recomendado: cumple el contraste y se parece al login) o mantener la barra naranja con el texto oscuro?
2. **Inscribirse**: ¿botón principal azul, como toda acción (recomendado), o un botón de marca `brandStrong` con texto blanco para destacarlo?
3. **Fondo de pantalla**: ¿gris cálido `#F7F5F4` con tarjetas blancas (recomendado) o blanco puro como hoy?
4. **Modo oscuro**: ¿se ajusta en esta misma pasada (recomendado, porque hoy el azul no cumple el contraste) o después?
