import '../models/timer.dart';

class TimerRepo {
  TimerModel createTimer(Map<String, dynamic> json) {
    return TimerModel.fromJson(json);
  }

  TimerModel editTimer(TimerModel timer, Map<String, dynamic> json) {
    return timer.copyWith(
      projectId: json['project_id'],
      taskID: json['task_id'],
      totalDuration: json['total_duration'],
      status: TimerStatus.values[json['status']],
      favorite: json['favorite'],
    );
  }

  List<TimerModel> getTimers(List<dynamic> json) {
    return json.map((timer) => TimerModel.fromJson(timer)).toList();
  }
}
