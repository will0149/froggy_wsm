import 'package:cct_management/data/entities/clients/customer_entity.dart';
import 'package:cct_management/device/utils/logger_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/**
 * Made for cct_management.
 * By User: josedominguez
 * Date: 07/17/24
 */

class ClientsDropdownButton extends ConsumerStatefulWidget {
  String title;
  List<CustomerEntity>? values;
  Function(String) onSelectParam;
  IconData? icon;
  // List<DropdownMenuItem<dynamic>>? items;

  ClientsDropdownButton({super.key, this.title = "", required this.values, required this.onSelectParam, this.icon});

  @override
  ObjetDropdownButtonState createState() => ObjetDropdownButtonState();
}

class ObjetDropdownButtonState extends ConsumerState<ClientsDropdownButton> {

  @override
  Widget build(BuildContext context) {
    List<CustomerEntity>? clients =  widget.values;
    if(clients?.length == 1){
      clients?.add(CustomerEntity(name: ""));
    }
    String? selectedValue = clients?[0].name.toString();
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
      items: clients?.map((CustomerEntity value) {
        logger.i("${value.toJson()}");
        return DropdownMenuItem(
          value: "${value.name}",
          child: Text("${value.name}"),
        );
      }).toList(),
    );
  }
}
