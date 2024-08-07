import 'package:cct_management/app/widgets/scaffolds/safe_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/**
 * Made for cct_management.
 * By User: josedominguez
 * Date: 08/04/24
 */

class SearchTablePage extends ConsumerStatefulWidget {
  static String get routeName => 'search/items';
  static String get routeLocation => routeName;
  const SearchTablePage({super.key});

  @override
  SearchTableState createState() => SearchTableState();
}

class SearchTableState extends ConsumerState<SearchTablePage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeScaffold(
      appBar: AppBar(
        title: Text(
          "Búscar en inventario",
          style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(10.0),
            margin: const EdgeInsets.all(10.0),
            width: size.width * 0.9,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: size.width * 0.7,
                child: TextField(),
              ),

              IconButton(
                //onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const SearchPage())),
                onPressed: () {},
                icon: const Icon(Icons.search),
              )
            ],
          ),
    ),
        ],
      ),
    );
  }
}
