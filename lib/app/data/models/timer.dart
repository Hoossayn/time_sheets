import 'dart:async';
import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_sheets/app/data/models/form.dart';

import '../../blocs/timer/ticker.dart';
import '../../blocs/timer/timer_bloc.dart';

enum TimerStatus { initial, running, paused, complete }

enum TimerType {
  local,
  odoo,
}

class TimerModel extends Cubit<TimerState> {
  final int id;
  final int projectId;
  final int taskID;
  int totalDuration;
  final TimerType timerType;
  final DateTime startTime;
  final String description;
  bool favorite;
  TimerStatus status;
  StreamSubscription<int>? _tickerSubscription;
  final TimerTicker _ticker = const TimerTicker();

  TimerModel({
    required this.projectId,
    required this.id,
    required this.taskID,
    required this.totalDuration,
    required this.status,
    required this.timerType,
    required this.startTime,
    required this.favorite,
    this.description = '',
  }) : super(TimerInitial(tDuration: totalDuration)) {
    if (status == TimerStatus.initial) resetTimer();
    if (status == TimerStatus.running) startTimer();
  }

  TimerModel copyWith({
    int? projectId,
    int? taskID,
    int? totalDuration,
    TimerStatus? status,
    bool? favorite,
    TimerType? timerType,
  }) {
    return TimerModel(
      id: id,
      projectId: projectId ?? this.projectId,
      taskID: taskID ?? this.taskID,
      totalDuration: totalDuration ?? this.totalDuration,
      status: status ?? this.status,
      timerType: timerType ?? this.timerType,
      favorite: favorite ?? this.favorite,
      startTime: startTime,
      description: description,
    );
  }

  factory TimerModel.fromJson(Map<String, dynamic> json) {
    return TimerModel(
      id: json['id'] ?? 0,
      projectId: json['project_id'] ?? 0,
      taskID: json['task_id'] ?? 0,
      totalDuration: json['total_duration'] ?? 0,
      status: TimerStatus.values[json['status'] ?? 0],
      timerType: TimerType.values[json['timer_type'] ?? 0],
      startTime: DateTime.tryParse(json['start_time']) ?? DateTime.now(),
      favorite: json['favorite'] ?? false,
      description: json['description'] ?? '',
    );
  }


  factory TimerModel.fromTimerForm(TimerForm form,
      {TimerType type = TimerType.local}) {
    return TimerModel(
      id: DateTime.now().millisecondsSinceEpoch,
      projectId: form.projectId.value!.id,
      taskID: form.taskId.value!.id,
      totalDuration: 0,
      status: TimerStatus.initial,
      timerType: type,
      startTime: DateTime.now(),
      favorite: form.favorite.value ?? false,
      description: form.description.value ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'project_id': projectId,
      'task_id': taskID,
      'timer_type': timerType.index,
      'total_duration': totalDuration,
      'status': status.index,
      'favorite': favorite,
    };
  }

  void toggleTimer() {
    if (state is TimerRunInProgress) {
      pauseTimer();
    } else if (state is TimerInitial){
      startTimer();
    }
    else {
      resumeTimer(
        const TimerResumed(),
      );
    }
  }

  void stopTimer() {
    _tickerSubscription?.cancel();
    status = TimerStatus.complete;
    emit(const TimerRunComplete());
  }

  void resetTimer(){
    emit(TimerInitial(tDuration: state.tDuration));
  }

  void startTimer() {
    emit(TimerRunInProgress(tDuration: state.tDuration));
    _tickerSubscription?.cancel();
    _tickerSubscription = _ticker
        .tick(ticks: state.tDuration)
        .listen((duration) => _onTicked(duration));
  }

  void pauseTimer() {
    if (state is TimerRunInProgress) {
      _tickerSubscription?.pause();
      emit(TimerRunPause(tDuration: state.tDuration));
    }
  }

  void resumeTimer(TimerResumed resume) {
    if (state is TimerRunPause) {
      _tickerSubscription?.resume();
      emit(TimerRunInProgress(tDuration: state.tDuration));
    }
  }

  void _onTicked(int duration) {
    totalDuration = duration;
    emit(TimerRunInProgress(tDuration: duration));
  }
}
