import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nil/nil.dart';

import '../../../../core/config/config.dart';
import '../../../../core/domain/entities/resto.dart';
import '../../../../core/presentation/widgets/error_indicator.dart';
import '../../../../provider.dart';
import '../notifiers/notifiers.dart';
import '../widgets/review_form.dart';
import '../widgets/reviews.dart';

class DetailsPage extends StatefulWidget {
  final Resto resto;

  const DetailsPage({
    required this.resto,
    Key? key,
  }) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      context.read(detailsProvider.notifier).getDetails(
            id: widget.resto.id,
          );
      context.read(bookmarkProvider.notifier).getRestoStatus(
            id: widget.resto.id,
          );
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
                expandedHeight: 250,
                backgroundColor: Colors.transparent,
                elevation: 0,
                automaticallyImplyLeading: false,
                leading: Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                  child: TextButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        const CircleBorder(),
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(
                        Theme.of(context).accentColor,
                      ),
                      foregroundColor: MaterialStateProperty.all<Color>(
                        Colors.white,
                      ),
                      overlayColor: MaterialStateProperty.all<Color>(
                        Colors.black.withOpacity(0.1),
                      ),
                    ),
                    onPressed: Navigator.of(context).pop,
                    child: const Icon(
                      Icons.arrow_back_rounded,
                      color: Colors.white,
                    ),
                  ),
                ),
                actions: <Widget>[
                  Consumer(
                    builder: (context, watch, child) {
                      final bool state = watch(bookmarkProvider);

                      return Container(
                        width: 56,
                        padding: const EdgeInsets.fromLTRB(0, 10, 10, 0),
                        child: TextButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                              const CircleBorder(),
                            ),
                            backgroundColor: MaterialStateProperty.all<Color>(
                              Theme.of(context).accentColor,
                            ),
                            foregroundColor: MaterialStateProperty.all<Color>(
                              Colors.white,
                            ),
                            overlayColor: MaterialStateProperty.all<Color>(
                              Colors.black.withOpacity(0.1),
                            ),
                          ),
                          onPressed: () {
                            if (state) {
                              context
                                  .read(bookmarkProvider.notifier)
                                  .deleteResto(
                                    id: widget.resto.id,
                                  );
                            } else {
                              context
                                  .read(bookmarkProvider.notifier)
                                  .createResto(
                                    resto: widget.resto,
                                  );
                            }
                            context
                                .read(favouritesProvider.notifier)
                                .getRestos();
                          },
                          child: Icon(
                            state
                                ? Icons.bookmark_rounded
                                : Icons.bookmark_border_rounded,
                            color: Colors.white,
                          ),
                        ),
                      );
                    },
                  ),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  background: Hero(
                    tag: '${widget.resto.id}-hero',
                    child: CachedNetworkImage(
                      imageUrl:
                          'https://$apiUrl/images/medium/${widget.resto.pictureId}',
                      placeholder: (context, url) => Image.asset(
                        'assets/img/placeholder.png',
                        fit: BoxFit.cover,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ];
          },
          body: Consumer(
            builder: (context, watch, child) {
              final DetailsState state = watch(detailsProvider);

              if (state is DetailsLoading) {
                return Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).accentColor,
                  ),
                );
              } else if (state is DetailsLoaded) {
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.fromLTRB(16, 12, 16, 6),
                        child: Text(
                          state.resto.name,
                          style:
                              Theme.of(context).textTheme.headline1!.copyWith(
                                    fontSize: 25,
                                  ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                        child: Row(
                          children: <Widget>[
                            const Icon(
                              Icons.place_rounded,
                              color: Color(0xFF3B82F6),
                              size: 20,
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 8),
                              child: Text(
                                '${state.resto.address}, ${state.resto.city}',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5!
                                    .copyWith(
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                        child: RatingBarIndicator(
                          rating: double.parse(state.resto.rating),
                          itemBuilder: (context, index) => const Icon(
                            Icons.star,
                            color: Color(0xFFFFC107),
                          ),
                          itemSize: 25,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(16, 0, 16, 4),
                        child: Text(
                          'Description',
                          style: Theme.of(context).textTheme.headline1,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                        child: Text(
                          state.resto.description,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(16, 0, 16, 4),
                        child: Text(
                          'Menu',
                          style: Theme.of(context).textTheme.headline1,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(24, 0, 16, 4),
                        child: Text(
                          'Foods',
                          style: Theme.of(context).textTheme.headline2,
                        ),
                      ),
                      Container(
                        height: 50,
                        margin: const EdgeInsets.fromLTRB(24, 0, 16, 4),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: state.resto.menus.foods.length,
                          itemBuilder: (context, index) {
                            return Container(
                              padding: const EdgeInsets.all(16),
                              margin: const EdgeInsets.only(right: 8),
                              decoration: BoxDecoration(
                                color: Theme.of(context).cardTheme.color,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Theme.of(context)
                                        .cardTheme
                                        .shadowColor!,
                                    blurRadius: 5,
                                  )
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  state.resto.menus.foods[index].name,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                        height: 1,
                                      ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(24, 0, 16, 4),
                        child: Text(
                          'Drinks',
                          style: Theme.of(context).textTheme.headline3,
                        ),
                      ),
                      Container(
                        height: 50,
                        margin: const EdgeInsets.fromLTRB(24, 0, 16, 24),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: state.resto.menus.drinks.length,
                          itemBuilder: (context, index) {
                            return Container(
                              padding: const EdgeInsets.all(16),
                              margin: const EdgeInsets.only(right: 8),
                              decoration: BoxDecoration(
                                color: Theme.of(context).cardTheme.color,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Theme.of(context)
                                        .cardTheme
                                        .shadowColor!,
                                    blurRadius: 5,
                                  )
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  state.resto.menus.drinks[index].name,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                        height: 1,
                                      ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(16, 0, 16, 4),
                        child: Text(
                          'Reviews',
                          style: Theme.of(context).textTheme.headline1,
                        ),
                      ),
                      ReviewForm(
                        id: state.resto.id,
                      ),
                      Reviews(
                        initialReviews: state.resto.customerReviews,
                      )
                    ],
                  ),
                );
              } else if (state is DetailsError) {
                return ErrorIndicator(
                  message: state.message,
                  image: 'assets/img/error.png',
                  onTryAgain: () {
                    context
                        .read(detailsProvider.notifier)
                        .getDetails(id: widget.resto.id);
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
