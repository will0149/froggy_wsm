import 'package:cct_management/app/pages/relocation/relocation_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../device/utils/logger_config.dart';
import '../../../domain/dtos/relocation_dto.dart';
import '../../../domain/dtos/series_dto.dart';
import '../../../domain/providers/relocate_provider.dart';
import '../../../domain/providers/warehouses/get_warehouses_provider.dart';
import '../../../domain/utils/clean_list_util.dart';
import '../../constants.dart';
import '../toasts/build_toasts.dart';
import 'inputs/assets_input.dart';
import 'inputs/location_input.dart';
import 'inputs/lpn_input.dart';
import 'inputs/quantity_input.dart';
import 'inputs/series_input.dart';
import 'inputs/warehouses_dropdown_button.dart';

/// Made for cct_management.
/// By User: josedominguez
/// Date: 06/11/24

class RelocationForm extends ConsumerStatefulWidget {
  const RelocationForm({super.key});

  @override
  _RelocationFormState createState() => _RelocationFormState();
}

class _RelocationFormState extends ConsumerState<RelocationForm> {
  CleanListUtil cleanListUtil = CleanListUtil();

  late final GlobalKey<FormState> relocationFormKey = GlobalKey<FormState>();

  late final TextEditingController locationFromController =
      TextEditingController();
  late final TextEditingController locationToController =
      TextEditingController();
  late final TextEditingController lpnFromController = TextEditingController(text: "");
  late final TextEditingController lpnToController = TextEditingController(text: "");
  late final TextEditingController assetsController = TextEditingController(text: "");
  late final TextEditingController remarksController = TextEditingController(text: "");

  late final Key seriesKey = const Key("series");

  late final TextEditingController quantityController =
      TextEditingController(text: "0");

  String seriesLength = "0";

  List<String> _seriesList = [];

