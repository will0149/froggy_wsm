import 'package:cct_management/domain/dtos/inbound_dto.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../../device/utils/logger_config.dart';
import '../../../domain/providers/add_entry_provider.dart';
import '../../constants.dart';

/**
 * Made for cct_management.
 * By User: josedominguez
 * Date: 06/09/24
 */

class EntryForm extends ConsumerStatefulWidget {
  const EntryForm({super.key});

  @override
  _EntryFormState createState() => _EntryFormState();
}

class _EntryFormState extends ConsumerState<EntryForm> {
  late final GlobalKey<FormState> entryFormKey = GlobalKey<FormState>();

  late final TextEditingController locationController = TextEditingController();
  late final TextEditingController batchController = TextEditingController();
  late final TextEditingController seriesController = TextEditingController();
  late final TextEditingController quantityController = TextEditingController();

  String? selectedPerson;
  String? selectedWarehouse;
  DateTime? selectedDate;
  bool? isChecked = false;
  bool _valid = false;
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    initializeDateFormatting();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var inboundPost = ref.watch(addEntryProvider);
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
            spacing: 30.0, //espacio horizontal
            // runSpacing: 10.0, //espacio vertical
            children: [
              Column(
                children: [
                  Container(
                    // color: Colors.lightBlueAccent,
                    width: size.width * 0.40,
                    child: DropdownButtonFormField<String>(
                      value: selectedPerson,
                      hint: Text(
                        'Cliente',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      icon: const Icon(Icons.person),
                      alignment: AlignmentDirectional.center,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedPerson = newValue;
                        });
                      },
                      validator: (String? value) {
                        if (value == null) {
                          return 'Please select an option';
                        }
                        return null;
                      },
                      items:
                          clients.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    width: size.width * 0.40,
                    child: DropdownButtonFormField<String>(
                      value: selectedWarehouse,
                      icon: const Icon(Icons.warehouse),
                      alignment: AlignmentDirectional.center,
                      hint: Text(
                        'Bodega',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedWarehouse = newValue;
                        });
                      },
                      validator: (String? value) {
                        if (value == null) {
                          return 'Please select an option';
                        }
                        return null;
                      },
                      items:
                          bodegas.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              )
            ],
          ),
          Wrap(
            runSpacing: wrapVerticalSpacing,
            children: [
              TextFormField(
                controller: locationController,
                decoration: const InputDecoration(
                  hintText: 'Colón',
                  labelText: 'Ubicación',
                  prefixIcon: Icon(Icons.location_on_outlined),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'El campo no puede estar vacío';
                  } else {
                    return null;
                  }
                },
              ),
              TextFormField(
                controller: batchController,
                decoration: const InputDecoration(
                  hintText: '45',
                  labelText: 'Lote',
                  // prefixIcon: Icon(Icons.),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'El campo no puede estar vacío';
                  } else {
                    return null;
                  }
                },
              ),
              TextFormField(
                controller: seriesController,
                decoration: const InputDecoration(
                  hintText: 'N2J3N1K2N2',
                  labelText: 'Serie',
                  // prefixIcon: Icon(Icons.location_on_outlined),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'El campo no puede estar vacío';
                  } else {
                    return null;
                  }
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: size.width * 0.40,
                child: DateTimeFormField(
                  decoration: InputDecoration(
                    labelText: 'Seleccion la fecha',
                    labelStyle: Theme.of(context).textTheme.bodySmall,
                  ),
                  initialPickerDateTime:
                      DateTime.now().add(const Duration(days: 20)),
                  mode: DateTimeFieldPickerMode.date,
                  onChanged: (DateTime? value) {
                    selectedDate = value;
                  },
                ),
              ),
              SizedBox(
                  width: size.width * 0.40,
                  child: Row(
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
                  ))
            ],
          ),
          Wrap(
            children: [
              TextFormField(
                controller: quantityController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: '1',
                  labelText: 'Cantidad',
                  prefixIcon: Icon(Icons.numbers_sharp),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'El campo no puede estar vacío';
                  } else {
                    return null;
                  }
                },
              ),
            ],
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
                        _valid = entryFormKey.currentState!.validate();
                        isLoading = true;
                      });
                      if (_valid) {
                        var request = InboundDto(
                            docnum: "",
                            lpn: "",
                            customer: selectedPerson,
                            warehouse: selectedWarehouse,
                            location: locationController.text,
                            batch: batchController.text,
                            serie: seriesController.text,
                            expiryAt: "",
                            condition: "$isChecked",
                            quantity: quantityController.text,
                            entryAt: selectedDate.toString(),
                            remarks: "");

                        logger.d(request.toJson());
                        var response = inboundPost.addEntry(request);
                        response.whenComplete(() {
                          setState(() {
                            isLoading = false;
                          });
                          // context.goNamed(MainPage.routeName);
                        });
                        logger.i("Form response");
                        logger.i(response);
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
