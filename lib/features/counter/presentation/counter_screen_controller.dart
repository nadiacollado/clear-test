import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../data/counter_repository.dart';
import '../domain/counter.dart';

part 'counter_screen_controller.g.dart';

@riverpod
class CounterScreenController extends _$CounterScreenController {
  @override
  FutureOr<Counter> build() {
    final repository = ref.read(counterRepositoryProvider);
    return repository.counter;
  }

  Future<void> increment() async {
    final repository = ref.read(counterRepositoryProvider);

    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      final updatedCounter = await repository.increment();
      return updatedCounter;
    });
  }

  Future<void> decrement() async {
    final repository = ref.read(counterRepositoryProvider);

    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      final updatedCounter = await repository.decrement();
      return updatedCounter;
    });
  }
}
