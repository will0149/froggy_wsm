import 'package:froggy_soft/app/pages/warehouse/stocks_table_page.dart';
import 'package:froggy_soft/app/widgets/filters/horizontal_filter_list.dart';
import 'package:froggy_soft/app/widgets/forms/inputs/generic_input.dart';
import 'package:froggy_soft/app/widgets/scaffolds/safe_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../device/utils/logger_config.dart';
import '../../../domain/dtos/series_dto.dart';
import '../../../generated/l10n.dart';
import '../../widgets/toasts/build_toasts.dart';

/**
 * Made for froggysoft.
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
  late final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late final TextEditingController searchValueController =
      TextEditingController();
  final List<String> filters = [
    "cartonid",
    "serie",
    "warehouse",
    "location",
    "asset",
    "container",
    "branch"
  ];
  List<String> seriesList = [];
  String searchFilter = "";
  String searchValue = "";
  SeriesDto? seriesRequest;
  bool isValid = false;
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLoading = false;
  }

  void _onTextChange(String value) {
    setState(() {
      searchFilter = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeScaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).searchPageTitle,
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      child: Stack(
        children: [
          Wrap(
              children: [
            HorizontalFilterList(
              filterListItems: filters,
              activeColor: Colors.orange,
              inactiveColor: Colors.white,
              onTextChange: _onTextChange,
            ),
          ]),
          Padding(
            padding: const EdgeInsets.only(top: 70),
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                padding: const EdgeInsets.all(10.0),
                margin: const EdgeInsets.all(10.0),
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
                      child: Form(
                        key: formKey,
                        child: GenericInput(
                          controller: searchValueController,
                          title:
                              S.of(context).searchInput, //S.of(context).containerInput,
                          isNumber: false,
                        ),
                      ),
                    ),
                    isLoading
                        ? Container(
                            margin: const EdgeInsets.all(10.0),
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ))
                        : Container(
                      decoration: BoxDecoration(
                      color: const Color.fromRGBO(
                          173, 164, 164, 0.615686274509804),
                      borderRadius: BorderRadius.circular(10),
                    ),
                          child: IconButton(
                              //onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const SearchPage())),
                              onPressed: () async {
                                setState(() {
                                  isValid = formKey.currentState!.validate();
                                  isLoading = true;
                                });
                                if(searchFilter.isEmpty){
                                  setState(() {
                                    searchFilter = filters.first;
                                  });
                                }
                                // if (kDebugMode) logger.i("form valid $isValid");
                                if (isValid &&
                                    searchValueController.text.isNotEmpty) {
                                  Map<String, String>? request = {
                                    'searchField': searchFilter,
                                    'searchValue':
                                        searchValueController.text.toUpperCase()
                                  };
                                  context.goNamed(StocksTablePage.routeName,
                                      extra: request);
                                  setState(() {
                                    isLoading = false;
                                  });
                                } else {
                                  showErrorToast(
                                      S.of(context).fieldCantBeEmpty);
                                }
                                setState(() {
                                  isLoading = false;
                                });
                              },
                              icon: const Icon(Icons.search),
                            ),
                        )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
