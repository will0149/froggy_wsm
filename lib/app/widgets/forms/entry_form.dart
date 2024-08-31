import 'package:cct_management/app/pages/entry/entry_page.dart';
import 'package:cct_management/domain/dtos/inbound_dto.dart';
import 'package:cct_management/domain/dtos/series_dto.dart';
import 'package:cct_management/domain/providers/warehouses/get_warehouses_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../device/utils/logger_config.dart';
import '../../../domain/dtos/dimensions_dto.dart';
import '../../../domain/providers/add_entry_provider.dart';
import '../../../domain/providers/clients/customer_provider.dart';
import '../../../domain/states/entry_form_view_notifier.dart';
import '../../../domain/utils/clean_list_util.dart';
import '../../constants.dart';
import '../toasts/build_toasts.dart';
import 'inputs/assets_input.dart';
import 'inputs/batch_input.dart';
import 'inputs/clients_dropdown_button.dart';
import 'inputs/date_input.dart';
import 'inputs/dimensions_input.dart';
import 'inputs/generic_input.dart';
import 'inputs/location_input.dart';
import 'inputs/lpn_input.dart';
import 'inputs/quantity_input.dart';
import 'inputs/remarks_input.dart';
import 'inputs/series_input.dart';
import 'inputs/warehouses_dropdown_button.dart';
import 'inputs/weight_input.dart';

/// Made for cct_management.
/// By User: josedominguez
/// Date: 06/09/24

class EntryForm extends ConsumerStatefulWidget {
  const EntryForm({super.key});

  @override
  EntryFormState createState() => EntryFormState();
}

class EntryFormState extends ConsumerState<EntryForm> {
  late final GlobalKey<FormState> entryFormKey = GlobalKey<FormState>();
  CleanListUtil cleanListUtil = CleanListUtil();

  late final TextEditingController locationController = TextEditingController();
  late final TextEditingController assetsController = TextEditingController();
  late final TextEditingController batchController = TextEditingController();
  late final TextEditingController cartonIdController = TextEditingController();
  late final TextEditingController containerNumberController =
      TextEditingController();
  late final TextEditingController remarksController = TextEditingController();
  late final TextEditingController dmcController = TextEditingController();

  //project state values
  String selectedPerson = " ";
  String selectedWarehouse = " ";

  String selectedDate = " ";

  String expirationDate = " ";
  bool isChecked = false;
  String seriesLength = "0";
  String itemWeight = "0";
  DimensionsDto dimensions = DimensionsDto(height: "0", width: "0", long: "0");
  bool isBadStateItem = false;
  bool isSeries = false;
  bool isValid = false;
  bool isLoading = false;

  List<String> seriesList = [];

  @override
  void initState() {
    entryFormKey.currentState?.reset;
    super.initState();
  }

