import 'package:cct_management/app/widgets/scaffolds/safe_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/dtos/series_dto.dart';
import '../../../domain/providers/stocks/get_stocks_provider.dart';

/**
 * Made for cct_management.
 * By User: josedominguez
 * Date: 08/14/24
 */

class StocksTablePage extends ConsumerStatefulWidget {
  SeriesDto? seriesRequest;
  StocksTablePage({super.key, this.seriesRequest});
  static String get routeName => 'stocks';
  static String get routeLocation => routeName;
  @override
  StocksTablePageState createState() => StocksTablePageState();
}

class StocksTablePageState extends ConsumerState<StocksTablePage> {
  @override
  Widget build(BuildContext context) {
    final providerData = ref.watch(getStocksProvider(widget.seriesRequest));
    var size = MediaQuery.of(context).size;
    return SafeScaffold(
      appBar: AppBar(
        title: Text(
          "Resultados",
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      child: SingleChildScrollView(
        // scrollDirection: Axis.horizontal,
        child: providerData.when(
            data: (item) {
              List<DataRow> stocks = [];
              var code = item.status?.code ?? 500;
              if (code >= 200 && code < 300) {
                item.body?.series?.map((stock) {
                  stocks.add(
                    DataRow(cells: [
                      DataCell(Text("${stock.cartonid}")),
                      DataCell(Text("${stock.location}")),
                      DataCell(Text("${stock.warehouse}")),
                      DataCell(Text("${stock.serie}")),
                      DataCell(PopupMenuButton(
                        itemBuilder: (BuildContext bc) {
                          return const [
                            PopupMenuItem(
                              child: Text("Detalle"),
                              value: '/hello',
                            ),
                            PopupMenuItem(
                              child: Text("Reubicar"),
                              value: '/about',
                            ),
                            PopupMenuItem(
                              child: Text("Enviar a Salida"),
                              value: '/contact',
                            )
                          ];
                        },
                      )),
                    ]),
                  );
                }).toList();
              }else {
                return const Center(
                  child: Text("No Results"),
                );
              }
              return SizedBox(
                width: size.width * 1,
                height: size.height,
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: [
                    DataTable(
                      columns: const [
                        DataColumn(label: Text("Carton ID")),
                        DataColumn(label: Text("Location")),
                        DataColumn(label: Text("Warehouse")),
                        DataColumn(label: Text("Serie")),
                        DataColumn(
                          label: Text("Opciones"),
                        ),
                      ],
                      rows: stocks,
                      dividerThickness: 5,
                      // dataRowHeight: 80,
                      showBottomBorder: true,
                      headingTextStyle: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black87,
                      ),
                      headingRowColor: WidgetStateProperty.resolveWith(
                          (states) => Colors.orange,
                      ),
                      border: TableBorder.all(),
                    ),
                  ],
                ),
              );
            },
            error: (err, st) => Text(err.toString()),
            loading: () => const LinearProgressIndicator()),
      ),
    );
  }
}
