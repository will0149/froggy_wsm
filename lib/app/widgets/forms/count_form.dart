import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../device/utils/logger_config.dart';
import '../../../domain/dtos/series_dto.dart';
import '../../../domain/dtos/tally_count_dto.dart';
import '../../../domain/providers/tally_count_provider.dart';
import '../../../domain/providers/warehouses/get_warehouses_provider.dart';
import '../../constants.dart';
import '../../pages/count/count_page.dart';
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

class CountForm extends ConsumerStatefulWidget {
  const CountForm({super.key});

  @override
  CountFormState createState() => CountFormState();
}

class CountFormState extends ConsumerState<CountForm> {
  late final GlobalKey<FormState> countFormKey = GlobalKey<FormState>();

  late final TextEditingController locationController = TextEditingController(text: "");
  late final TextEditingController lpnController = TextEditingController(text: "");
  late final TextEditingController assetsController = TextEditingController(text: "");

  String selectedWarehouse = " ";
  String seriesLength = "0";
  List<String> _seriesList = [];

  bool isSeries = false;
  bool _valid = false;
  bool isLoading = false;

  TallyCountDto data = TallyCountDto();

  bool dataValidate = false;

  @override
  void initState() {
    countFormKey.currentState?.reset;
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
    locationController.dispose();
    lpnController.dispose();
    assetsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final warehouseData = ref.watch(getWarehousesProvider);
    var tallyCount = ref.watch(tallyCountProvider);
    var size = MediaQuery.of(context).size;
    return Form(
      key: countFormKey,
      child: Wrap(
        runSpacing: wrapVerticalSpacing,
        children: [
          Center(
            child: Text(
              "Reconteo Cíclico",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Wrap(
            runSpacing: wrapVerticalSpacing,
            children: [
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
                title: "Cantidad de series",
                // enable: isSeries,
                onEditingComplete: (v) {
                  logger.f("Tamaño de series $v");
                  setState(() {
                    seriesLength = v.toInt().toString();
                  });
                                },
              ),
              SeriesInput(
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
                controller: lpnController,
                title: 'Carton ID',
              ),
              AssetsInput(
                controller: assetsController,
              ),
              warehouseData.when(
                data: (data) {
                  // readState.setComponentsLoading(false);
                  logger.i("incoming data ${data.toString()}");
                  return WarehousesDropdownButton(
                    key: const Key("1"),
                    onSelectParam: (value) {
                      setState(() {
                        selectedWarehouse = value;
                      });
                    },
                    title: "Bodegas",
                    values: data.body,
                    icon: Icons.arrow_drop_down_circle_outlined,
                  );
                },
                error: (err, s) {
                  logger.e("error $s");
                  return Text(err.toString());
                },
                loading: () => const  LinearProgressIndicator(),
              ),
              LocationInput(
                controller: locationController,
              ),
              SizedBox(
                height: MediaQuery.of(context).viewInsets.bottom,
              ),
            ],
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
                  child: dataValidate
                      ? OutlinedButton(
                          onPressed: () {
                            setState(() {
                              _valid = countFormKey.currentState!.validate();
                              isLoading = true;
                            });
                            if (_valid) {
                              tallyCount.count(data).then((value) {
                                var code = value?.status?.code;
                                if (code! >= 200 && code < 300) {
                                  showSuccessToast("Coteo Exitoso");
                                  // countFormKey.currentState?.reset;
                                  context.goNamed(CountPage.routeName);
                                }else {
                                  showErrorToast(
                                      "Ha fallado el envio con status ");
                                }
                              }).whenComplete(() {
                                logger.i("finished Count");
                                setState(() {
                                  isLoading = false;
                                });
                              }).catchError((error) {
                                logger.e("bruja ${error}");
                                setState(() {
                                  isLoading = false;
                                });
                                showErrorToast("Algo fallo!");
                              });
                            } else {
                              setState(() {
                                isLoading = false;
                              });
                            }
                          },
                          child: Text("Guardar",
                              style:
                                  Theme.of(context).textTheme.headlineMedium),
                        )
                      : OutlinedButton(
                          style: ElevatedButton.styleFrom(
                            // Define button's look with styleFrom
                            foregroundColor: Colors.white,
                            backgroundColor: Colors
                                .blueAccent, // Set the text (and icon) color
                            shape: RoundedRectangleBorder(
                              // The button's outline is defined as a rounded rectangle with circular corners
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              _valid = countFormKey.currentState!.validate();
                              isLoading = true;
                              data = TallyCountDto(
                                  device: "phone",
                                  branch: "1",
                                  warehouse: selectedWarehouse,
                                  location: locationController.text,
                                  cartonid: lpnController.text,
                                  asset: assetsController.text,
                                  isSeries: isSeries.toString(),
                                  series: SeriesDto(series: _seriesList),
                                  quantity: seriesLength,
                                  remark: "sfafafas");
                            });
                            if (_valid) {
                              tallyCount.countValidate(data).then((value) {
                                var code = value?.status?.code;
                                logger.i("code in form $code");
                                if (code! >= 200 && code < 300) {
                                  showSuccessToast("Datos validados");
                                  setState(() {
                                    dataValidate = true;
                                    isLoading = false;
                                  });
                                } else {
                                  showErrorToast(
                                      "Ha fallado el envio con status $code");
                                }
                              }).whenComplete(() {
                                logger.i("finished Count");
                                setState(() {
                                  isLoading = false;
                                });
                              }).catchError((error) {
                                logger.e("bruja ${error.toString()}");
                                setState(() {
                                  isLoading = false;
                                });
                                showErrorToast("Algo fallo!");
                              });
                            }else {
                              setState(() {
                                isLoading = false;
                              });
                            }
                          },
                          child: Text("Validar datos",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(color: Colors.white)),
                        ),
                ),
        ],
      ),
    );
  }

  void showAlert(String? message) {
    showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            elevation: 10.0,
            title: const Text('Datos Valdados'),
            content: Text(
              '$message\nAqui se muestran los valores no existentes',
            ),
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: const Text('Ok'),
                onPressed: () {
                  Navigator.pop(context, false);
                },
              ),
            ],
          );
        });
  }
}
