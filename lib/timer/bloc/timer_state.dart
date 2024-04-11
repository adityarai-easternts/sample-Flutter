part of 'timer_bloc.dart';

sealed class TimerState extends Equatable {
  const TimerState(this.duration);
  final int duration;

  @override
  List<Object> get props => [duration];
}

final class TimerInitial extends TimerState {
  const TimerInitial(super.duration);

  @override
  String toString() => 'TimerInitial { duration: $duration }';
}

final class TimerRunPause extends TimerState {
  const TimerRunPause(super.duration);

  @override
  String toString() {
    return 'TimerRunPause {duration : $duration }';
  }
}

final class TimerRunInProgess extends TimerState {
  const TimerRunInProgess(super.duration);

  @override
  String toString() {
    return 'TimerRunInProgess {duration : $duration }';
  }
}

final class TimerRunComplete extends TimerState {
  const TimerRunComplete() : super(0);
}
