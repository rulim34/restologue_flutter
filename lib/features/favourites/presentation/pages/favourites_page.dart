import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nil/nil.dart';

import '../../../../core/presentation/widgets/custom_app_bar.dart';
import '../../../../core/presentation/widgets/error_indicator.dart';
import '../../../../core/presentation/widgets/loading_indicator.dart';
import '../../../../core/presentation/widgets/resto_box.dart';
import '../../../../provider.dart';
import '../../../details/presentation/pages/details_page.dart';
import '../notifiers/notifiers.dart';

class FavouritesPage extends StatefulWidget {
  const FavouritesPage({
    Key? key,
  }) : super(key: key);

  @override
  _FavouritesPageState createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      context.read(favouritesProvider.notifier).getRestos();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, isScrolled) {
          return [
            SliverPersistentHeader(
              pinned: true,
              delegate: CustomAppBar(
                collapsedHeight: 65,
                expandedHeight: 120,
                title: 'Favourites',
              ),
            ),
          ];
        },
        body: Consumer(
          builder: (context, watch, child) {
            final FavouritesState state = watch(favouritesProvider);

            if (state is FavouritesLoading) {
              return const LoadingIndicator(
                count: 5,
              );
            } else if (state is FavouritesLoaded) {
              if (state.restos.isNotEmpty) {
                return ListView.builder(
                  itemCount: state.restos.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailsPage(
                              resto: state.restos[index],
                            ),
                          ),
                        );
                      },
                      child: RestoBox(
                        resto: state.restos[index],
                      ),
                    );
                  },
                );
              } else {
                return const ErrorIndicator(
                  message: 'No favourite restaurant.',
                  image: 'assets/img/error.png',
                );
              }
            } else if (state is FavouritesError) {
              return ErrorIndicator(
                message: state.message,
                image: 'assets/img/error.png',
                onTryAgain: () {
                  context.read(favouritesProvider.notifier).getRestos();
                },
              );
            } else {
              return const Nil();
            }
          },
        ),
      ),
    );
  }
}
