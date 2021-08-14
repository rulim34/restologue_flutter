import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../features/drawer/presentation/widgets/drawer.dart';
import '../../../../features/favourites/presentation/pages/favourites_page.dart';
import '../../../../features/home/presentation/pages/home_page.dart';
import '../../../../features/search/presentation/pages/search_page.dart';
import '../../../../injection.dart';
import '../../../../provider.dart';

class NavBar extends StatelessWidget {
  final List<Widget> _pages = [
    const HomePage(),
    const SearchPage(),
    const FavouritesPage(),
  ];

  NavBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        final int state = watch(navBarProvider);

        return SafeArea(
          child: Scaffold(
            key: getIt<GlobalKey<ScaffoldState>>(),
            drawer: const DrawerMenu(),
            extendBody: true,
            body: GestureDetector(
              onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
              child: _pages.elementAt(state),
            ),
            bottomNavigationBar: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).cardTheme.shadowColor!,
                    blurRadius: 5,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                child: BottomNavigationBar(
                  elevation: 0,
                  backgroundColor: Theme.of(context)
                      .bottomNavigationBarTheme
                      .backgroundColor,
                  selectedItemColor: Theme.of(context)
                      .bottomNavigationBarTheme
                      .selectedItemColor,
                  unselectedItemColor: Theme.of(context)
                      .bottomNavigationBarTheme
                      .unselectedItemColor,
                  showSelectedLabels: false,
                  showUnselectedLabels: false,
                  items: const <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home_rounded),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.search_rounded),
                      label: 'Search',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.bookmark_rounded),
                      label: 'Bookmark',
                    ),
                  ],
                  currentIndex: state,
                  onTap: context.read(navBarProvider.notifier).setState,
                  type: BottomNavigationBarType.fixed,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
