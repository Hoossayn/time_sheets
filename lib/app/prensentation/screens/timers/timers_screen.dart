part of '../../presentation.dart';


class TimersScreen extends StatefulWidget {
  const TimersScreen({Key? key}) : super(key: key);

  @override
  State<TimersScreen> createState() => _TimersScreenState();
}

class _TimersScreenState extends BaseStateWrapper<TimersScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _contentWidgets = <Widget>[
    const TimersContent(),
    const ProjectsScreen(),
    const SettingsScreen(),
  ];


  @override
  Widget onBuild(BuildContext context, BoxConstraints constraints) {
    final theme = productConfig.theme;

    return GradientScaffold(
        appBar: _buildAppBar(),
        bottomNavigationBar: Container(
          width: context.getDisplayMaxWidth(),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                theme.getPrimaryTextColor(),
                theme.getPrimaryColor(),
              ],
              stops: const [.15, .85],
            ),
          ),
          child: Theme(
            data: Theme.of(context).copyWith(
              canvasColor: productConfig.theme.getSurfaceColor(),
                  primaryColor: productConfig.theme.getWhiteTextColor()
            ),
            child: BottomNavigationBar(
              selectedFontSize: AppValues.font15,
              unselectedFontSize: AppValues.font10,
              items: const [
                BottomNavigationBarItem(
                  icon:  Icon(CupertinoIcons.clock),
                  activeIcon: Icon(CupertinoIcons.clock_fill),
                  label: 'Timers',
                ),
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.briefcase),
                  activeIcon: Icon(CupertinoIcons.briefcase_fill),
                  label: 'Projects',
                ),
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.settings),
                  activeIcon: Icon(CupertinoIcons.settings_solid),
                  label: 'Settings',
                ),
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: theme.getWhiteTextColor(),
              unselectedItemColor: theme.getWhiteTextColor(),
              onTap: _onItemTapped,
            ),
          ),
        ),
        body: _contentWidgets[_selectedIndex]);
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      toolbarHeight: AppValues.height0,
      backgroundColor: productConfig.theme.getSurfaceVariant(),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        statusBarColor: productConfig.theme.getSurfaceVariant(),
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: productConfig.theme.getSurfaceColor()
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(CupertinoIcons.arrow_up_down),
        ),
        IconButton(
          onPressed: () async {},
          icon: const Icon(CupertinoIcons.add),
        ),
        horizontalSpace(AppValues.space16),
      ],
      centerTitle: false,
    );
  }

  @override
  void onDispose() {}

  @override
  void onHide() {}

  @override
  void onInit() {}

  @override
  void onPause() {}

  @override
  void onResume() {}
}
