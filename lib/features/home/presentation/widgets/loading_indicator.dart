import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingIndicator extends StatelessWidget {
  final int count;

  const LoadingIndicator({
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(count, (index) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
          child: Shimmer.fromColors(
            baseColor: Theme.of(context).cardTheme.color!,
            highlightColor: Theme.of(context).highlightColor,
            period: const Duration(milliseconds: 700),
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                minHeight: 155,
                maxHeight: 155,
              ),
              child: Stack(
                children: <Widget>[
                  Container(
                    alignment: Alignment.bottomRight,
                    margin: const EdgeInsets.fromLTRB(15, 20, 0, 10),
                    child: const SizedBox.expand(
                      child: Card(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    child: const SizedBox(
                      height: 125,
                      width: 125,
                      child: Card(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
