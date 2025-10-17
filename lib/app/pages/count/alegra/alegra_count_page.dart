import 'package:froggy_soft/app/widgets/scaffolds/exit_pop_scope.dart';
import 'package:froggy_soft/app/widgets/scaffolds/safe_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:froggy_soft/domain/providers/alegra_recount_provider.dart';
import 'package:go_router/go_router.dart';

import '../../../widgets/forms/alegra/alegra_count_form.dart';
import '../../../widgets/forms/base_form_decorator.dart';
import '../../../widgets/toasts/build_toasts.dart';
import '../../warehouse/alegra_comparison_table_page.dart';

/// Made for froggysoft.
/// By User: josedominguez
/// Date: 06/11/24

class AlegraCountPage extends ConsumerStatefulWidget {
  const AlegraCountPage({super.key});

  @override
  ConsumerState<AlegraCountPage> createState() => _AlegraCountPageState();
  static String get routeName => 'count';
  static String get routeLocation => routeName;
}

class _AlegraCountPageState extends ConsumerState<AlegraCountPage> {
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

  /// Valida e inserta los datos en la tabla de reconteo
  /// Luego redirige a la página de comparación
  Future<void> validateAndUpdateData() async {
    if (addedItems.isEmpty) {
      showWarningToast("No hay datos para validar");
      return;
    }

    try {
      // Obtener la función de inserción del provider
      final insertItems = ref.read(insertRecountItemsProvider);

      // Insertar los items en la tabla recount_items
      await insertItems(addedItems.cast<Map<String, dynamic>>());

      showSuccessToast("${addedItems.length} items guardados exitosamente");

      // Limpiar la lista después de validar
      setState(() {
        addedItems.clear();
      });

      // Redirigir a la página de comparación
      if (mounted) {
        context.pushNamed(AlegraComparisonTablePage.routeName);
      }
    } catch (e) {
      showErrorToast("Error al guardar datos: $e");
    }
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
              spacing: 8,
              children: [
                BaseFormDecorator(
                  body: AlegraCountForm(
                    onAddItem: addItem,
                    onValidateData: validateAndUpdateData,
                  ),
                ),
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
