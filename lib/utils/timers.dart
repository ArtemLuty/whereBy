import 'dart:async';

class CountdownSecondsTimer {
  Timer? timer;
  int timeout;
  int? seconds;
  void Function(int?)? _listener;

  CountdownSecondsTimer(
    this.timeout, {

    /// assigns seconds value immediately after timer creation
    bool initializeInstantly = false,
  }) {
    if (initializeInstantly) seconds = timeout;
  }

  int _now() {
    return DateTime.now().millisecondsSinceEpoch ~/ 1000;
  }

  // ignore: use_setters_to_change_properties
  void addListener(
    void Function(int? seconds) listener,
  ) {
    _listener = listener;
  }

  void removeListener() {
    _listener = null;
  }

  void start() {
    final startTime = _now();
    final stopTime = startTime + timeout;

    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      final nowTime = _now();
      seconds = stopTime - nowTime;

      if (nowTime >= stopTime) {
        timer?.cancel();
        seconds = null;
      }

      _listener?.call(seconds);
    });
  }

  void stop() {
    timer?.cancel();
  }
}
