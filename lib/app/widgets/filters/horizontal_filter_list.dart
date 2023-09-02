import 'package:flutter/material.dart';
import 'package:parkea/device/utils/loggerConfig.dart';

class HorizontalFilterList extends StatefulWidget {
  final List<String> filterListItems;
  final Color activeColor;
  final Color inactiveColor;
  final bool bottomLine;
  final bool shrinkWrap;
  final double itemLeftPadding;
  final double itemRightPadding;
  final double itemTopPadding;
  final double itemBottomPadding;

  const HorizontalFilterList(
      {Key? key,
      required this.filterListItems,
      required this.activeColor,
      required this.inactiveColor,
      this.bottomLine = true,
      this.shrinkWrap = false,
      this.itemLeftPadding = 10,
      this.itemRightPadding = 10,
      this.itemTopPadding = 0,
      this.itemBottomPadding= 10})
      : super(key: key);

  @override
  HorizontalFilterListState createState() => HorizontalFilterListState();
}

class HorizontalFilterListState extends State<HorizontalFilterList> {
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
      shrinkWrap: widget.shrinkWrap,
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
    var activeTextColor = active ? widget.activeColor : widget.inactiveColor;
    var activeLineColor = active ? widget.activeColor : Colors.transparent;
    return Padding(
      padding: EdgeInsets.only(
        left: widget.itemLeftPadding,
        right: widget.itemRightPadding,
        top: widget.itemTopPadding,
        bottom: widget.itemBottomPadding,
      ),
      child: Container(
        decoration: widget.bottomLine
            ? BoxDecoration(
                color: Colors.transparent,
                border: Border(
                  bottom: BorderSide(
                    color: activeLineColor,
                    width: 3,
                  ),
                ),
              )
            : null,
        child: Center(
          child: Text(
            title,
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(color: activeTextColor),
          ),
        ),
      ),
    );
  }
}