  void validateRequest() {
    logger
        .d("validating seriesLength ${seriesLength} list ${seriesList.length}");
    if (isSeries) {
      if (int.parse(seriesLength) != seriesList.length) {
        setState(() {
          isValid = false;
          isLoading = false;
        });
        showWarningToast(
            "La series deben coincidir con la cantidad introducida");
      }
    } else {
      if (int.parse(seriesLength) <= 0) {
        setState(() {
          isValid = false;
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
    assetsController.dispose();
    batchController.dispose();
    cartonIdController.dispose();
    containerNumberController.dispose();
    remarksController.dispose();
    dmcController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final customersData = ref.watch(getCustomersProvider);
    final warehouseData = ref.watch(getWarehousesProvider);
    final entryLogicProvider = ref.read(addEntryProvider.notifier);
    var size = MediaQuery.of(context).size;
    return Form(
      key: entryFormKey,
      child: Wrap(
        // spacing: 15.0,
        runSpacing: wrapVerticalSpacing,
        children: [
          Center(
            child: Text(
              "Registrar Entrada",
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
                seriesList: seriesList,
                maxChips: int.parse(seriesLength),
                enable: isSeries,
                onSelectParam: (value) {
                  setState(() {
                    seriesList = value;
                  });
                },
              ),
              customersData.when(
                  data: (data) {
                    // readState.setComponentsLoading(false);
                    logger.i("incoming data ${data.toString()}");
                    return ClientsDropdownButton(
                      key: const Key("2"),
                      onSelectParam: (value) {
                        setState(() {
                          selectedPerson = value;
                        });
                      },
                      title: "Clientes",
                      values: data.body,
                      icon: Icons.arrow_drop_down_circle_outlined,
                    );
                  },
                  error: (err, s) {
                    logger.e("error $s");
                    return Text(err.toString());
                  },
                  loading: () => const LinearProgressIndicator()),
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
                loading: () => const LinearProgressIndicator(),
              ),
              LpnInput(
                controller: cartonIdController,
                title: 'Carton ID',
              ),
              GenericInput(
                controller: containerNumberController,
                title: 'Numero de Contenedor',
              ),
              GenericInput(
                controller: dmcController,
                title: 'DMC',
              ),
              LocationInput(
                controller: locationController,
              ),
              BatchInput(
                controller: batchController,
              ),
              AssetsInput(
                controller: assetsController,
              ),
            ],
          ),
          Wrap(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            runSpacing: wrapVerticalSpacing,
            children: [
              DateInput(
                title: 'Fecha de Llegada',
                onSelectParam: (value) {
                  setState(() {
                    selectedDate = value.toString();
                  });
                },
                // selectedDate: DateTime.parse(selectedDate),
              ),
              DateInput(
                onSelectParam: (value) {
                  setState(() {
                    expirationDate = value.toString();
                  });
                },
                title: 'Fecha de Caducidad',
                // selectedDate: DateTime.parse(expirationDate),
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
                    const Text("Dañado"),
                    Checkbox(
                        semanticLabel: "Dañado",
                        value: isBadStateItem,
                        onChanged: (newBool) {
                          setState(() {
                            isBadStateItem = newBool!;
                          });
                        }),
                  ],
                ),
              ),
              WeightInput(
                title: "Peso en KG",
                decimalPlaces: 2,
                onEditingComplete: (v) {
                  setState(() {
                    itemWeight = v.toString();
                  });
                },
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            child: DimensionsInput(dimensions: dimensions),
          ),
          RemarksInput(
            controller: remarksController,
            title: "Observación",
            allowNull: false,
          ),
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
                        isValid = entryFormKey.currentState!.validate();
                        isLoading = true;
                      });
                      validateRequest();
                      logger.i("form valid $isValid");
                      if (isValid) {
                        if (seriesList.isNotEmpty) {
                          for (String v in seriesList) {
                            if (v.contains(" ")) {
                              seriesList.addAll(cleanListUtil.cleanList(v));
                            }
                          }
                        }
                        var request = InboundDto(
                            docnum: "0001",
                            device: "deviceImei",
                            branch: "1",
                            asset: assetsController.text,
                            user: "user",
                            cartonId: cartonIdController.text,
                            customer: selectedPerson,
                            warehouse: selectedWarehouse,
                            location: locationController.text,
                            batch: batchController.text,
                            series: SeriesDto(series: seriesList),
                            expiryAt: expirationDate.toString(),
                            condition: "$isBadStateItem",
                            quantity: seriesLength,
                            entryAt: selectedDate.toString(),
                            remarks: remarksController.text,
                            dimensions: dimensions,
                            isseries: isSeries.toString(),
                            container: containerNumberController.text,
                            weight: itemWeight,
                            dmc: dmcController.text);

                        // ScaffoldMessenger.of(context).showSnackBar(
                        //   const SnackBar(content: Text("Procesando peticion")),
                        // );

                        entryLogicProvider.addEntry(request).then((value) {
                          var code = value?.status?.code;
                          if (code! >= 200 && code < 300) {
                            showSuccessToast("Entrada Exitosa");
                            entryFormKey.currentState?.reset;
                            context.goNamed(EntryPage.routeName);
                          } else {
                            showErrorToast(
                                "Ha fallado el envio con status ${value?.status?.msg}");
                          }
                        }).whenComplete(() {
                          logger.i("finished Entry");
                          setState(() {
                            isLoading = false;
                          });
                        }).catchError((error) {
                          showErrorToast("Error en el envio de datos  ${error.toString()} !");
                        });
                      } else {
                        setState(() {
                          isLoading = false;
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
