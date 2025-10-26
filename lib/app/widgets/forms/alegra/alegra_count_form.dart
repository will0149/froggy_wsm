import 'package:froggy_soft/domain/logics/count_logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/providers/tally_count_provider.dart';
import '../../../../generated/l10n.dart';
import '../../../constants.dart';
import '../inputs/generic_input.dart';


/// Made for froggysoft.
/// By User: josedominguez
/// Date: 06/11/24

class AlegraCountForm extends ConsumerStatefulWidget {
  final Function(String sku, String cantidad)? onAddItem;
  final Future<void> Function()? onValidateData;
  final bool hasItems;

  const AlegraCountForm({
    super.key,
    this.onAddItem,
    this.onValidateData,
    this.hasItems = false,
  });

  @override
  CountFormState createState() => CountFormState();
}

class CountFormState extends ConsumerState<AlegraCountForm> {
  late final GlobalKey<FormState> countFormKey = GlobalKey<FormState>();

  late final TextEditingController itemIdController = TextEditingController(text: "");

  late final TextEditingController locationController = TextEditingController(text: "");
  late final TextEditingController skuController = TextEditingController(text: "");
  late final TextEditingController quantityController = TextEditingController(text: "");

  /// FocusNode para el campo SKU
  late final FocusNode skuFocusNode = FocusNode();

  bool _valid = false;
  bool isLoading = false;

  bool dataValidate = false;
  bool isFinalized = false;

  @override
  void initState() {
    countFormKey.currentState?.reset;
    super.initState();

    // Enfocar el campo SKU cuando se inicia la pantalla
    WidgetsBinding.instance.addPostFrameCallback((_) {
      skuFocusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    skuController.dispose();
    quantityController.dispose();
    skuFocusNode.dispose();
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
              "Conteo de inventario",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Wrap(
            runSpacing: wrapVerticalSpacing,
            children: [
              GenericInput(
                controller: skuController,
                focusNode: skuFocusNode,
                isNumber: false,
                textCapitalization: TextCapitalization.characters,
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
                              // Enfocar el campo SKU después de agregar datos
                              skuFocusNode.requestFocus();
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
                          title: Text(
                            "Finalizar entrada de datos",
                            style: TextStyle(
                              color: widget.hasItems ? null : Colors.grey,
                            ),
                          ),
                          value: isFinalized,
                          onChanged: widget.hasItems ? (bool? value) {
                            setState(() {
                              isFinalized = value ?? false;
                            });
                          } : null,
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
                          onPressed: isFinalized ? () async {
                            setState(() {
                              isLoading = true;
                            });

                            // Llamar a la función de validación
                            await widget.onValidateData?.call();

                            setState(() {
                              isLoading = false;
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
      // tallyCount.countValidate(data).then((value) {
      //   var code = value?.status?.code;
      //   if (kDebugMode) logger.i("code in form $code");
      //   if (code! >= 200 && code < 300) {
      //     showSuccessToast("Datos validados");
      //     setState(() {
      //       dataValidate = true;
      //       isLoading = false;
      //     });
      //   } else {
      //     showErrorToast(
      //         "Ha fallado el envio con status ${value?.status?.msg}");
      //   }
      // }).whenComplete(() {
      //   if (kDebugMode) logger.i("finished Count");
      //   setState(() {
      //     isLoading = false;
      //   });
      // }).catchError((error) {
      //   if (kDebugMode) logger.e("bruja ${error.toString()}");
      //   setState(() {
      //     isLoading = false;
      //   });
      //   showErrorToast("Algo fallo ${error.toString()}!");
      // });
    }else {
      setState(() {
        isLoading = false;
      });
    }
  }
}
