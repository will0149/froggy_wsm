import 'package:cct_management/app/widgets/scaffolds/exit_pop_scope.dart';
import 'package:cct_management/app/widgets/scaffolds/safe_scaffold.dart';
import 'package:flutter/material.dart';

import '../../../widgets/forms/alegra/alegra_count_form.dart';
import '../../../widgets/forms/base_form_decorator.dart';

/// Made for cct_management.
/// By User: josedominguez
/// Date: 06/11/24

class AlegraCountPage extends StatefulWidget {
  const AlegraCountPage({super.key});

  @override
  State<AlegraCountPage> createState() => _AlegraCountPageState();
  static String get routeName => 'count';
  static String get routeLocation => routeName;
}

class _AlegraCountPageState extends State<AlegraCountPage> {
  List<Map<String, String>> addedItems = [];

  void addItem(String sku, String cantidad) {
    // Check if SKU already exists
    bool skuExists = addedItems.any((item) => item['sku'] == sku);

    if (skuExists) {
      // Show error message for duplicate SKU
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('El SKU "$sku" ya existe en la lista'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
        ),
      );
      return;
    }

    setState(() {
      addedItems.add({'sku': sku, 'cantidad': cantidad});
    });
  }

  @override
  Widget build(BuildContext context) {
    return ExitPopScope(
      child: SafeScaffold(
        appBar: AppBar(
          title: const Text("Conteo"),
          centerTitle: true,
        ),
        child: SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                BaseFormDecorator(
                  body: AlegraCountForm(onAddItem: addItem),
                ),
                const SizedBox(height: 16),
                Container(
                  margin: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                          ),
                        ),
                        child: const Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding: EdgeInsets.all(12),
                                child: Text(
                                  'SKU',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.all(12),
                                child: Text(
                                  'Cantidad',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      addedItems.isEmpty
                          ? const Padding(
                              padding: EdgeInsets.all(16),
                              child: Text(
                                'No hay datos agregados',
                                style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  color: Colors.grey,
                                ),
                              ),
                            )
                          : ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: addedItems.length,
                              separatorBuilder: (context, index) => Divider(
                                height: 1,
                                color: Colors.grey.shade300,
                              ),
                              itemBuilder: (context, index) {
                                final item = addedItems[index];
                                return Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Padding(
                                        padding: const EdgeInsets.all(12),
                                        child: Text(item['sku'] ?? ''),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(12),
                                        child: Text(item['cantidad'] ?? ''),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
