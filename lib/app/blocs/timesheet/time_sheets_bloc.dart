import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_sheets/app/blocs/timesheet/time_sheets_state.dart';

import '../../data/models/project.dart';
import '../../data/models/task.dart';
import '../../data/models/timer.dart';
import '../../data/repo/projects_repo.dart';
import '../../data/repo/tasks_repo.dart';
import '../../data/repo/timer_repo.dart';

class TimesheetBloc extends Bloc<TimerSheetEvent, TimerSheetState> {
  TimesheetBloc() : super(const TimerSheetInitial()) {
    on<TimerSheetEventLoad>((event, emit) async {
      if (state.timers.isEmpty || event.refresh) {
        await init(emit);
      }
    });
    on<TimerSheetEventAdd>((event, emit) {
      emit(state.copyWith(timers: [...state.timers, event.timer]));
    });
  }
  final TimerRepo timerRepo = TimerRepo();
  final TasksRepo tasksRepo = TasksRepo();
  final ProjectsRepo projectsRepo = ProjectsRepo();

  init(Emitter<TimerSheetState> emit) async {
    try {
      emit(state.copyWith(status: TimerSheetStatus.loading));
      final timers = await fetchTimers();
      final tasks = await fetchTasks();
      final projects = await fetchProjects();
      emit(state.copyWith(
        status: TimerSheetStatus.loaded,
        timers: timers,
        tasks: tasks,
        projects: projects,
      ));
    } catch (e) {
      emit(state.copyWith(status: TimerSheetStatus.error));
    }
  }

  Project getTimerProject(TimerModel timer) {
    return state.projects
        .firstWhere((project) => project.id == timer.projectId);
  }

  Project getTaskProject(Task task) {
    return state.projects.firstWhere((project) => project.id == task.projectId);
  }

  Task getTimerTask(TimerModel timer) {
    return state.tasks.firstWhere((task) => task.id == timer.taskID);
  }

  List<TimerModel> getTimersByTask(int taskId) {
    return state.timers.where((timer) => timer.taskID == taskId).toList();
  }

  Future<List<TimerModel>> fetchTimers() async {
    final timerSeed = await rootBundle.loadString('assets/seeds/timer.json');
    return timerRepo.getTimers(jsonDecode(timerSeed));
  }

  Future<List<Task>> fetchTasks() async {
    final taskSeed = await rootBundle.loadString('assets/seeds/task.json');
    return tasksRepo.getTasks(jsonDecode(taskSeed));
  }

  Future<List<Project>> fetchProjects() async {
    final projectSeed =
        await rootBundle.loadString('assets/seeds/projects.json');
    return projectsRepo.getProjects(jsonDecode(projectSeed));
  }
}
