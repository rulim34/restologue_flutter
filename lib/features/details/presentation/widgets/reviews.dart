import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/entities/customer_review.dart';
import '../../../../core/widgets/error_indicator.dart';
import '../../../../provider.dart';
import '../notifiers/notifiers.dart';

class Reviews extends StatefulWidget {
  final List<CustomerReview> initialReviews;

  const Reviews({
    Key? key,
    required this.initialReviews,
  }) : super(key: key);

  @override
  _ReviewsState createState() => _ReviewsState();
}

class _ReviewsState extends State<Reviews> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      context.read(reviewsProvider.notifier).setInitialReviews(
            reviews: widget.initialReviews,
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        final ReviewsState state = watch(reviewsProvider);

        if (state is ReviewsLoading) {
          return SizedBox(
            height: 500,
            child: Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).accentColor,
              ),
            ),
          );
        } else if (state is ReviewsLoaded) {
          if (state.reviews.isNotEmpty) {
            return Container(
              margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: ListView.builder(
                primary: false,
                shrinkWrap: true,
                itemCount: state.reviews.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
                    margin: const EdgeInsets.only(bottom: 8),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardTheme.color,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).cardTheme.shadowColor!,
                          blurRadius: 5,
                        )
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        ListTile(
                          dense: true,
                          contentPadding: const EdgeInsets.all(0),
                          title: Text(
                            state.reviews[index].name,
                            style:
                                Theme.of(context).textTheme.headline4!.copyWith(
                                      height: 1,
                                    ),
                          ),
                          subtitle: Text(
                            state.reviews[index].date,
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      height: 1,
                                    ),
                          ),
                        ),
                        Text(
                          state.reviews[index].review,
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    height: 1,
                                  ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          } else {
            return Container(
              margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
              child: const ErrorIndicator(
                message: 'No review yet. Be the first!',
                image: 'assets/img/error.png',
              ),
            );
          }
        } else if (state is ReviewsError) {
          return Container(
            margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
            child: ErrorIndicator(
              message: state.message,
              image: 'assets/img/error.png',
              onTryAgain: () {
                context.read(reviewsProvider.notifier).sendReview();
              },
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
