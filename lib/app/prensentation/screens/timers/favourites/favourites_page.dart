
import '../base_sheets.dart';

class FavouritesPage extends BaseTimeSheetWidget {
  FavouritesPage({super.key});

  @override
  String get emptyTextDescription =>
      "You can mark a timer as favorite either on the timer creation page or within an existing timer";

  @override
  String get emptyTextTitle => "No favorited timers yet";

  @override
  bool get isFavoritesSheet => true;
}
