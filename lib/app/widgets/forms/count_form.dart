import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../device/utils/logger_config.dart';
import '../../../domain/dtos/series_dto.dart';
import '../../../domain/dtos/tally_count_dto.dart';
import '../../../domain/providers/tally_count_provider.dart';
import '../../../domain/states/entry_form_view_notifier.dart';
import '../../constants.dart';
import '../../pages/count/count_page.dart';
import '../toasts/build_toasts.dart';
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

class CountForm extends ConsumerStatefulWidget {
  const CountForm({super.key});

  @override
  CountFormState createState() => CountFormState();
}

class CountFormState extends ConsumerState<CountForm> {
  late final GlobalKey<FormState> countFormKey = GlobalKey<FormState>();

  late final TextEditingController locationController = TextEditingController();
  late final TextEditingController seriesQuantityController =
      TextEditingController();
  late final TextEditingController lpnController = TextEditingController();
  late final TextEditingController assetsController = TextEditingController();

  String? selectedWarehouse = " ";
  bool? isChecked = false;
  String seriesLength = "0";
  List<String> _seriesList = [];

  bool isSeries = false;
  bool _valid = false;
  bool isLoading = false;

  TallyCountDto data = TallyCountDto();

  bool dataValidate = false;

  @override
  void initState() {
    // TODO: implement initState
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
    seriesQuantityController.dispose();
    assetsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var entryFormProvider = ref.watch(entryFormViewProvider);
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
                controller: seriesQuantityController,
                title: "Cantidad de series",
                // enable: isSeries,
                onEditingComplete: (v) {
                  logger.f("Tamaño de series $v");
                  if (v != null) {
                    setState(() {
                      seriesLength = v.toInt().toString();
                    });
                  } else {
                    seriesLength = "0";
                  }
                },
              ),
              SeriesInput(
                initialValue: [],
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
                title: 'carton ID',
              ),
              AssetsInput(
                controller: assetsController,
              ),
              DropdownButtonInput(
                title: "Bodega",
                values: bodegas,
                onSelectParam: (value) {
                  setState(() {
                    selectedWarehouse = value;
                  });
                },
                icon: Icons.arrow_drop_down_circle_outlined,
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
                  margin: EdgeInsets.all(10.0),
                  child: dataValidate
                      ? OutlinedButton(
                          onPressed: () {
                            setState(() {
                              _valid = countFormKey.currentState!.validate();
                              isLoading = true;
                            });
                            if (_valid) {
                              logger.d('save ${data.toJson()}');
                              tallyCount.count(data).then((value) {
                                setState(() {
                                  isLoading = true;
                                });
                                var code = value?.status?.code;

                                if (code! >= 200 && code < 300) {
                                  showSuccessToast("Agregado Correctamente");
                                  countFormKey.currentState?.reset();
                                  context.goNamed(CountPage.routeName);
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
                              logger.d('validate ${data.toJson()}');
                              tallyCount.countValidate(data).then((value) {
                                setState(() {
                                  isLoading = true;
                                });
                                var code = value?.status?.code;
                                logger.e("code in form $code");
                                if (code! >= 200 && code < 300) {
                                  showSuccessToast("Datos validados");
                                  setState(() {
                                    dataValidate = true;
                                    isLoading = false;
                                  });
                                } else {
                                  showAlert(value?.status!.toJson().toString());
                                }
                                logger.i("Adding Entry $code");
                              }).whenComplete(() {
                                logger.i("finished Entry");
                                setState(() {
                                  isLoading = false;
                                });
                              }).catchError((error) {
                                logger.e(error.toString());
                                setState(() {
                                  isLoading = false;
                                });
                                showErrorToast("Algo fallo!");
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
