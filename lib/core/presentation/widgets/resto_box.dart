import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../config/config.dart';
import '../../domain/entities/resto.dart';

class RestoBox extends StatelessWidget {
  final Resto resto;

  const RestoBox({
    required this.resto,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          minHeight: 155,
          maxHeight: 155,
        ),
        child: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).cardTheme.shadowColor!,
                    blurRadius: 5,
                    spreadRadius: -5,
                  )
                ],
              ),
              alignment: Alignment.bottomRight,
              margin: const EdgeInsets.fromLTRB(15, 20, 0, 10),
              child: Card(
                color: Theme.of(context).cardTheme.color,
                elevation: 0,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(117, 14, 14, 14),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          resto.name.length > 25
                              ? '${resto.name.substring(0, 25)}...'
                              : resto.name,
                          style: Theme.of(context).primaryTextTheme.subtitle1,
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          const Icon(
                            Icons.place_rounded,
                            color: Color(0xFF3B82F6),
                            size: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Text(
                              resto.city,
                              style:
                                  Theme.of(context).primaryTextTheme.bodyText2,
                            ),
                          )
                        ],
                      ),
                      RatingBarIndicator(
                        rating: double.parse(resto.rating),
                        itemBuilder: (context, index) => const Icon(
                          Icons.star,
                          color: Color(0xFFFFC107),
                        ),
                        itemSize: 20,
                      )
                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 5),
              child: SizedBox(
                height: 125,
                width: 125,
                child: Container(
                  decoration: BoxDecoration(
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
                  child: Card(
                    color: Theme.of(context).cardTheme.color,
                    elevation: 0,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: Hero(
                      tag: '${resto.id}-hero',
                      child: ClipRRect(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                          child: CachedNetworkImage(
                            imageUrl:
                                'https://$apiUrl/images/medium/${resto.pictureId}',
                            placeholder: (context, url) => Image.asset(
                              'assets/img/placeholder.png',
                              fit: BoxFit.cover,
                            ),
                            fit: BoxFit.cover,
                          )),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
