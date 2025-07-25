import 'package:cct_management/data/entities/clients/customer_entity.dart';
import 'package:cct_management/device/utils/logger_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../generated/l10n.dart';

/// Made for cct_management.
/// By User: josedominguez
/// Date: 07/17/24

class ClientsDropdownButton extends ConsumerStatefulWidget {
  final String title;
  final List<CustomerEntity>? values;
  final Function(String) onSelectParam;
  final IconData? icon;
  // List<DropdownMenuItem<dynamic>>? items;

  const ClientsDropdownButton({super.key, this.title = "", required this.values, required this.onSelectParam, this.icon});

  @override
  ObjetDropdownButtonState createState() => ObjetDropdownButtonState();
}

class ObjetDropdownButtonState extends ConsumerState<ClientsDropdownButton> {

  @override
  void initState() {
    // TODO: implement initState
    // widget.values?.add(CustomerEntity(name: "NONE"));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<CustomerEntity>? clients =  widget.values;
    String? selectedValue = null;
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
        hintText: 'titulo',
        labelText: widget.title,
        labelStyle: Theme.of(context).textTheme.bodyLarge,
      ),
      icon: Icon(widget.icon),
      // alignment: AlignmentDirectional.center,
      onChanged: (newValue) {
        widget.onSelectParam(newValue!);
        setState(() {
          selectedValue = newValue;
        });
      },
      value: selectedValue,
      items: clients?.map((CustomerEntity value) {
        // logger.i("${value.toJson()}");
        return DropdownMenuItem(
          value: "${value.id}",
          child: Text(
            "${value.name}",
            softWrap: true,
            overflow: TextOverflow.ellipsis,),
        );
      }).toList(),
    );
  }
}
