import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

class TasbihState {
  final int count;
  final int target;
  const TasbihState({required this.count, required this.target});
}

class TasbihNotifier extends StateNotifier<TasbihState> {
  final Box _box;
  TasbihNotifier(this._box)
      : super(TasbihState(
    count: _box.get('count', defaultValue: 0) as int,
    target: _box.get('target', defaultValue: 33) as int,
  ));

  void increment() {
    final newCount = state.count + 1;
    _box.put('count', newCount);
    state = TasbihState(count: newCount, target: state.target);
  }

  void reset() {
    _box.put('count', 0);
    state = TasbihState(count: 0, target: state.target);
  }

  void setTarget(int t) {
    _box.put('target', t);
    state = TasbihState(count: state.count, target: t);
  }
}

final tasbihProvider =
StateNotifierProvider<TasbihNotifier, TasbihState>((ref) {
  return TasbihNotifier(Hive.box('tasbih'));
});