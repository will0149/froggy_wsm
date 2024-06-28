import 'dart:io';

import 'package:cct_management/data/entities/clients/client_entity.dart';
import 'package:cct_management/data/entities/status_entity.dart';
import 'package:cct_management/domain/dtos/inbound_dto.dart';
import 'package:cct_management/domain/dtos/series_dto.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_input_chips/flutter_input_chips.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:device_imei/device_imei.dart'; //TODO: replace with one better
import 'package:permission_handler/permission_handler.dart';

import '../../../data/entities/base_data_entity.dart';
import '../../../data/entities/base_response_entity.dart';
import '../../../data/entities/entry_data_entity.dart';
import '../../../device/utils/logger_config.dart';
import '../../../domain/dtos/dimensions_dto.dart';
import '../../../domain/logics/inbound_logic.dart';
import '../../../domain/providers/add_entry_provider.dart';
import '../../../domain/providers/clients/client_provider.dart';
import '../../../domain/utils/clean_list_util.dart';
import '../../constants.dart';
import 'inputs/assets_input.dart';
import 'inputs/batch_input.dart';
import 'inputs/date_input.dart';
import 'inputs/dimensions_input.dart';
import 'inputs/dropdown_button_input.dart';
import 'inputs/location_input.dart';
import 'inputs/lpn_input.dart';
import 'inputs/quantity_input.dart';
import 'inputs/series_input.dart';

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
  late final TextEditingController quantityController =
      TextEditingController(text: "1");

  // late List<ClientEntity>? clientsData = clients;

  String? selectedPerson = " ";
  String? selectedWarehouse = " ";
  DateTime? selectedDate;
  DateTime? expirationDate;
  bool? isChecked = false;
  DimensionsDto? dimensions = DimensionsDto(height: "0", width: "0", long: "0");

  bool _valid = false;
  bool isLoading = false;

  // device info
  // String message = "Please allow permission request!";
  // String? deviceImei;
  // final _deviceImeiPlugin = DeviceImei();
  // bool getPermission = false;
  // DeviceInfo? deviceInfo;
  // String? type;

  List<String> _seriesList = [];

  @override
  void initState() {
    // TODO: implement initState
    // ref.listenManual(addEntryProvider, (previous, next) {});
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    locationController.dispose();
    assetsController.dispose();
    batchController.dispose();
    quantityController.dispose();
    lpnController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // var clientLogic = ref.watch(clientsProvider);
    final provider = ref.read(addEntryProvider.notifier);
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
              DropdownButtonInput(
                onSelectParam: (value) {
                  setState(() {
                    selectedPerson = value;
                  });
                },
                title: "clientes",
                values: clients,
                icon: Icons.arrow_drop_down_circle_outlined,
              ),
              DropdownButtonInput(
                title: "Bodegas",
                values: bodegas,
                onSelectParam: (value) {
                  setState(() {
                    selectedWarehouse = value;
                  });
                },
                icon: Icons.arrow_drop_down_circle_outlined,
              ),
              LpnInput(
                controller: lpnController,
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
              SeriesInput(
                seriesList: _seriesList,
                onSelectParam: (value) {
                  setState(() {
                    _seriesList = value;
                  });
                },
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
                    selectedDate = value;
                  });
                },
                selectedDate: selectedDate,
              ),
              DateInput(
                onSelectParam: (value) {
                  setState(() {
                    expirationDate = value;
                  });
                },
                title: 'Fecha de Caducidad',
                selectedDate: expirationDate,
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
                    const Text("Dañado"),
                    Checkbox(
                        semanticLabel: "Dañado",
                        value: isChecked,
                        onChanged: (newBool) {
                          setState(() {
                            isChecked = newBool;
                          });
                        }),
                  ],
                ),
              ),
            ],
          ),
          Wrap(
            children: [
              QuantityInput(
                controller: quantityController,
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            child: DimensionsInput(dimensions: dimensions),
          ),
          SizedBox(
            height: MediaQuery.of(context).viewInsets.bottom,
          ),
          isLoading
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
                      setState(() {
                        _valid = entryFormKey.currentState!.validate();
                        isLoading = true;
                      });

                      if (_valid) {
                        if(_seriesList.isNotEmpty && _seriesList.length <= 2){
                          for(String v in _seriesList){
                            if(v.contains(" ")){
                              _seriesList.addAll(cleanListUtil.cleanList(v));
                            }
                          }
                        }
                        var request = InboundDto(
                            docnum: "0001",
                            device: "deviceImei",
                            branch: "branch",
                            asset: "PANELSOLAR",
                            user: "user",
                            lpn: lpnController.text,
                            customer: selectedPerson,
                            warehouse: selectedWarehouse,
                            location: locationController.text,
                            batch: batchController.text,
                            series: SeriesDto(series: _seriesList),
                            expiryAt: expirationDate.toString(),
                            condition: "$isChecked",
                            quantity: quantityController.text,
                            entryAt: selectedDate.toString(),
                            remarks: "observación",
                            dimensions: dimensions?.toJson().toString());

                        // ScaffoldMessenger.of(context).showSnackBar(
                        //   const SnackBar(content: Text("Procesando peticion")),
                        // );

                        provider.addEntry(request).then((value) {
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
                            entryFormKey.currentState?.reset();
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
