import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nil/nil.dart';

import '../../../../core/widgets/error_indicator.dart';
import '../../../../provider.dart';
import '../../../details/presentation/pages/details.dart';
import '../notifier/notifier.dart';
import '../widgets/loading_indicator.dart';
import '../widgets/resto_box.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      context.read(homeProvider.notifier).fetchRestos();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, isScrolled) {
            return [
              SliverAppBar(
                pinned: true,
                expandedHeight: 110,
                backgroundColor: Theme.of(context).accentColor,
                flexibleSpace: FlexibleSpaceBar(
                  background: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Theme.of(context).canvasColor,
                    ),
                  ),
                  title: Text(
                    'Restologue',
                    style: Theme.of(context).primaryTextTheme.headline1,
                  ),
                  centerTitle: true,
                  titlePadding: const EdgeInsets.only(bottom: 16),
                ),
              ),
            ];
          },
          body: Consumer(
            builder: (context, watch, child) {
              final HomeState state = watch(homeProvider);

              if (state is HomeLoading) {
                return ListView(
                  children: const <Widget>[
                    LoadingIndicator(
                      count: 5,
                    ),
                  ],
                );
              } else if (state is HomeLoaded) {
                return RefreshIndicator(
                  color: Theme.of(context).accentColor,
                  onRefresh: context.read(homeProvider.notifier).fetchRestos,
                  child: ListView.builder(
                    itemCount: state.restos.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Details(
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
                    context.read(homeProvider.notifier).fetchRestos();
                  },
                );
              } else {
                return const Nil();
              }
            },
          ),
        ),
      ),
    );
  }
}
