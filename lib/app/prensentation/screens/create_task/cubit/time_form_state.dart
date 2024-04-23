part of 'time_form_cubit.dart';

sealed class TimeFormState extends Equatable {
  const TimeFormState();

  @override
  List<Object> get props => [];
}

final class TimeFormInitial extends TimeFormState {}

final class TimeFormValidating extends TimeFormState {}

final class TimeFormValidationFailed extends TimeFormState {}

final class TimerFormSaved extends TimeFormState {
  final TimerModel timer;
  const TimerFormSaved({required this.timer});
}
