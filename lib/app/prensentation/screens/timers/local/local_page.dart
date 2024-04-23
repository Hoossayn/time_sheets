part of '../../../presentation.dart';

class LocalPage extends BaseTimeSheetWidget {
  LocalPage({super.key});

  @override
  String get emptyTextAction => throw UnimplementedError();

  @override
  String get emptyTextDescription => "Create a timer to to begin tracking time";

  @override
  String get emptyTextTitle => "You don’t have any local timesheets";
}
