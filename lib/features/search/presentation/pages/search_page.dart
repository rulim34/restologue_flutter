import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nil/nil.dart';

import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/error_indicator.dart';
import '../../../../core/widgets/loading_indicator.dart';
import '../../../../core/widgets/resto_box.dart';
import '../../../../provider.dart';
import '../../../details/presentation/pages/details_page.dart';
import '../notifiers/notifiers.dart';
import '../widgets/search_bar.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({
    Key? key,
  }) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
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
                title: 'Search',
              ),
            ),
          ];
        },
        body: Column(
          children: <Widget>[
            const SearchBar(),
            Expanded(
              child: Consumer(
                builder: (context, watch, child) {
                  final SearchState state = watch(searchProvider);

                  if (state is SearchInitial) {
                    return ErrorIndicator(
                      message: state.message,
                      image: 'assets/img/search.png',
                    );
                  } else if (state is SearchLoading) {
                    return const LoadingIndicator(
                      count: 5,
                    );
                  } else if (state is SearchLoaded) {
                    if (state.restos.isNotEmpty) {
                      return RefreshIndicator(
                        color: Theme.of(context).accentColor,
                        onRefresh:
                            context.read(searchProvider.notifier).fetchRestos,
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
                    } else {
                      return const ErrorIndicator(
                        message: 'No result.',
                        image: 'assets/img/error.png',
                      );
                    }
                  } else if (state is SearchError) {
                    return ErrorIndicator(
                      message: state.message,
                      image: 'assets/img/error.png',
                      onTryAgain: () {
                        context.read(searchProvider.notifier).fetchRestos();
                      },
                    );
                  } else {
                    return const Nil();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
