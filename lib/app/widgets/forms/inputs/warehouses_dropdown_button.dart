import 'package:froggy_soft/data/entities/warehouses/warehouse_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../device/utils/logger_config.dart';
import '../../../../generated/l10n.dart';

/// Made for froggysoft.
/// By User: josedominguez
/// Date: 07/17/24

class WarehousesDropdownButton extends ConsumerStatefulWidget {
  final String title;
  final List<WarehouseEntity>? values;
  final Function(String) onSelectParam;
  final IconData? icon;
  // List<DropdownMenuItem<dynamic>>? items;

  const WarehousesDropdownButton({super.key, this.title = "", required this.values, required this.onSelectParam, this.icon});

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
    String? selectedValue;
    return DropdownButtonFormField<String>(
      isDense: true,
      isExpanded: true,
      validator: (value){
        if (value == null) {
          return S.of(context).fieldCantBeEmpty;
        } else {
          return null;
        }
      },
      decoration:  InputDecoration(
        hintText: S.of(context).selectAnOption,
        labelText: widget.title,
        labelStyle: Theme.of(context).textTheme.bodyLarge,
      ),
      icon: Icon(widget.icon),
      // alignment: AlignmentDirectional.center,
      onChanged: (newValue) {
        logger.w("$newValue");
        widget.onSelectParam(newValue!);
        setState(() {
          selectedValue = newValue;
        });
      },
      value: selectedValue,
      items: warehouses?.map((WarehouseEntity value) {
        return DropdownMenuItem(
          value: "${value.id}",
          child: Text(
            "${value.description}",
            softWrap: true,
            overflow: TextOverflow.ellipsis,
          ),
        );
      }).toList(),
    );
  }
}