  String? selectedWarehouseFrom = " ";
  String? selectedWarehouseTo = " ";
  bool isSeries = false;
  bool _valid = false;
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    // ref.listenManual(addEntryProvider, (previous, next) {});
    super.initState();
  }

  void validateRequest() {
    logger.d("validating seriesLength $seriesLength");
    if (isSeries) {
      if (int.parse(seriesLength) != _seriesList.length) {
        setState(() {
          _valid = false;
          isLoading = false;
        });
        showWarningToast(
            "La series deben coincidir con la cantidad introducida");
      }
    } else {
      if (int.parse(seriesLength) <= 0) {
        setState(() {
          _valid = false;
          isLoading = false;
        });
        showWarningToast("La cantidad no puede ser 0");
      }
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    locationFromController.dispose();
    locationToController.dispose();
    assetsController.dispose();
    remarksController.dispose();
    quantityController.dispose();
    lpnFromController.dispose();
    lpnToController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final warehouseData = ref.watch(getWarehousesProvider);
    var relocateItems = ref.watch(relocateProvider);
    var size = MediaQuery.of(context).size;
    return Form(
        key: relocationFormKey,
        child: Wrap(
          runSpacing: wrapVerticalSpacing,
          children: [
            Center(
              child: Text(
                "Reubicar Mercancia",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            Wrap(
              runSpacing: wrapVerticalSpacing,
              children: [
                AssetsInput(
                  controller: assetsController,
                ),
                Container(
                  width: size.width * 0.40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Es Serie"),
                      Checkbox(
                          semanticLabel: "Es Serie",
                          value: isSeries,
                          onChanged: (newBool) {
                            setState(() {
                              isSeries = newBool!;
                            });
                          }),
                    ],
                  ),
                ),
                QuantityInput(
                  title: "Cantidad de Series",
                  controller: quantityController,
                  onEditingComplete: (v){
                    logger.f("Tamaño de series $v");
                    setState(() {
                      seriesLength = v.toInt().toString();
                    });
                                    },
                ),
                SeriesInput(
                  key: seriesKey,
                  initialValue: const [],
                  seriesList: _seriesList,
                  maxChips: int.parse(seriesLength),
                  enable: isSeries,
                  onSelectParam: (value) {
                    setState(() {
                      _seriesList = value;
                    });
                  },
                ),
                LpnInput(
                  controller: lpnFromController,
                  title: 'CartonId origen',
                ),
                LpnInput(
                  controller: lpnToController,
                  title: 'CartonId destino',
                ),
                LocationInput(
                  controller: locationFromController,
                  title: 'Ubicación Origen',
                ),
                LocationInput(
                  controller: locationToController,
                  title: 'Ubicación Destino',
                ),
              ],
            ),
            warehouseData.when(
                data: (data) {
                  // readState.setComponentsLoading(false);
                  logger.i("incoming data ${data.toString()}");
                  return WarehousesDropdownButton(
                    key: const Key("1"),
                    onSelectParam: (value) {
                      setState(() {
                        selectedWarehouseFrom = value;
                      });
                    },
                    title: "Bodega Origen",
                    values: data.body,
                    icon: Icons.arrow_drop_down_circle_outlined,
                  );
                },
                error: (err, s) {
                  logger.e("error $s");
                  return Text(err.toString());
                },
                loading: () => const  LinearProgressIndicator(),),

            warehouseData.when(
              data: (data) {
                // readState.setComponentsLoading(false);
                logger.i("incoming data ${data.toString()}");
                return WarehousesDropdownButton(
                  key: const Key("2"),
                  onSelectParam: (value) {
                    setState(() {
                      selectedWarehouseTo = value;
                    });
                  },
                  title: "Bodega Destino",
                  values: data.body,
                  icon: Icons.arrow_drop_down_circle_outlined,
                );
              },
              error: (err, s) {
                logger.e("error $s");
                return Text(err.toString());
              },
              loading: () => const  LinearProgressIndicator(),),

            SizedBox(
              height: MediaQuery.of(context).viewInsets.bottom,
            ),
            isLoading
                ? Container(
                    margin: const EdgeInsets.all(10.0),
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ))
                : Container(
                    width: size.width,
                    margin: const EdgeInsets.all(10.0),
                    child: OutlinedButton(
                      onPressed: () {
                        setState(() {
                          _valid = relocationFormKey.currentState!.validate();
                          isLoading = true;
                        });

                        validateRequest();

                        if (_valid) {
                          if (_seriesList.isNotEmpty) {
                            for (String v in _seriesList) {
                              if (v.contains(" ")) {
                                _seriesList.addAll(cleanListUtil.cleanList(v));
                              }
                            }
                          }
                          // esta validacion es para que lo origenes no sean igual al destino
                          // if(validateFromTo(
                          //   lpnFromController.text, lpnToController.text,
                          //   locationFromController.text, locationToController.text,
                          //     selectedWarehouseFrom!, selectedWarehouseTo!
                          // )){
                            var request = RelocationDto(
                                asset: assetsController.text,
                                isseries: "$isSeries",
                                series: SeriesDto(series: _seriesList),
                                branch: "1",
                                fromCartonId: lpnFromController.text,
                                fromwarehouse: selectedWarehouseFrom,
                                fromlocation: locationFromController.text,
                                towardsCartonId: lpnToController.text,
                                towardswarehouse: selectedWarehouseTo,
                                towardslocation: locationToController.text,
                                quantity: seriesLength,
                                remarks: "qwe");

                            logger.d(request.toJson());
                            relocateItems.relocate(request).then((value) {
                              setState(() {
                                isLoading = true;
                              });
                              var code = value?.status?.code;

                              if (code! >= 200 && code < 300) {
                                showSuccessToast("Agregado Correctamente");
                                relocationFormKey.currentState?.reset();
                                context.goNamed(RelocationPage.routeName);
                              }
                              logger.i("Adding Entry $code");
                            }).whenComplete(() {
                              logger.i("finished Entry");
                              setState(() {
                                isLoading = false;
                              });
                            }).catchError((error) {
                              setState(() {
                                isLoading = false;
                              });
                              showErrorToast("Algo fallo!");
                            });

                        }
                      },
                      child: Text("Guardar",
                          style: Theme.of(context).textTheme.headlineMedium),
                    ),
                  ),
          ],
        ));
  }

  bool validateFromTo(String lpnFrom, String lpnTo, String locationFrom, String locationTo, String warehouseFrom, String warehouseTo){
    bool pass = true;
    bool lpnValid = true;
    bool locationValid = true;
    bool warehouseValid = true;

    if(lpnFrom.isNotEmpty & lpnTo.isNotEmpty){
      logger.d("lpnFrom $lpnFrom lpnTo $lpnTo");
      lpnValid = lpnFrom.compareTo(lpnTo) == -1;
    }
    if(locationFrom.isNotEmpty & locationTo.isNotEmpty){
      logger.d("locationFrom $locationFrom locationTo $locationTo");
      locationValid = locationFrom.compareTo(locationTo) == -1;
    }
    if(warehouseFrom.isNotEmpty & warehouseTo.isNotEmpty){
      logger.d("warehouseFrom $warehouseFrom warehouseTo $warehouseTo");
      warehouseValid = warehouseFrom.compareTo(warehouseTo) == -1;
    }
    logger.i("lpnValid $lpnValid locationValid $locationValid warehouseValid $warehouseValid");
    pass = (lpnValid == (locationValid == warehouseValid));
    return pass;
  }
}
