import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/domain/entities/resto.dart';
import '../../domain/usecases/create_resto.dart';
import '../../domain/usecases/delete_resto.dart';
import '../../domain/usecases/get_resto_status.dart';

@injectable
class BookmarkNotifier extends StateNotifier<bool> {
  final CreateResto _createResto;
  final DeleteResto _deleteResto;
  final GetRestoStatus _getRestoStatus;

  BookmarkNotifier(
    this._createResto,
    this._deleteResto,
    this._getRestoStatus,
  ) : super(false);

  Future<void> createResto({
    required Resto resto,
  }) async {
    final failureOrSuccess = await _createResto(
      resto: resto,
    );

    failureOrSuccess.fold(
      (failure) {
        state = false;
      },
      (success) {
        state = true;
      },
    );
  }

  Future<void> deleteResto({
    required String id,
  }) async {
    final failureOrSuccess = await _deleteResto(
      id: id,
    );

    failureOrSuccess.fold(
      (failure) {
        state = true;
      },
      (success) {
        state = false;
      },
    );
  }

  Future<void> getRestoStatus({
    required String id,
  }) async {
    final failureOrStatus = await _getRestoStatus(
      id: id,
    );

    failureOrStatus.fold(
      (failure) {
        state = false;
      },
      (status) {
        state = status;
      },
    );
  }
}
