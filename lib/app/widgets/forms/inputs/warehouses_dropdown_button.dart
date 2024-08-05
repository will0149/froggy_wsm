import 'package:cct_management/data/entities/warehouses/warehouse_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Made for cct_management.
/// By User: josedominguez
/// Date: 07/17/24

class WarehousesDropdownButton extends ConsumerStatefulWidget {
  String title;
  List<WarehouseEntity>? values;
  Function(String) onSelectParam;
  IconData? icon;
  // List<DropdownMenuItem<dynamic>>? items;

  WarehousesDropdownButton({super.key, this.title = "", required this.values, required this.onSelectParam, this.icon});

  @override
  ObjetDropdownButtonState createState() => ObjetDropdownButtonState();
}

class ObjetDropdownButtonState extends ConsumerState<WarehousesDropdownButton> {

  @override
  void initState() {
    // TODO: implement initState
    // widget.values?.add(WarehouseEntity(description: "NONE"));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<WarehouseEntity>? warehouses =  widget.values;
    String? selectedValue = null;
    return DropdownButtonFormField<String>(
      validator: (value){
        if (value == null) {
          return 'El campo no puede estar vacío';
        } else {
          return null;
        }
      },
      decoration:  InputDecoration(
        hintText: 'titulo',
        labelText: widget.title,
        labelStyle: Theme.of(context).textTheme.bodyLarge,
      ),
      icon: Icon(widget.icon),
      alignment: AlignmentDirectional.center,
      onChanged: (newValue) {
        widget.onSelectParam(newValue!);
        setState(() {
          selectedValue = newValue;
        });
      },
      value: selectedValue,
      items: warehouses?.map((WarehouseEntity value) {
        return DropdownMenuItem(
          value: "${value.description}",
          child: Text("${value.description}"),
        );
      }).toList(),
    );
  }
}
