enum CountDownStatus {
  notStarted,
  running,
  paused,
  finised,
}

class CountDownState {
  final CountDownStatus status;
  final int currentTime;

  CountDownState({required this.status, required this.currentTime});

  CountDownState copyWith({CountDownStatus? status, int? currentTime}) {
    return CountDownState(
        status: status ?? this.status,
        currentTime: currentTime ?? this.currentTime);
  }
}
