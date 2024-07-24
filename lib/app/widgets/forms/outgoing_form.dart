import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../../device/utils/logger_config.dart';
import '../../../domain/dtos/outgoing_dto.dart';
import '../../../domain/dtos/series_dto.dart';
import '../../../domain/providers/add_outgoing_provider.dart';
import '../../../domain/providers/warehouses/get_warehouses_provider.dart';
import '../../constants.dart';
import '../../pages/outgoing/outgoing_page.dart';
import '../toasts/build_toasts.dart';
import 'inputs/assets_input.dart';
import 'inputs/batch_input.dart';
import 'inputs/date_input.dart';
import 'inputs/dropdown_button_input.dart';
import 'inputs/location_input.dart';
import 'inputs/lpn_input.dart';
import 'inputs/quantity_input.dart';
import 'inputs/series_input.dart';
import 'inputs/warehouses_dropdown_button.dart';

/**
 * Made for cct_management.
 * By User: josedominguez
 * Date: 06/11/24
 */

class OutgoingForm extends ConsumerStatefulWidget {
  const OutgoingForm({super.key});

  @override
  OutgoingFormState createState() => OutgoingFormState();
}

class OutgoingFormState extends ConsumerState<OutgoingForm> {
  late final GlobalKey<FormState> outgoingFormKey = GlobalKey<FormState>();

  late final TextEditingController locationController = TextEditingController();
  late final TextEditingController seriesQuantityController =
      TextEditingController();
  late final TextEditingController lpnController = TextEditingController();
  late final TextEditingController assetsController = TextEditingController();

  String? selectedPerson;
  String? selectedWarehouse;
  DateTime? selectedDate;
  String seriesLength = "0";
  bool isSeries = false;

  bool _valid = false;
  bool isLoading = false;

  List<String> _seriesList = [];

  @override
  void initState() {
    // TODO: implement initState
    initializeDateFormatting();
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
    final warehouseData = ref.watch(getWarehousesProvider);
    var outgoing = ref.watch(addOutgoingProvider);
    var size = MediaQuery.of(context).size;
    return Form(
      key: outgoingFormKey,
      child: Wrap(
        // spacing: 15.0,
        runSpacing: wrapVerticalSpacing,
        children: [
          Center(
            child: Text(
              "Registrar Salida",
              style: Theme.of(context).textTheme.titleLarge,
            ),
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
          // DropdownButtonInput(
          //   onSelectParam: (value) {
          //     setState(() {
          //       selectedPerson = value;
          //     });
          //   },
          //   title: "clientes",
          //   values: clients,
          //   icon: Icons.arrow_drop_down_circle_outlined,
          // ),

          warehouseData.when(
            data: (data) {
              // readState.setComponentsLoading(false);
              logger.i("incoming data ${data.toString()}");
              return WarehousesDropdownButton(
                key: Key("1"),
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
              logger.e("error ${s}");
              return Text(err.toString());
            },
            loading: () => const  LinearProgressIndicator(),
          ),
          LpnInput(
            controller: lpnController,
            title: 'carton ID',
          ),
          LocationInput(
            controller: locationController,
          ),
          AssetsInput(
            controller: assetsController,
          ),
          DateInput(
            title: 'Fecha de Salida',
            onSelectParam: (value) {
              setState(() {
                selectedDate = value;
              });
            },
            // selectedDate: selectedDate,
          ),
          isLoading
              ? Container(
                  margin: EdgeInsets.all(10.0),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ))
              : Container(
                  width: size.width,
                  margin: EdgeInsets.all(10.0),
                  child: OutlinedButton(
                    onPressed: () {
                      setState(() {
                        _valid = outgoingFormKey.currentState!.validate();
                        isLoading = true;
                      });
                      if (_valid) {
                        var request = OutgoingDto(
                            docnum: "sadas",
                            warehouse: selectedWarehouse,
                            device: "movil",
                            location: locationController.text,
                            isSeries: isSeries.toString(),
                            series: SeriesDto(series: _seriesList),
                            cartonId: lpnController.text,
                            asset: assetsController.text,
                            quantity: seriesLength);

                        logger.d(request.toJson());
                        var response =
                            outgoing.addOutgoing(request).then((value) {
                          setState(() {
                            isLoading = true;
                          });
                          var code = value?.status?.code;

                          if (code! >= 200 && code < 300) {
                            showSuccessToast("Agregado Correctamente");
                            outgoingFormKey.currentState?.reset();
                            context.goNamed(OutgoingPage.routeName);
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
      ),
    );
  }
}
