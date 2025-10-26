import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:froggy_soft/device/utils/logger_config.dart';
import 'package:froggy_soft/domain/providers/alegra_items_provider.dart' show alegraItemsDropProvider;
import 'package:froggy_soft/domain/providers/alegra_recount_provider.dart';

import '../../widgets/scaffolds/safe_scaffold.dart';

/**
 * Made for froggy_soft.
 * By User: josedominguez
 * Date: 10/15/25
 */

class AlegraComparisonTablePage extends ConsumerStatefulWidget {
  static String get routeName => 'alegra/stocks';
  static String get routeLocation => routeName;

  const AlegraComparisonTablePage({super.key});

  @override
  AlegraComparisonTablePageState createState() =>
      AlegraComparisonTablePageState();
}

class AlegraComparisonTablePageState
    extends ConsumerState<AlegraComparisonTablePage> {
  int _currentPage = 0;
  final int _rowsPerPage = 10;

  @override
  void initState() {
    super.initState();
    // Espera a que el widget se renderice completamente antes de invalidar el provider
    // Esto es necesario porque no se pueden modificar providers durante initState
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Invalida el provider para forzar una recarga de datos cada vez que se inicia la pantalla
      ref.invalidate(recountComparisonProvider);
    });
  }

  @override
  Widget build(BuildContext context) {
    final comparisonAsync = ref.watch(recountComparisonProvider);

    return SafeScaffold(
      appBar: AppBar(
        title: Text(
          "Comparación de Reconteo",
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      child: comparisonAsync.when(
        data: (items) {
          if (items.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.inbox_outlined, size: 64, color: Colors.grey),
                  const SizedBox(height: 16),
                  Text(
                    'No hay datos de comparación',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Agregue items al reconteo para ver la comparación',
                    style: Theme.of(context).textTheme.bodySmall,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }

          final startIndex = _currentPage * _rowsPerPage;
          final endIndex = (startIndex + _rowsPerPage > items.length)
              ? items.length
              : startIndex + _rowsPerPage;
          final paginatedItems = items.sublist(startIndex, endIndex);
          final totalPages = (items.length / _rowsPerPage).ceil();

          return Column(
            children: [
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async => ref.refresh(recountComparisonProvider.future),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: constraints.maxHeight,
                          ),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: DataTable(
                                columns: const [
                                  DataColumn(label: Text('Nombre')),
                                  DataColumn(label: Text('Referencia')),
                                  DataColumn(label: Text('Contado')),
                                  DataColumn(label: Text('Inventario')),
                                  DataColumn(label: Text('Diferencia')),
                                ],
                                rows: paginatedItems.map((item) {
                                  final difference = item.difference ?? 0;
                                  final differenceColor = difference == 0
                                      ? Colors.green
                                      : difference > 0
                                          ? Colors.green
                                          : Colors.red;

                                  return DataRow(
                                    cells: [
                                      DataCell(Text(item.name ?? '-')),
                                      DataCell(Text(item.reference ?? '-')),
                                      DataCell(Text(item.countQty?.toString() ?? '0')),
                                      DataCell(Text(item.serviceQty?.toString() ?? '0')),
                                      DataCell(
                                        Text(
                                          difference.toString(),
                                          style: TextStyle(
                                            color: differenceColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                }).toList(),
                                // dividerThickness: 1,
                                // dataRowHeight: 80,
                                // showBottomBorder: true,
                                headingTextStyle: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                                headingRowColor: WidgetStateProperty.resolveWith(
                                      (states) => Colors.white12,
                                ),
                                border: TableBorder.all(
                                  borderRadius: BorderRadius.circular(18)
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Página ${_currentPage + 1} de $totalPages',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.chevron_left),
                          onPressed: _currentPage > 0
                              ? () {
                                  setState(() {
                                    _currentPage--;
                                  });
                                }
                              : null,
                        ),
                        Text(
                          'Mostrando ${startIndex + 1}-$endIndex de ${items.length}',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        IconButton(
                          icon: const Icon(Icons.chevron_right),
                          onPressed: _currentPage < totalPages - 1
                              ? () {
                                  setState(() {
                                    _currentPage++;
                                  });
                                }
                              : null,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.red),
              const SizedBox(height: 16),
              Text(
                'Error al cargar los datos',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Text(
                error.toString(),
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
