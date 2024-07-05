import 'package:cct_management/app/pages/relocation/relocation_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

import '../../../device/utils/logger_config.dart';
import '../../../domain/dtos/relocation_dto.dart';
import '../../../domain/dtos/series_dto.dart';
import '../../../domain/providers/relocate_provider.dart';
import '../../../domain/utils/clean_list_util.dart';
import '../../constants.dart';
import 'inputs/assets_input.dart';
import 'inputs/dropdown_button_input.dart';
import 'inputs/location_input.dart';
import 'inputs/lpn_input.dart';
import 'inputs/quantity_input.dart';
import 'inputs/series_input.dart';

/**
 * Made for cct_management.
 * By User: josedominguez
 * Date: 06/11/24
 */

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

  late final Key seriesKey = Key("series");

  late final TextEditingController quantityController =
      TextEditingController(text: "0");

  List<String> _seriesList = [];

  String? selectedWarehouseFrom = " ";
  String? selectedWarehouseTo = " ";
  bool? isSeries = false;
  bool _valid = false;
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    // ref.listenManual(addEntryProvider, (previous, next) {});
    super.initState();
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
                              isSeries = newBool;
                            });
                          }),
                    ],
                  ),
                ),
                SeriesInput(
                  key: seriesKey,
                  initialValue: [],
                  seriesList: _seriesList,
                  onSelectParam: (value) {
                    setState(() {
                      _seriesList = value;
                    });
                  },
                ),
                LpnInput(
                  controller: lpnFromController,
                  title: 'LPN origen',
                ),
                LpnInput(
                  controller: lpnToController,
                  title: 'LPN destino',
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
            Wrap(
              children: [
                QuantityInput(
                  controller: quantityController,
                  onEditingComplete: (v){
                    setState(() {

                    });
                  },
                ),
              ],
            ),
            DropdownButtonInput(
              title: 'Bodega Origen',
              values: bodegas,
              onSelectParam: (value) {
                setState(() {
                  selectedWarehouseFrom = value;
                });
              },
              icon: Icons.arrow_drop_down_circle_outlined,
            ),
            DropdownButtonInput(
              title: 'Bodega Destino',
              values: bodegas,
              onSelectParam: (value) {
                setState(() {
                  selectedWarehouseTo = value;
                });
              },
              icon: Icons.arrow_drop_down_circle_outlined,
            ),
            SizedBox(
              height: MediaQuery.of(context).viewInsets.bottom,
            ),
            isLoading
                ? Container(
                    margin: const EdgeInsets.all(10.0),
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
            )
                : Container(
                    width: size.width,
                    margin: const EdgeInsets.all(10.0),
                    child: OutlinedButton(
                      onPressed: () {
                        setState(() {
                          _valid = relocationFormKey.currentState!.validate();
                          isLoading = true;
                        });
                        if (_valid) {
                          if (_seriesList.isNotEmpty &&
                              _seriesList.length <= 2) {
                            for (String v in _seriesList) {
                              if(v.contains(" ")){
                                _seriesList.addAll(cleanListUtil.cleanList(v));
                              }
                            }
                          }
                          // if(validateRequest(
                          //   lpnFromController.text, lpnToController.text,
                          //   locationFromController.text, locationToController.text,
                          //     selectedWarehouseFrom!, selectedWarehouseTo!
                          // )){
                            var request = RelocationDto(
                                user: "",
                                asset: assetsController.text,
                                isseries: "$isSeries",
                                series: SeriesDto(series: _seriesList),
                                branch: "1",
                                fromlpn: lpnFromController.text,
                                fromwarehouse: selectedWarehouseFrom,
                                fromlocation: locationFromController.text,
                                towardslpn: lpnToController.text,
                                towardswarehouse: selectedWarehouseTo,
                                towardslocation: locationToController.text,
                                quantity: quantityController.text,
                                remarks: "qwe");

                            logger.d(request.toJson());
                            relocateItems.relocate(request).then((value) {
                              setState(() {
                                isLoading = true;
                              });
                              var code = value?.status?.code;

                              if (code! >= 200 && code < 300) {
                                Fluttertoast.showToast(
                                    msg: "Agregado Correctamente",
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.greenAccent,
                                    textColor: Colors.black54,
                                    fontSize: 16.0);
                                relocationFormKey.currentState?.reset();
                                _seriesList = <String>[];
                                assetsController.text = "";
                                lpnToController.text = "";
                                lpnFromController.text = "";
                                locationFromController.text = "";
                                locationToController.text = "";
                                quantityController.text = "0";
                                isSeries = false;
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
                              Fluttertoast.showToast(
                                  msg: "Algo fallo!",
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            });
                          // }
                          // else {
                          //   Fluttertoast.showToast(
                          //       msg: "El Destino y origen deben ser distintos!",
                          //       toastLength: Toast.LENGTH_LONG,
                          //       gravity: ToastGravity.CENTER,
                          //       timeInSecForIosWeb: 1,
                          //       backgroundColor: Colors.yellowAccent,
                          //       textColor: Colors.black,
                          //       fontSize: 16.0);
                          // }

                        }
                        setState(() {
                          isLoading = false;
                        });
                      },
                      child: Text("Guardar",
                          style: Theme.of(context).textTheme.headlineMedium),
                    ),
                  ),
          ],
        ));
  }

  bool validateRequest(String lpnFrom, String lpnTo, String locationFrom, String locationTo, String warehouseFrom, String warehouseTo){
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
