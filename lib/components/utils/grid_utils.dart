import 'package:chord_libary/components/constant/const_diman.dart';
import 'package:chord_libary/components/utils/responsive.dart';
import 'package:flutter/material.dart';

class GridUtils {
  static SliverGridDelegate createSliverDelicate(BuildContext context) {
    return SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount:
            (Responsive.currentWidth(context) ~/ ConstantDimens.gridItemWidth)
                .toInt(),
        childAspectRatio: Responsive.isMobile(context)
            ? ConstantDimens.gridItemWidth / ConstantDimens.gridItemWidth
            : ConstantDimens.gridItemWidth / ConstantDimens.gridItemHeight,
        crossAxisSpacing: ConstantDimens.smallPadding,
        mainAxisSpacing: ConstantDimens.pagePadding);
  }

  static SliverGridDelegate createDashboardSliverDelicate(
      BuildContext context) {
    return SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: getDashboardCrossAxisCount(context),
        childAspectRatio: (100 / 140),
        crossAxisSpacing: 16,
        mainAxisSpacing: 16);
  }

  static int getDashboardCrossAxisCount(BuildContext context) {
    return (Responsive.currentWidth(context) ~/
            ConstantDimens.dashboardGridItemWidth)
        .toInt();
  }
}

class MyDelegate extends SliverPersistentHeaderDelegate {
  MyDelegate(this.tabBar);
  final TabBar tabBar;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      child: tabBar,
    );
  }

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
