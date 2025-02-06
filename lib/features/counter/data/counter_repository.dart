import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_starter_kit/features/counter/domain/counter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'counter_repository.g.dart';

class CounterRepository {
  Counter _counter = Counter(value: 0);

  Counter get counter => _counter;

  Future<Counter> increment() async {
    return _counter = Counter(value: _counter.value + 1);
  }

  Future<Counter> decrement() async {
    return _counter = Counter(value: _counter.value - 1);
  }
}

@Riverpod(keepAlive: true)
CounterRepository counterRepository(Ref ref) {
  return CounterRepository();
}
