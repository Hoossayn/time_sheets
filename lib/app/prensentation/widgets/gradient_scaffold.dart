part of '../presentation.dart';


class GradientScaffold extends StatelessWidget {
  const GradientScaffold(
      {super.key,
        required this.body,
        this.appBar,
        this.bottomNavigationBar,
        this.floatingActionButton,
        this.floatingActionButtonLocation
      });

  final Widget body;
  final PreferredSizeWidget? appBar;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;

  @override
  Widget build(BuildContext context) {
    final theme = FlavourConfig.instance.config.theme;
    final surface = theme.getSurfaceColor();
    final surfaceVariant = theme.getSurfaceVariant();

    return ScaffoldGradientBackground(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [surfaceVariant, surface],
        stops: const [.2, .85],
      ),
      appBar: appBar,
      bottomNavigationBar: bottomNavigationBar,
      body: body,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
    );
  }
}
