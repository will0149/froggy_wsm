import 'package:cct_management/device/utils/logger_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../generated/l10n.dart';

/**
 * Made for cct_management.
 * By User: josedominguez
 * Date: 05/18/25
 */
class HorizontalFilterList extends ConsumerStatefulWidget {
  final List<String> filterListItems;
  final Color activeColor;
  final Color inactiveColor;
  final bool bottomLine;
  final bool shrinkWrap;
  final double itemLeftPadding;
  final double itemRightPadding;
  final double itemTopPadding;
  final double itemBottomPadding;
  final Function(String) onTextChange;

  const HorizontalFilterList(
      {super.key,
        required this.filterListItems,
        required this.activeColor,
        required this.inactiveColor,
        required this.onTextChange,
        this.bottomLine = true,
        this.shrinkWrap = false,
        this.itemLeftPadding = 10,
        this.itemRightPadding = 10,
        this.itemTopPadding = 0,
        this.itemBottomPadding= 10});

  @override
  HorizontalFilterListState createState() => HorizontalFilterListState();
}

class HorizontalFilterListState extends ConsumerState<HorizontalFilterList> {
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.red,
      alignment: Alignment.topCenter,
      height: 75,
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: widget.itemLeftPadding,
              right: widget.itemRightPadding,
            ),
            child: Text(S.of(context).searchFilterTitle, style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.bold),),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: horizontalCategoryListView(widget.filterListItems),
          ),
        ],
      )
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
              widget.onTextChange(item);
              // logger.w("selected index $selectedIndex");
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
    // final isDarkTheme = ref.watch(appThemeProvider);
    // var inactiveThemeColor = isDarkTheme ? parkeaWhite : widget.inactiveColor;
    var activeTextColor = active ? widget.activeColor : Colors.black54;
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
                .titleMedium
                ?.copyWith(color: activeTextColor),
          ),
        ),
      ),
    );
  }
}
