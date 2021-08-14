import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../provider.dart';

class DrawerMenu extends StatefulWidget {
  const DrawerMenu({
    Key? key,
  }) : super(key: key);

  @override
  _DrawerMenuState createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      context
          .read(recommendationNotificationProvider.notifier)
          .getRecomendationNotificationStatus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          Container(
            color: Theme.of(context).accentColor,
            child: Column(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(top: 40),
                  child: Image.asset(
                    'assets/icons/icon.png',
                    width: 80,
                    height: 80,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: Text(
                    'Restologue',
                    style:
                        Theme.of(context).primaryTextTheme.headline1!.copyWith(
                              color: Colors.white,
                              fontSize: 35,
                            ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10, bottom: 20),
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Text(
                    'Restaurant catalogue just for you!',
                    style:
                        Theme.of(context).primaryTextTheme.headline3!.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                            ),
                  ),
                )
              ],
            ),
          ),
          if (Platform.isAndroid)
            ListTile(
              title: Text(
                'Random Resto Recommendation',
                style: Theme.of(context).primaryTextTheme.headline4!.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
              trailing: Consumer(
                builder: (context, watch, child) {
                  final bool status = watch(recommendationNotificationProvider);

                  return Switch.adaptive(
                    value: status,
                    onChanged: (value) {
                      context
                          .read(recommendationNotificationProvider.notifier)
                          .setRecomendationNotificationStatus(status: value);
                    },
                  );
                },
              ),
            ),
          if (!Platform.isAndroid)
            ListTile(
              title: Text(
                'Random Resto Recommendation is not available!',
                style: Theme.of(context).primaryTextTheme.headline4!.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
            )
        ],
      ),
    );
  }
}
