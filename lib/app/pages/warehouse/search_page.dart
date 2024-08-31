import 'package:cct_management/app/pages/warehouse/stocks_table_page.dart';
import 'package:cct_management/app/widgets/forms/inputs/series_input.dart';
import 'package:cct_management/app/widgets/scaffolds/safe_scaffold.dart';
import 'package:cct_management/data/entities/base_response_entity.dart';
import 'package:cct_management/data/entities/stocks/stock_list_entity.dart';
import 'package:cct_management/domain/providers/stocks/get_stocks_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_input_chips/flutter_input_chips.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../data/entities/stocks/body_stocks_entity.dart';
import '../../../device/utils/logger_config.dart';
import '../../../domain/dtos/series_dto.dart';
import '../../widgets/toasts/build_toasts.dart';

/**
 * Made for cct_management.
 * By User: josedominguez
 * Date: 08/04/24
 */

class SearchPage extends ConsumerStatefulWidget {
  static String get routeName => 'search/items';
  static String get routeLocation => routeName;
  const SearchPage({super.key});

  @override
  SearchTableState createState() => SearchTableState();
}

class SearchTableState extends ConsumerState<SearchPage> {
  final ScrollController _controller = ScrollController();
  List<String> seriesList = [];
  SeriesDto? seriesRequest;
  bool isLoading = false;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLoading = false;
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeScaffold(
      appBar: AppBar(
        title: Text(
          "Búscar en inventario",
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              padding: const EdgeInsets.all(10.0),
              margin: const EdgeInsets.all(10.0),
              width: size.width * 0.9,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      width: size.width * 0.7,
                      child: FlutterInputChips(
                        initialValue: const [],
                        onChanged: (v) {
                          setState(() {
                            seriesList = v;
                          });
                        },
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        inputDecoration: const InputDecoration(
                          labelText: "Búsqueda de Stocks",
                          hintText: "N2J3N1K2N2",
                          labelStyle: TextStyle(color: Colors.black87),
                        ),
                        chipTextStyle:
                            Theme.of(context).textTheme.bodySmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                        chipSpacing: 8,
                        chipDeleteIconColor: Colors.white,
                        chipBackgroundColor: Colors.blueGrey,
                      )),
                  isLoading ? Container(
                      margin: const EdgeInsets.all(10.0),
                      child: const Center(
                        child: CircularProgressIndicator(),
                      )) :IconButton(
                    //onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const SearchPage())),
                    onPressed: () async {
                      logger.f("serieses $seriesList");
                      setState(() {
                        isLoading = true;
                      });
                      if (seriesList.isNotEmpty) {
                        SeriesDto? seriesRequest = SeriesDto(series: seriesList);
                        context.goNamed(StocksTablePage.routeName, extra: seriesRequest);
                      }else {
                        showErrorToast("No puede enviar un request vacío");
                      }
                      setState(() {
                        isLoading = false;
                      });
                    },
                    icon: const Icon(Icons.search),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
