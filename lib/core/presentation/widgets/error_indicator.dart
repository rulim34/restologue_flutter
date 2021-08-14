import 'package:flutter/material.dart';

class ErrorIndicator extends StatelessWidget {
  final VoidCallback? onTryAgain;
  final String? message;
  final String? image;

  const ErrorIndicator({
    this.onTryAgain,
    this.message,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        primary: false,
        padding: const EdgeInsets.all(10),
        shrinkWrap: true,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                image ?? 'assets/img/error.png',
                width: 250,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                message ?? 'Error occured.',
                textAlign: TextAlign.center,
                style: Theme.of(context).primaryTextTheme.headline6,
              ),
              // ignore: prefer_if_elements_to_conditional_expressions
              if (onTryAgain != null)
                TextButton.icon(
                  icon: Icon(
                    Icons.refresh,
                    color: Theme.of(context).primaryColor,
                  ),
                  label: Text(
                    'Try Again',
                    style:
                        Theme.of(context).primaryTextTheme.headline5!.copyWith(
                              fontSize: 14,
                            ),
                  ),
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                    overlayColor: MaterialStateProperty.all(
                      Theme.of(context).cardTheme.shadowColor,
                    ),
                  ),
                  onPressed: onTryAgain,
                ),
            ],
          ),
        ],
      ),
    );
  }
}
