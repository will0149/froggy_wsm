import 'package:flutter/material.dart';

import 'package:parkea/src/config/loggerConfig.dart';

class HorizontalFilterList extends StatefulWidget {
  final List<String> filterListItems;

  const HorizontalFilterList({Key? key, required this.filterListItems})
      : super(key: key);

  @override
  _HorizontalFilterListState createState() => _HorizontalFilterListState();
}

class _HorizontalFilterListState extends State<HorizontalFilterList> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      height: 60,
      child: horizontalCategoryListView(widget.filterListItems),
    );
  }

  ListView horizontalCategoryListView(List<String> titles) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: <Widget>[
        for (var item in titles)
          InkWell(
            splashColor: Colors.blueGrey,
            highlightColor: Colors.blue,
            onTap: () {
              setState(() {
                selectedIndex = titles.indexOf(item);
              });
              logger.wtf("selected index $selectedIndex");
            },
            child: _buildCategoryListItemIndicator(
              item,
              identical(titles.indexOf(item), selectedIndex),
            ),
          ),
      ],
    );
  }

  Widget _buildCategoryListItemIndicator(String title, bool active) {
    var activeTextColor =
    active ? Colors.white : Colors.blueGrey;
    var activeLineColor = active ? Colors.white : Colors.transparent;
    return Padding(
      padding: const EdgeInsets.only(
        left: 10,
        right: 10,
        top: 0,
        bottom: 10,
      ),
      child: Container(
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              //fontFamily: PentacleFontFamily.Poppins,
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.normal,
              fontSize: 18,
              height: 2,
              color: activeTextColor,
            ),
          ),
        ),
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border(
            bottom: BorderSide(
              color: activeLineColor,
              width: 3,
            ),
          ),
        ),
      ),
    );
  }
}
