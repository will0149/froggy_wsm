import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../device/utils/logger_config.dart';
import '../../../domain/dtos/tally_count_dto.dart';
import '../../../domain/providers/tally_count_provider.dart';
import '../../constants.dart';

/**
 * Made for cct_management.
 * By User: josedominguez
 * Date: 06/11/24
 */

class CountForm extends ConsumerStatefulWidget {
  const CountForm({super.key});

  @override
  _CountFormState createState() => _CountFormState();
}

class _CountFormState extends ConsumerState<CountForm> {
  late final GlobalKey<FormState> countFormKey = GlobalKey<FormState>();

  late final TextEditingController seriesController = TextEditingController();
  late final TextEditingController quantityController = TextEditingController();

  bool _valid = false;
  bool isLoading = false;

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
              "Conteo",
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
                controller: quantityController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: '1',
                  labelText: 'Cantidad',
                  // prefixIcon: Icon(Icons.location_on_outlined),
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
                        _valid = countFormKey.currentState!.validate();
                        isLoading = true;
                      });
                      if (_valid) {
                        var request = TallyCountDto(
                          lpn: "afas",
                          warehouse: "asdfas",
                          location: "jsfs",
                          serie: seriesController.text,
                          quantity: quantityController.text,
                        );

                        logger.d(request.toJson());
                        var response = tallyCount.count(request);
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
