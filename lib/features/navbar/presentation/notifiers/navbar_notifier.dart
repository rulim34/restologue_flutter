import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';

@injectable
class NavBarNotifier extends StateNotifier<int> {
  NavBarNotifier() : super(0);

  // ignore: use_setters_to_change_properties
  void setState(int index) {
    state = index;
  }
}
