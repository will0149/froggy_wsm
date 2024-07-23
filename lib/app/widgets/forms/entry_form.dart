import 'package:cct_management/app/pages/entry/entry_page.dart';
import 'package:cct_management/domain/dtos/inbound_dto.dart';
import 'package:cct_management/domain/dtos/series_dto.dart';
import 'package:cct_management/domain/providers/warehouses/get_warehouses_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

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
import 'inputs/dropdown_button_input.dart';
import 'inputs/location_input.dart';
import 'inputs/lpn_input.dart';
import 'inputs/quantity_input.dart';
import 'inputs/series_input.dart';
import 'inputs/warehouses_dropdown_button.dart';

/**
 * Made for cct_management.
 * By User: josedominguez
 * Date: 06/09/24
 */

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
  late final TextEditingController lpnController = TextEditingController();
  late final TextEditingController containerNumberController =
      TextEditingController();
  late final TextEditingController seriesQuantityController =
      TextEditingController(text: "1");

  @override
  void initState() {
    super.initState();
  }

  void validateRequest() {
    final viewModel = ref.watch(entryFormViewProvider);
    final readState = ref.read(entryFormViewProvider.notifier);
    logger.d(
        "validating seriesLength ${viewModel.seriesLength} list ${viewModel.seriesList.length}");
    if (viewModel.isSeries) {
      if (int.parse(viewModel.seriesLength) != viewModel.seriesList.length) {
        readState.setIsValid(false);
        readState.setIsLoading(false);
        showWarningToast(
            "La series deben coincidir con la cantidad introducida");
      }
    } else {
      if (int.parse(viewModel.seriesLength) <= 0) {
        readState.setIsValid(false);
        readState.setIsLoading(false);
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
    lpnController.dispose();
    containerNumberController.dispose();
    seriesQuantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final customersData = ref.watch(getCustomersProvider);
    final warehouseData = ref.watch(getWarehousesProvider);
    final viewState = ref.watch(entryFormViewProvider);
    final readState = ref.read(entryFormViewProvider.notifier);
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
                        value: viewState.isSeries,
                        onChanged: (newBool) {
                          readState.setIsSeries(newBool!);
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
                    readState.setSeriesLength(v.toInt().toString());
                  } else {
                    readState.setSeriesLength(v.toInt().toString());
                  }
                },
              ),
              SeriesInput(
                initialValue: [],
                seriesList: viewState.seriesList,
                maxChips: int.parse(viewState.seriesLength),
                enable: viewState.isSeries,
                onSelectParam: (value) {
                  readState.setSeriesList(value);
                },
              ),
              customersData.when(
                  data: (data) {
                    // readState.setComponentsLoading(false);
                    logger.i("incoming data ${data.toString()}");
                    return ClientsDropdownButton(
                      onSelectParam: (value) {
                        readState.setSelectedPerson(value);
                      },
                      title: "clientes",
                      values: data.body,
                      icon: Icons.arrow_drop_down_circle_outlined,
                    );
                  },
                  error: (err, s) {
                    logger.e("error ${s}");
                    return Text(err.toString());
                  },
                  loading: () => Skeletonizer(
                        enabled: true,
                        enableSwitchAnimation: true,
                        child: DropdownButton<String>(
                          items: [],
                          onChanged: (Object? value) {},
                        ),
                      )),
              warehouseData.when(
                  data: (data) {
                    // readState.setComponentsLoading(false);
                    logger.i("incoming data ${data.toString()}");
                    return WarehousesDropdownButton(
                      onSelectParam: (value) {
                        readState.setSelectedWarehouse(value);
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
                  loading: () => Skeletonizer(
                        enabled: true,
                        enableSwitchAnimation: true,
                        child: DropdownButton<String>(
                          items: [],
                          onChanged: (Object? value) {},
                        ),
                      )),
              DropdownButtonInput(
                title: "Bodegas",
                values: bodegas,
                onSelectParam: (value) {
                  readState.setSelectedWarehouse(value);
                },
                icon: Icons.arrow_drop_down_circle_outlined,
              ),
              LpnInput(
                controller: lpnController,
                title: 'carton ID',
              ),
              LpnInput(
                controller: containerNumberController,
                title: 'Numero de Contenedor',
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
                  readState.setSelectedDate(value.toString());
                },
                // selectedDate: DateTime.parse(viewState.selectedDate),
              ),
              DateInput(
                onSelectParam: (value) {
                  readState.setExpirationDate(value.toString());
                },
                title: 'Fecha de Caducidad',
                // selectedDate: DateTime.parse(viewState.expirationDate),
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
                        value: viewState.isBadStateItem,
                        onChanged: (newBool) {
                          readState.setBadStateItem(newBool!);
                        }),
                  ],
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            child: DimensionsInput(dimensions: viewState.dimensions),
          ),
          SizedBox(
            height: MediaQuery.of(context).viewInsets.bottom,
          ),
          viewState.isLoading
              ? Container(
                  margin: EdgeInsets.all(10.0),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ))
              : Container(
                  width: size.width,
                  margin: EdgeInsets.all(10.0),
                  child: OutlinedButton(
                    onPressed: () {
                      readState.setIsLoading(true);
                      validateRequest();
                      logger.i("form valid ${viewState.isValid}");
                      if (entryFormKey.currentState!.validate()) {
                        if (viewState.seriesList.isNotEmpty) {
                          for (String v in viewState.seriesList) {
                            if (v.contains(" ")) {
                              viewState.seriesList
                                  .addAll(cleanListUtil.cleanList(v));
                            }
                          }
                        }
                        var request = InboundDto(
                            docnum: "0001",
                            device: "deviceImei",
                            branch: "branch",
                            asset: assetsController.text,
                            user: "user",
                            cartonId: lpnController.text,
                            customer: viewState.selectedPerson,
                            warehouse: viewState.selectedWarehouse,
                            location: locationController.text,
                            batch: batchController.text,
                            series: SeriesDto(series: viewState.seriesList),
                            expiryAt: viewState.expirationDate.toString(),
                            condition: "${viewState.isBadStateItem}",
                            quantity: viewState.seriesLength,
                            entryAt: viewState.selectedDate.toString(),
                            remarks: "observación",
                            dimensions: viewState.dimensions,
                            isseries: viewState.isSeries.toString(),
                            container: containerNumberController.text);

                        // ScaffoldMessenger.of(context).showSnackBar(
                        //   const SnackBar(content: Text("Procesando peticion")),
                        // );

                        entryLogicProvider.addEntry(request).then((value) {
                          var code = value?.status?.code;
                          if (code! >= 200 && code < 300) {
                            readState.setSelectedWarehouse("");
                            readState.setSelectedPerson("");
                            readState.setSelectedDate("");
                            readState.setExpirationDate("");
                            readState.setIsChecked(false);
                            readState.setSeriesLength("0");
                            readState.setDimensions(DimensionsDto(
                                height: "0", width: "0", long: "0"));
                            readState.setBadStateItem(false);
                            readState.setIsSeries(false);
                            readState.setIsValid(false);
                            readState.setIsLoading(false);
                            readState.setSeriesList(const []);
                            showSuccessToast("Agregado Correctamente");
                            entryFormKey.currentState?.reset();
                            context.goNamed(EntryPage.routeName);
                          }else {
                            showErrorToast("Ha fallado el envio con status $code!");
                          }
                        }).whenComplete(() {
                          logger.i("finished Entry");
                          readState.setIsLoading(false);
                        }).catchError((error) {
                          showErrorToast("Error en el envio de datos!");
                        });
                      } else {
                        readState.setIsLoading(false);
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
