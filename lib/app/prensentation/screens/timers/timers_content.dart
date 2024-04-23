part of '../../presentation.dart';


class TimersContent extends StatefulWidget {
  const TimersContent({Key? key}) : super(key: key);

  @override
  State<TimersContent> createState() => _TimersContentState();
}

class _TimersContentState extends BaseStateWrapper<TimersContent> {

  @override
  Widget onBuild(BuildContext context, BoxConstraints constraints) {
    return DefaultTabController(
      length: 3,
      child:  GradientScaffold(
        appBar: _buildAppBar(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.0),
            ),
            child: TabBarView(
              children: [
                FavouritesPage(),
                Text('data'),
                LocalPage(),
              ],
            ) ,
          ),
        ),
      ),
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


  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Text('Timesheets', style: productConfig.theme.title1.copyWith(fontSize: 32),),
      scrolledUnderElevation: 0,
      backgroundColor: productConfig.theme.getSurfaceVariant(),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        statusBarColor: productConfig.theme.getSurfaceVariant(),
        statusBarIconBrightness: Brightness.light,
      ),
      actions: [
        IconButton(
          style: ButtonStyle(),

          onPressed: () {},
          icon: const Icon(CupertinoIcons.arrow_up_down),
        ),
        IconButton(
          onPressed: () async {

            Navigator.of(context).push(
              CreateNewTaskScreen.route(
                timesheetBloc: context.read<TimesheetBloc>(),
              ),
            );

          },
          icon: const Icon(CupertinoIcons.add),
        ),
        horizontalSpace(AppValues.space16)
      ],
      bottom: const TabBar(
        indicatorColor: Colors.white,
        unselectedLabelColor: Colors.white,
        indicatorPadding: EdgeInsets.symmetric(horizontal: 16),
        tabs: [
          Tab(text: 'Favorites'),
          Tab(text: 'Odoo'),
          Tab(text: 'Local'),
        ],

      ),
      centerTitle: false,

    );
  }
}
