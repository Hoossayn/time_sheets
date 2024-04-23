class TimerTicker {
  const TimerTicker();
  Stream<int> tick({required int ticks}) {
    return Stream.periodic(const Duration(seconds: 1), (x) => ticks + x);

  }
}
