import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/resto.dart';
import '../../error/exceptions.dart';

abstract class FavouritesLocalDataSource {
  const FavouritesLocalDataSource();

  Future<List<Resto>> getRestos();

  Future<void> createResto({
    required Resto resto,
  });

  Future<void> deleteResto({
    required String id,
  });

  Future<bool> getRestoStatus({
    required String id,
  });
}

@LazySingleton(as: FavouritesLocalDataSource)
class FavouritesLocalDataSourceImpl implements FavouritesLocalDataSource {
  final Box<Resto> _box;

  const FavouritesLocalDataSourceImpl(
    this._box,
  );

  @override
  Future<List<Resto>> getRestos() async {
    try {
      if (_box.values.isNotEmpty) {
        return List.from(_box.values);
      } else {
        return [];
      }
    } catch (error) {
      throw DatabaseException();
    }
  }

  @override
  Future<void> createResto({
    required Resto resto,
  }) async {
    try {
      return _box.put(resto.id, resto);
    } catch (error) {
      throw DatabaseException();
    }
  }

  @override
  Future<void> deleteResto({
    required String id,
  }) async {
    try {
      return _box.delete(id);
    } catch (error) {
      throw DatabaseException();
    }
  }

  @override
  Future<bool> getRestoStatus({
    required String id,
  }) async {
    try {
      return _box.containsKey(id);
    } catch (error) {
      throw DatabaseException();
    }
  }
}
