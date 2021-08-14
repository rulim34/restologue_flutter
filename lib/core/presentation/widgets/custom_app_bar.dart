import 'package:flutter/material.dart';

import '../../../injection.dart';

class CustomAppBar extends SliverPersistentHeaderDelegate {
  final double collapsedHeight;
  final double expandedHeight;
  final String title;

  CustomAppBar({
    required this.collapsedHeight,
    required this.expandedHeight,
    required this.title,
  });

  @override
  double get minExtent => collapsedHeight;

  @override
  double get maxExtent => expandedHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  Color setBackgroundColor({
    required double shrinkOffset,
  }) {
    final int alpha =
        (shrinkOffset / (maxExtent - minExtent) * 255).clamp(0, 255).toInt();
    return Color.fromARGB(alpha, 150, 187, 124);
  }

  Color setTextColor({
    required double shrinkOffset,
  }) {
    final int value =
        (shrinkOffset / (maxExtent - minExtent) * 255).clamp(0, 255).toInt();
    return Color.fromARGB(255, value, value, value);
  }

  double setTextSize({
    required double shrinkOffset,
    required num fontSize,
  }) {
    final int value =
        (shrinkOffset / (maxExtent - minExtent) * 12).clamp(0, 12).toInt();
    return (fontSize + 12 - value).toDouble();
  }

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox(
      height: maxExtent,
      width: MediaQuery.of(context).size.width,
      child: Container(
        color: setBackgroundColor(
          shrinkOffset: shrinkOffset,
        ),
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Positioned(
              left: 0,
              top: 0,
              child: Container(
                width: 65,
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: TextButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      const CircleBorder(),
                    ),
                    foregroundColor: MaterialStateProperty.all<Color>(
                      setTextColor(
                        shrinkOffset: shrinkOffset,
                      ),
                    ),
                    overlayColor: MaterialStateProperty.all<Color>(
                      Colors.black.withOpacity(0.1),
                    ),
                  ),
                  onPressed: () {
                    getIt<GlobalKey<ScaffoldState>>()
                        .currentState
                        ?.openDrawer();
                  },
                  child: Icon(
                    Icons.menu_rounded,
                    color: setTextColor(
                      shrinkOffset: shrinkOffset,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: collapsedHeight,
              child: Center(
                child: Text(
                  title,
                  style: Theme.of(context).primaryTextTheme.headline1!.copyWith(
                        fontSize: setTextSize(
                          shrinkOffset: shrinkOffset,
                          fontSize: Theme.of(context)
                              .primaryTextTheme
                              .headline1!
                              .fontSize!,
                        ),
                        color: setTextColor(
                          shrinkOffset: shrinkOffset,
                        ),
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
