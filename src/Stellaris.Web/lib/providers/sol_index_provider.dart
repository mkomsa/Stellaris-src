import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectedSolIndexNotifier extends StateNotifier<int> {
  SelectedSolIndexNotifier() : super(0);

  void setIndex(int index) {
    state = index;
  }
}

final selectedSolIndexProvider =
    StateNotifierProvider<SelectedSolIndexNotifier, int>(
        (ref) => SelectedSolIndexNotifier());
