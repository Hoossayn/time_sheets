import 'package:equatable/equatable.dart';

import '../../data/models/project.dart';
import '../../data/models/task.dart';
import '../../data/models/timer.dart';

abstract class TimerSheetEvent {}

class TimerSheetEventLoad extends TimerSheetEvent {
  final bool refresh;
  TimerSheetEventLoad({this.refresh = false});
}

class TimerSheetEventAdd extends TimerSheetEvent {
  final TimerModel timer;
  TimerSheetEventAdd(this.timer);
}

enum TimerSheetStatus { loading, loaded, error }

class TimerSheetState extends Equatable {
  final TimerSheetStatus status;
  final List<TimerModel> timers;
  final List<Project> projects;
  final List<Task> tasks;
  const TimerSheetState({
    this.status = TimerSheetStatus.loading,
    this.timers = const [],
    this.projects = const [],
    this.tasks = const [],
  });

  TimerSheetState copyWith({
    TimerSheetStatus? status,
    List<TimerModel>? timers,
    List<Task>? tasks,
    List<Project>? projects,
  }) {
    return TimerSheetState(
      status: status ?? this.status,
      timers: timers ?? this.timers,
      projects: projects ?? this.projects,
      tasks: tasks ?? this.tasks,
    );
  }

  @override
  List<Object?> get props => [status, timers, projects, tasks];
}

class TimerSheetInitial extends TimerSheetState {
  const TimerSheetInitial() : super();
}
