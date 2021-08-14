import 'dart:convert';

import 'package:restologue/core/data/models/resto_model.dart';
import 'package:restologue/core/domain/entities/resto.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../fixtures/fixture_reader.dart';

void main() {
  const tRestoModel = RestoModel(
    id: 'rqdv5juczeskfw1e867',
    name: 'Melting Pot',
    description:
        'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet.',
    pictureId: '14',
    city: 'Medan',
    rating: '4.2',
  );

  test(
    'should be a subclass of Resto entity',
    () async {
      // assert
      expect(tRestoModel, isA<Resto>());
    },
  );

  group('fromJson', () {
    test(
      'should return a valid model',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap =
            jsonDecode(fixture('resto.json')) as Map<String, dynamic>;
        // act
        final result = RestoModel.fromJson(jsonMap);
        // assert
        expect(result, tRestoModel);
      },
    );
  });
}
