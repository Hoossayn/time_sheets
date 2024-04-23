import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:time_sheets/app/prensentation/presentation.dart';
import 'package:time_sheets/app/prensentation/screens/taskDetails/task_detail.dart';
import 'package:time_sheets/app/prensentation/screens/taskDetails/task_timers.dart';

import '../../../data/models/task.dart';

class TaskDetailsScreen extends StatefulWidget {
  final Task task;
  const TaskDetailsScreen({super.key, required this.task});

  static Route route({required Task task}) {
    return MaterialPageRoute(
      builder: (context) => TaskDetailsScreen(task: task),
    );
  }

  @override
  State<TaskDetailsScreen> createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> with TickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    tabController = TabController(
      length: 2,
      vsync: this,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(128),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: AppBar(
            automaticallyImplyLeading: true,
            leading: InkWell(
              onTap: () => Navigator.of(context).pop(),
              child: const Icon(
                CupertinoIcons.chevron_left,
                size: 24,
              ),
            ),
            centerTitle: true,
            title: Text(
              widget.task.name,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontWeight: FontWeight.w600, letterSpacing: 0.15),
            ),
            actions: const [
              SizedBox(
                width: 48,
                height: 48,
                child: Icon(
                  CupertinoIcons.pencil,
                  size: 24,
                ),
              )
            ],
            bottom: TabBar(
              controller: tabController,
              tabs: const [
                Tab(
                  child: Text("Timesheets"),
                ),
                Tab(
                  child: Text("Details"),
                ),
              ],
            ),
          ),
        ),
      ),
      body: TabBarView(controller: tabController, children: [
        TaskTimers(task: widget.task),
        TaskDetail(task: widget.task)
      ]),
    );
  }
}

