import 'package:cct_management/domain/logics/count_logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../device/utils/logger_config.dart';
import '../../../../domain/dtos/series_dto.dart';
import '../../../../domain/dtos/tally_count_dto.dart';
import '../../../../domain/providers/tally_count_provider.dart';
import '../../../../domain/providers/warehouses/get_warehouses_provider.dart';
import '../../../../generated/l10n.dart';
import '../../../constants.dart';
import '../../../pages/count/count_page.dart';
import '../../toasts/build_toasts.dart';
import '../inputs/assets_input.dart';
import '../inputs/generic_input.dart';
import '../inputs/location_input.dart';
import '../inputs/lpn_input.dart';
import '../inputs/quantity_input.dart';
import '../inputs/series_input.dart';
import '../inputs/warehouses_dropdown_button.dart';


/// Made for cct_management.
/// By User: josedominguez
/// Date: 06/11/24

class AlegraCountForm extends ConsumerStatefulWidget {
  final Function(String sku, String cantidad)? onAddItem;

  const AlegraCountForm({super.key, this.onAddItem});

  @override
  CountFormState createState() => CountFormState();
}

class CountFormState extends ConsumerState<AlegraCountForm> {
  late final GlobalKey<FormState> countFormKey = GlobalKey<FormState>();

  late final TextEditingController itemIdController = TextEditingController(text: "");

  late final TextEditingController locationController = TextEditingController(text: "");
  late final TextEditingController skuController = TextEditingController(text: "");
  late final TextEditingController quantityController = TextEditingController(text: "");

  String selectedWarehouse = " ";
  String seriesLength = "0";
  List<String> _seriesList = [];

  bool isSeries = false;
  bool _valid = false;
  bool isLoading = false;

  TallyCountDto data = TallyCountDto();

  bool dataValidate = false;
  bool isFinalized = false;

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
    skuController.dispose();
    quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              GenericInput(
                controller: skuController,
                isNumber: false,
                title: 'SKU de producto',
              ),
              GenericInput(
                title: "Cantidad",
                isNumber: true,
                controller: quantityController,
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
                  padding: const EdgeInsets.all(5.0),
                  child: Wrap(
                    spacing: 20.0,
                    runSpacing: 10.0,
                    children: [
                      SizedBox(
                        width: size.width,
                        child: OutlinedButton(
                          style: ElevatedButton.styleFrom(
                            // Define button's look with styleFrom
                            foregroundColor: Colors.blueAccent,
                            backgroundColor: Colors.lightGreenAccent, // Set the text (and icon) color
                            disabledBackgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              // The button's outline is defined as a rounded rectangle with circular corners
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                          onPressed: isFinalized ? null : () {
                            if (skuController.text.isNotEmpty && quantityController.text.isNotEmpty) {
                              widget.onAddItem?.call(skuController.text, quantityController.text);
                              // Clear the fields after adding
                              skuController.clear();
                              quantityController.clear();
                            }
                          },
                          child: Text("Agregar datos",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(color: Colors.black, fontWeight: FontWeight.w400)),
                        ),
                      ),
                      // Checkbox to finalize data entry
                      SizedBox(
                        width: size.width,
                        child: CheckboxListTile(
                          title: const Text("Finalizar entrada de datos"),
                          value: isFinalized,
                          onChanged: (bool? value) {
                            setState(() {
                              isFinalized = value ?? false;
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                      ),
                      SizedBox(
                        width: size.width,
                        child: dataValidate
                            ? OutlinedButton(
                          onPressed: isFinalized ? () {
                            setState(() {
                              _valid = countFormKey.currentState!.validate();
                              isLoading = true;
                            });
                            sendData(tallyCount);
                          } : null,
                          child: Text(S.of(context).saveButton,
                              style:
                              Theme.of(context).textTheme.headlineMedium),
                        )
                            : OutlinedButton(
                          style: ElevatedButton.styleFrom(
                            // Define button's look with styleFrom
                            foregroundColor: Colors.blueAccent,
                            backgroundColor: Colors.lightGreenAccent, // Set the text (and icon) color
                            disabledBackgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              // The button's outline is defined as a rounded rectangle with circular corners
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                          onPressed: isFinalized ? () {
                            setState(() {
                              _valid = countFormKey.currentState!.validate();
                              isLoading = true;
                              data = TallyCountDto(
                                  device: "phone",
                                  branch: "1",
                                  warehouse: selectedWarehouse,
                                  location: locationController.text,
                                  cartonid: skuController.text,
                                  asset: quantityController.text,
                                  isSeries: isSeries.toString(),
                                  series: SeriesDto(series: _seriesList),
                                  quantity: seriesLength,
                                  remark: "sfafafas");
                            });
                          } : null,
                          child: Text("Validar datos",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(color: Colors.black, fontWeight: FontWeight.w400)),
                        ),
                      ),
                    ],
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

  void sendData(CountLogic tallyCount){
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
              "Ha fallado el envio con status ${value?.status?.msg}");
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
        showErrorToast("Algo fallo ${error.toString()}!");
      });
    }else {
      setState(() {
        isLoading = false;
      });
    }
  }
}
