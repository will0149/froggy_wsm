import 'package:cct_management/data/entities/clients/customer_entity.dart';
import 'package:cct_management/data/entities/warehouses/warehouse_entity.dart';
import 'package:cct_management/device/utils/logger_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/**
 * Made for cct_management.
 * By User: josedominguez
 * Date: 07/17/24
 */

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
  Widget build(BuildContext context) {
    List<WarehouseEntity>? warehouses =  widget.values;
    if(warehouses?.length == 1){
      warehouses?.add(WarehouseEntity(name: ""));
    }
    String? selectedValue = warehouses?[0].name.toString();
    return DropdownButtonFormField<String>(
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
