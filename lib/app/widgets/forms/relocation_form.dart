import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../device/utils/logger_config.dart';
import '../../../domain/dtos/relocation_dto.dart';
import '../../../domain/providers/relocate_provider.dart';
import '../../constants.dart';

/**
 * Made for cct_management.
 * By User: josedominguez
 * Date: 06/11/24
 */

class RelocationForm extends ConsumerStatefulWidget {
  const RelocationForm({super.key});

  @override
  _RelocationFormState createState() => _RelocationFormState();
}

class _RelocationFormState extends ConsumerState<RelocationForm> {

  late final GlobalKey<FormState> relocationFormKey = GlobalKey<FormState>();

  late final TextEditingController locationFromController =
      TextEditingController();
  late final TextEditingController locationToController =
      TextEditingController();
  late final TextEditingController seriesController = TextEditingController();

  late final TextEditingController quantityController = TextEditingController();

  String? selectedWarehouseFrom;
  String? selectedWarehouseTo;
  bool _valid = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    var relocateItems = ref.watch(relocateProvider);
    var size = MediaQuery.of(context).size;
    return Form(
      key: relocationFormKey,
        child: Wrap(
      runSpacing: wrapVerticalSpacing,
      children: [
        Center(
          child: Text(
            "Reubicar Mercancia",
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        Wrap(
          runSpacing: wrapVerticalSpacing,
          children: [
            TextFormField(
              controller: seriesController,
              decoration: const InputDecoration(
                hintText: 'N2J3N1K2N2',
                labelText: 'Serie',
                // prefixIcon: Icon(Icons.location_on_outlined),
              ),
              validator: (String? value) {
                if (value == null) {
                  return 'Please select an option';
                }
                return null;
              },
            ),
            TextFormField(
              controller: locationFromController,
              decoration: const InputDecoration(
                hintText: 'Colón',
                labelText: 'Ubicación Origen',
                prefixIcon: Icon(Icons.location_on_outlined),
              ),
              validator: (String? value) {
                if (value == null) {
                  return 'Please select an option';
                }
                return null;
              },
            ),
            TextFormField(
              controller: locationToController,
              decoration: const InputDecoration(
                hintText: 'Panamá',
                labelText: 'Ubicación Destino',
                prefixIcon: Icon(Icons.location_on_outlined),
              ),
              validator: (String? value) {
                if (value == null) {
                  return 'Please select an option';
                }
                return null;
              },
            ),
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
                    value: selectedWarehouseFrom,
                    hint: Text(
                      'Bodega Origen',
                      style: Theme.of(context).textTheme.bodySmall,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      softWrap: false,
                    ),
                    icon: const Icon(Icons.warehouse),
                    alignment: AlignmentDirectional.center,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedWarehouseFrom = newValue;
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
            ),
            Column(
              children: [
                Container(
                  width: size.width * 0.40,
                  child: DropdownButtonFormField<String>(
                    value: selectedWarehouseTo,
                    icon: const Icon(Icons.warehouse),
                    alignment: AlignmentDirectional.center,
                    hint: Text(
                      'Bodega Destino',
                      style: Theme.of(context).textTheme.bodySmall,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      softWrap: false,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedWarehouseTo = newValue;
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
                _valid = relocationFormKey.currentState!.validate();
                isLoading = true;
              });
              if (_valid) {
                var request = RelocationDto(
                    serie: seriesController.text,
                    lpn: "qeqwe",
                    towardswarehouse: selectedWarehouseTo,
                    towardslocation: locationFromController.text,
                    fromlocation: selectedWarehouseFrom,
                    fromwarehouse: locationFromController.text,
                    quantity: quantityController.text,
                    remarks: "qwe"
                );

                logger.d(request.toJson());
                var response = relocateItems.relocate(request);
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
    ));
  }
}
