import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../../device/utils/logger_config.dart';
import '../../../domain/dtos/outgoing_dto.dart';
import '../../../domain/providers/add_outgoing_provider.dart';
import '../../constants.dart';
import '../toasts/build_toasts.dart';
import 'inputs/assets_input.dart';
import 'inputs/batch_input.dart';
import 'inputs/date_input.dart';
import 'inputs/dropdown_button_input.dart';
import 'inputs/location_input.dart';
import 'inputs/quantity_input.dart';
import 'inputs/series_input.dart';

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
  late final TextEditingController batchController = TextEditingController();
  late final TextEditingController seriesQuantityController = TextEditingController();
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
    batchController.dispose();
    lpnController.dispose();
    seriesQuantityController.dispose();
    assetsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                }else{
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
          LocationInput(
            controller: locationController,
          ),
          BatchInput(
            controller: batchController,
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
            selectedDate: selectedDate,
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
                      docnum: "",
                      lpn: "",
                      customer: selectedPerson,
                      warehouse: selectedWarehouse,
                      location: locationController.text,
                      batch: batchController.text,
                      // serie: seriesController.text,
                      quantity: seriesQuantityController.text,
                      exitAt: selectedDate.toString(),
                      remarks: "");

                  logger.d(request.toJson());
                  var response = outgoing.addOutgoing(request);
                  response.whenComplete(() {
                    setState(() {
                      isLoading = false;
                    });
                    // context.goNamed(MainPage.routeName);
                  });
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
