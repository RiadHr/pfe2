import 'package:flutter/material.dart';

import '../../constants/global_variables.dart';


class IconContainer extends StatelessWidget {
  const IconContainer({
    required int this.pageNumber,
    required IconData this.iconD,
    required int page,
    required this.bottomBarWidth,
  }) : _page = page;

  final int _page;
  final double bottomBarWidth;
  final IconData iconD;
  final int pageNumber;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:  EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      // margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: _page == pageNumber? GlobalVariables.secondaryColor
            : GlobalVariables.fourthColor,
      ),
      // alignment: Alignment.center,
      width: bottomBarWidth,
      child: Icon(
        iconD,
        color: _page == pageNumber? GlobalVariables.fourthColor :Colors.black,
      ),
    );
  }
}