import 'dart:io';

import 'package:csv/csv.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

/// Utilidades para exportar datos a CSV
class CsvExportUtils {
  /// Exporta una lista de datos a un archivo CSV y lo comparte
  ///
  /// [fileName]: nombre del archivo sin extensión
  /// [headers]: encabezados de las columnas
  /// [rows]: datos a exportar (lista de listas)
  static Future<void> exportAndShareCsv({
    required String fileName,
    required List<String> headers,
    required List<List<dynamic>> rows,
  }) async {
    try {
      // Crear la lista con encabezados
      final List<List<dynamic>> csvData = [headers, ...rows];

      // Convertir a CSV
      final String csv = const ListToCsvConverter(fieldDelimiter: ";").convert(csvData);

      // Obtener el directorio temporal
      final Directory tempDir = await getTemporaryDirectory();
      final String filePath = '${tempDir.path}/$fileName.csv';

      // Crear el archivo
      final File file = File(filePath);
      await file.writeAsString(csv);

      // Compartir el archivo
      await Share.shareXFiles(
        [XFile(filePath)],
        subject: fileName,
        text: 'Exportación de $fileName',
      );
    } catch (e) {
      throw Exception('Error al exportar CSV: $e');
    }
  }

  /// Convierte los datos de comparación a formato CSV
  static List<List<dynamic>> convertComparisonDataToCsv({
    required List<Map<String, dynamic>> items,
  }) {
    return items.map((item) {
      final difference = (item['difference'] as int?) ?? 0;
      return [
        item['name'] ?? '-',
        item['reference'] ?? '-',
        item['countQty']?.toString() ?? '0',
        item['serviceQty']?.toString() ?? '0',
        difference.toString(),
      ];
    }).toList();
  }
}
