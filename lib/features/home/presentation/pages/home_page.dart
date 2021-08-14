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

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      context.read(homeProvider.notifier).getRestos();
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
                title: 'Restologue',
              ),
            ),
          ];
        },
        body: Consumer(
          builder: (context, watch, child) {
            final HomeState state = watch(homeProvider);

            if (state is HomeLoading) {
              return const LoadingIndicator(
                count: 5,
              );
            } else if (state is HomeLoaded) {
              return RefreshIndicator(
                color: Theme.of(context).accentColor,
                onRefresh: context.read(homeProvider.notifier).getRestos,
                child: ListView.builder(
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
                ),
              );
            } else if (state is HomeError) {
              return ErrorIndicator(
                message: state.message,
                image: 'assets/img/error.png',
                onTryAgain: () {
                  context.read(homeProvider.notifier).getRestos();
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
