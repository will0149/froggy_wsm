import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:froggy_soft/app/widgets/scaffolds/safe_scaffold.dart';
import 'package:froggy_soft/device/utils/logger_config.dart';
import 'package:froggy_soft/domain/providers/alegra_items_provider.dart';

/// Made for froggy_soft.
/// By User: josedominguez
/// Date: 10/13/25

class AlegraInventoryPage extends ConsumerStatefulWidget {
  static String get routeName => 'inventory';

  static String get routeLocation => routeName;

  const AlegraInventoryPage({super.key});

  @override
  AlegraInventoryPageState createState() => AlegraInventoryPageState();
}

class AlegraInventoryPageState extends ConsumerState<AlegraInventoryPage> {
  int _currentPage = 0;
  final int _rowsPerPage = 10;

  @override
  Widget build(BuildContext context) {
    final itemsAsync = ref.watch(alegraItemsProvider);
    // final countAsync = ref.watch(alegraItemsCountProvider);

    return SafeScaffold(
      appBar: AppBar(
        title: Text(
          "Inventario",
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      child: itemsAsync.when(
        data: (items) {
          final startIndex = _currentPage * _rowsPerPage;
          final endIndex = (startIndex + _rowsPerPage > items.length)
              ? items.length
              : startIndex + _rowsPerPage;
          final paginatedItems = items.sublist(startIndex, endIndex);
          final totalPages = (items.length / _rowsPerPage).ceil();

          return Column(
            spacing: 15,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Página ${_currentPage + 1} de $totalPages',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async => ref.refresh(alegraItemsProvider.future),
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
                                  DataColumn(label: Text('ID')),
                                  DataColumn(label: Text('Referencia')),
                                  DataColumn(label: Text('Cantidad')),
                                  DataColumn(label: Text('Nombre')),
                                  DataColumn(label: Text('Cargado')),
                                ],
                                rows: paginatedItems.map((item) {
                                  return DataRow(
                                    cells: [
                                      DataCell(SelectableText(item.id?.toString() ?? '-')),
                                      DataCell(SelectableText(item.reference ?? '-')),
                                      DataCell(Text(item.quantity?.toString() ?? '0')),
                                      DataCell(Text(item.name ?? '-')),
                                      DataCell(Text(item.createdAt ?? '-')),
                                    ],
                                  );
                                }).toList(),
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
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
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 200),
                          child: Text(
                            'Mostrando ${startIndex + 1}-$endIndex de ${items.length}',
                            style: Theme.of(context).textTheme.bodySmall,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                          ),
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
            spacing: 10,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.red),
              Text(
                'Error al cargar los datos',
                style: Theme.of(context).textTheme.titleMedium,
              ),
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