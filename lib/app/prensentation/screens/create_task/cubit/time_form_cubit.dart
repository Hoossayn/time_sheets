import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/models/form.dart';
import '../../../../data/models/project.dart';
import '../../../../data/models/task.dart';
import '../../../../data/models/timer.dart';
part 'time_form_state.dart';

class TimeFormCubit extends Cubit<TimeFormState> {
  TimeFormCubit() : super(TimeFormInitial());
  TimerForm form = const TimerForm(
    projectId: CustomFormField<Project>(),
    taskId: CustomFormField<Task>(),
    description: CustomFormField<String>(),
    favorite: CustomFormField(),
  );

  onSave() {
    if (_validateForm()) {
      final timer = TimerModel.fromTimerForm(form);
      emit(TimerFormSaved(timer: timer));
    } else {
      emit(TimeFormValidationFailed());
    }
  }

  bool _validateForm() {
    var valid = true;
    if (form.projectId.value == null) {
      form = form.copyWith(
          projectId: const CustomFormField<Project>(
              isValid: false, error: "Please select a project"));
      valid = false;
    }
    if (form.taskId.value == null) {
      form = form.copyWith(
          taskId: const CustomFormField(
              isValid: false, error: "Please select a task"));
      valid = false;
    }
    return valid;
  }

  onProjectChanged(CustomFormField<Project> value) {
    form = form.copyWith(projectId: value);
  }

  onTaskChanged(CustomFormField<Task> value) {
    form = form.copyWith(taskId: value);
  }

  onDescriptionChanged(CustomFormField<String> value) {
    form = form.copyWith(description: value);
  }

  onFavoriteChanged(CustomFormField<bool> value) {
    form = form.copyWith(favorite: value);
  }
}
