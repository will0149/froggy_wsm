# Guía de Comentarios y Documentación de Código

Esta guía establece las mejores prácticas para agregar comentarios y documentación en el código del proyecto **CCT Management**.

## 📋 Tabla de Contenidos

1. [Tipos de Comentarios](#tipos-de-comentarios)
2. [Convenciones de Nombres](#convenciones-de-nombres)
3. [Ejemplos Prácticos](#ejemplos-prácticos)
4. [Cuándo Comentar](#cuándo-comentar)
5. [Checklist](#checklist)

---

## Tipos de Comentarios

### 1. Comentarios de Documentación (Doc Comments)

Usar para **clases, funciones, métodos y propiedades públicas**.

**Formato Recomendado:**
```dart
/// Descripción breve de qué hace la clase/función
///
/// Descripción más detallada si es necesario. Puede incluir:
/// - Parámetros y su propósito
/// - Valores de retorno
/// - Excepciones que puede lanzar
/// - Ejemplos de uso
///
/// **Ejemplo:**
/// ```dart
/// final items = await fetchItems(limit: 10);
/// ```
///
/// Ver también: [OtherClass], [relatedFunction]
class MyClass {

  /// Obtiene una lista de items desde la base de datos
  ///
  /// Parámetros:
  /// - [limit]: Número máximo de items a retornar (default: 20)
  /// - [offset]: Número de items a saltar (default: 0)
  ///
  /// Retorna: Una lista de [ItemEntity] ordenada por fecha de creación
  ///
  /// Lanza [DatabaseException] si hay error en la base de datos
  Future<List<ItemEntity>> fetchItems({
    int limit = 20,
    int offset = 0,
  }) async {
    // Implementation
  }
}
```

**Ventajas:**
- ✅ Mostrado en hover del IDE
- ✅ Documentación auto-generada con `dartdoc`
- ✅ Visible en IntelliSense

### 2. Comentarios de Línea

Usar para **explicar lógica compleja o decisiones no obvias**.

**Formato:**
```dart
// Inicializar la conexión con reintentos exponenciales
// para mejorar la confiabilidad en redes inestables
await _initializeConnection(maxRetries: 3);

// BUG FIX: Se agregó validación de null porque algunos
// items pueden no tener descripción (issue #123)
final description = item.description ?? 'Sin descripción';
```

### 3. Comentarios Especiales

**TODO:** Para tareas pendientes
```dart
// TODO(usuario): Implementar paginación cuando API lo soporte
// TODO(issue-#456): Agregar caché de resultados
```

**FIXME:** Para problemas conocidos
```dart
// FIXME: Esta función es lenta O(n²), optimizar con algoritmo más eficiente
// FIXME(performance): El provider se recrea demasiadas veces
```

**NOTE:** Para recordatorios importantes
```dart
// NOTE: Este código debe mantener compatibilidad con versión anterior
// NOTE: La base de datos puede estar vacía en primera ejecución
```

**DEPRECATED:** Para código obsoleto
```dart
/// @deprecated Use [newFunction] en su lugar
/// Se eliminará en versión 2.0
Future<void> oldFunction() { }
```

### 4. Comentarios de Bloque

Para secciones grandes o explicaciones detalladas:

```dart
/// ============================================================================
/// SINCRONIZACIÓN DE DATOS
/// ============================================================================
///
/// Este módulo maneja la sincronización de datos entre la API y la BD local.
///
/// Flujo:
/// 1. Validar conexión a internet
/// 2. Descargar datos nuevos de la API
/// 3. Limpiar tabla temporal
/// 4. Insertar datos en tabla local
/// 5. Actualizar UI
///
/// Ver arquitectura en ARCHITECTURE.md
/// ============================================================================
```

---

## Convenciones de Nombres

### Para Comentarios

```dart
// ✅ BIEN: Claro y específico
// Limpiar tabla temporal antes de cargar nuevos datos

// ❌ MAL: Vago o innecesario
// hacer algo
// esto es importante

// ✅ BIEN: Explica el "por qué"
// Se limpia primero para evitar duplicados y datos inconsistentes
// entre versiones de API

// ❌ MAL: Solo repite el código
// Incrementar contador
counter++;
```

---

## Ejemplos Prácticos

### Ejemplo 1: Función con Lógica Compleja

```dart
/// Procesa items en lotes para evitar sobrecargar la memoria
///
/// Utiliza un patrón batch-processing que:
/// - Divide la lista en chunks de [batchSize] elementos
/// - Procesa cada lote secuencialmente
/// - Libera memoria entre lotes
///
/// Parámetros:
/// - [items]: Lista de items a procesar
/// - [batchSize]: Tamaño de cada lote (default: 50)
///
/// Retorna: Número total de items procesados exitosamente
Future<int> processBatch(List<Item> items, {int batchSize = 50}) async {
  int processedCount = 0;

  // Dividir en lotes para no saturar la memoria
  for (int i = 0; i < items.length; i += batchSize) {
    final end = (i + batchSize > items.length) ? items.length : i + batchSize;
    final batch = items.sublist(i, end);

    try {
      // Procesar lote actual
      for (final item in batch) {
        await _processItem(item);
        processedCount++;
      }

      // Liberar recursos después de cada lote
      // Esto previene memory leaks en procesamiento de datos grandes
      await Future.delayed(Duration.zero);
    } catch (e) {
      logger.e('Error procesando lote: $e');
      continue;
    }
  }

  return processedCount;
}
```

### Ejemplo 2: Provider con Lógica de Reactividad

```dart
/// Provider para la lógica de items de Alegra
///
/// Mantiene una instancia singleton de [ItemsLogicImpl] que extiende
/// [ChangeNotifier], permitiendo que los widgets escuchen cambios en:
/// - [fetchCount]: Número de items descargados
/// - [totalItems]: Total de items en el servidor
///
/// La reactividad es crucial para mostrar progreso durante sincronización.
///
/// **Patrón de uso:**
/// ```dart
/// final logic = ref.watch(itemsLogicProvider);
/// Text('Cargando ${logic.fetchCount}/${logic.totalItems}')
/// ```
final itemsLogicProvider =
    NotifierProvider<_ItemsLogicNotifier, ItemsLogicImpl>(
        _ItemsLogicNotifier.new);

/// Notifier para mantener singleton de ItemsLogicImpl
///
/// Usa patrón singleton con null-coalescing (??=) para garantizar
/// que solo existe una instancia durante la vida de la aplicación.
/// Esto es importante para mantener el estado consistente.
class _ItemsLogicNotifier extends Notifier<ItemsLogicImpl> {
  static ItemsLogicImpl? _instance;

  @override
  ItemsLogicImpl build() {
    // Singleton pattern: crear solo si no existe
    _instance ??= ItemsLogicImpl();
    return _instance!;
  }
}
```

### Ejemplo 3: Método con Manejo de Errores

```dart
/// Limpia la tabla temporal de items alegra
///
/// Se ejecuta cada vez que el usuario navega a la página de inventario
/// para garantizar que no haya datos stale de sincronizaciones anteriores.
///
/// **Nota importante:** Este proceso es asincrónico pero no bloquea
/// la navegación. Los errores se loguean pero no se lanzan.
Future<void> _clearTemporaryTable() async {
  try {
    // Ejecutar limpieza de tabla temporal
    await ref.read(alegraItemsDropProvider.future);

    if (kDebugMode) {
      logger.i("Limpieza de tabla temporal realizada en AlegraInventoryPage");
    }
  } catch (e) {
    // Loguear error pero no fallar: la UI debe seguir funcionando
    // incluso si hay problema con la limpieza
    if (kDebugMode) {
      logger.e("Error al limpiar tabla temporal: $e");
    }

    // En producción, se podría enviar a analytics pero no se lanza excepción
    // para no interrumpir la experiencia del usuario
  }
}
```

---

## Cuándo Comentar

### ✅ SIEMPRE Comentar

1. **Lógica compleja o no obvia**
   ```dart
   // Usar ??= para implementar patrón singleton
   // y evitar recrear la instancia en cada acceso
   _instance ??= ItemsLogicImpl();
   ```

2. **Decisiones de arquitectura**
   ```dart
   // Usar NotifierProvider en lugar de Provider porque ItemsLogicImpl
   // extiende ChangeNotifier y necesita notificar cambios reactivos
   ```

3. **Cambios que afectan múltiples componentes**
   ```dart
   // IMPORTANTE: Si cambias esta estructura, actualiza también
   // ItemsLogicImpl y el parseador en items_logic.dart
   ```

4. **Workarounds o hacks**
   ```dart
   // WORKAROUND: Flutter 3.22 tiene bug con onPopInvoked,
   // usar onPopInvokedWithResult en su lugar (issue: flutter/123456)
   ```

5. **Métodos públicos (siempre con doc comments)**
   ```dart
   /// Obtiene items desde la API
   Future<List<Item>> fetchItems() async { }
   ```

### ❌ NO Comentar (Código Auto-Explicativo)

```dart
// ❌ MAL: Comentario innecesario
final name = item.name; // Obtener nombre

// ✅ BIEN: Sin comentario porque el código es claro
final itemCount = items.length;

// ❌ MAL: Comentario obvio
// Incrementar contador
counter++;

// ✅ BIEN: Sin comentario (es obvio) O CON CONTEXTO si es importante
// Incrementar solo para items válidos (excluyendo duplicados)
if (isValid) counter++;
```

---

## Checklist

Antes de hacer commit, verifica:

### Para Funciones y Clases Públicas
- [ ] ¿Tiene doc comment (///)?
- [ ] ¿Describe qué hace?
- [ ] ¿Incluye parámetros y retorno?
- [ ] ¿Tiene ejemplos si es complejo?

### Para Lógica Compleja
- [ ] ¿Explicar el "por qué" no es obvio?
- [ ] ¿El código tiene pasos que merecen comentarios?
- [ ] ¿Hay decisiones arquitectónicas que explique?

### Para Cambios de Código
- [ ] ¿Hay comentarios sobre cambios importantes?
- [ ] ¿Se documentaron workarounds?
- [ ] ¿Se actualizaron doc comments si corresponde?

### General
- [ ] ¿Los comentarios son claros y en español/inglés consistente?
- [ ] ¿Evité comentarios obvios?
- [ ] ¿Usé convenciones del proyecto (TODO, FIXME, etc)?

---

## Mejores Prácticas Adicionales

### 1. Mantener Comentarios Actualizados
```dart
// ❌ MAL: Comentario desactualizado
// Obtiene items de la BD local
// Nota: NO soporta paginación
Future<List<Item>> fetchItems() async {
  // Código que SÍ soporta paginación
}

// ✅ BIEN: Comentario actualizado
/// Obtiene items de la BD local con soporte para paginación
///
/// Parámetros:
/// - [limit]: Número máximo de items
/// - [offset]: Posición inicial
Future<List<Item>> fetchItems({required int limit, required int offset}) async {
}
```

### 2. Evitar Comentarios Redundantes
```dart
// ❌ MAL: El código ya lo dice
bool isValid = true;  // Establecer isValid en true

// ✅ BIEN: Explicar el "por qué"
bool isValid = true;  // Asumir válido por defecto, validaremos después con API
```

### 3. Usar Markdown en Doc Comments
```dart
/// Procesa items aplicando los siguientes pasos:
/// 1. Validar entrada
/// 2. Limpiar datos
/// 3. Guardar en BD
///
/// **Importante:** Este método es lento para listas > 1000 items
///
/// Ver: [documentation](https://example.com)
```

---

## Referencias

- [Dart Documentation Best Practices](https://dart.dev/guides/language/effective-dart/documentation)
- [Flutter Code Style Guide](https://github.com/flutter/flutter/wiki/Style-guide-for-Flutter-repo)
- Arquitectura del proyecto: `CLAUDE.md`

---

**Última actualización:** 2025-10-24
**Autor:** Claude Code
**Versión:** 1.0
