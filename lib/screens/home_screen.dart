import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:techrtwo/boxes.dart';
import 'package:techrtwo/model/todo_model.dart';
import 'package:techrtwo/screens/edit_tasks.dart';
import 'package:techrtwo/screens/task_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:techrtwo/widgets/cards.dart';
import 'package:techrtwo/widgets/no_task_found.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<ToDo> ongoingTasks;
  late List<ToDo> completedTasks;
  @override
  void initState() {
    ongoingTasks = Boxes.getTasks()
        .values
        .where((tasks) => tasks.status == "open")
        .toList();
    completedTasks = Boxes.getTasks()
        .values
        .where((tasks) => tasks.status == "close")
        .toList();
    super.initState();
  }

  void deleteTasks(ToDo task) {
    task.delete();
  }

  void updateStatus(
    ToDo tasks,
  ) {
    tasks.status = 'close';
    tasks.save();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text(
            'MY TODO',
            style: TextStyle(
                color: Colors.greenAccent,
                fontWeight: FontWeight.bold,
                fontSize: 16),
          ),
          elevation: 0,
          bottom: TabBar(
              unselectedLabelColor: Colors.greenAccent,
              indicatorSize: TabBarIndicatorSize.tab,
              indicator: BoxDecoration(
                  gradient: const LinearGradient(
                      colors: [Colors.greenAccent, Colors.yellowAccent]),
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.greenAccent),
              tabs: const [
                Tab(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text("ToDo"),
                  ),
                ),
                Tab(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text("Completed"),
                  ),
                ),
              ]),
        ),
        body: ValueListenableBuilder<Box<ToDo>>(
          valueListenable: Boxes.getTasks().listenable(),
          builder: (context, box, _) {
            ongoingTasks = Boxes.getTasks()
                .values
                .where((tasks) => tasks.status == "open")
                .toList();
            completedTasks = Boxes.getTasks()
                .values
                .where((tasks) => tasks.status == "close")
                .toList();

            print('Ongoing' + ongoingTasks.length.toString());
            print('Complete' + completedTasks.length.toString());
            return TabBarView(children: [
              ongoingTasks.isEmpty
                  ? const NoTasksFound()
                  : ListView.builder(
                      itemCount: ongoingTasks.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              top: 20, left: 10, right: 10),
                          child: Dismissible(
                            background: slideRightBackground(),
                            secondaryBackground: slideLeftBackground(),
                            key: UniqueKey(),
                            onDismissed: (DismissDirection direction) {
                              if (direction == DismissDirection.startToEnd) {
                                setState(() {
                                  updateStatus(ongoingTasks[index]);
                                });
                              } else if (direction ==
                                  DismissDirection.endToStart) {
                                setState(() {
                                  deleteTasks(ongoingTasks[index]);
                                });
                              }
                            },
                            child: GestureDetector(
                              onLongPress: () {
                                Navigator.push(
                                    context,
                                    SlideRightRoute(
                                      page: EditTasks(
                                        taskName: ongoingTasks[index].task,
                                        tass: ongoingTasks[index],
                                      ),
                                    ));
                              },
                              child: CustomCards(
                                priority: ongoingTasks[index].priority,
                                date: ongoingTasks[index].date,
                                taskName: ongoingTasks[index].task,
                              ),
                            ),
                          ),
                        );
                      }),
              completedTasks.isEmpty
                  ? const NoTasksFound()
                  : ListView.builder(
                      itemCount: completedTasks.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              top: 20, left: 10, right: 10),
                          child: Dismissible(
                            key: UniqueKey(),
                            onDismissed: (DismissDirection direction) {
                              setState(() {
                                deleteTasks(completedTasks[index]);
                              });
                            },
                            background: slideLeftBackground(),
                            direction: DismissDirection.endToStart,
                            child: CustomCards(
                              priority: completedTasks[index].priority,
                              date: completedTasks[index].date,
                              taskName: completedTasks[index].task,
                            ),
                          ),
                        );
                      }),
            ]);
          },
        ),
        floatingActionButton: SizedBox(
          height: 50.0,
          width: 50.0,
          child: FittedBox(
            child: FloatingActionButton(
                child: const Icon(Icons.add),
                backgroundColor: Colors.greenAccent,
                onPressed: () {
                  Navigator.push(
                      context,
                      SlideRightRoute(
                        page: const TaskAdd(),
                      ));
                }),
          ),
        ),
      ),
    );
  }
}

Widget slideRightBackground() {
  return Container(
    color: Colors.green,
    child: Align(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const SizedBox(
            width: 20,
          ),
          const Icon(
            Icons.check,
            color: Colors.white,
          ),
          Text(
            " Completed",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.left,
          ),
        ],
      ),
      alignment: Alignment.centerLeft,
    ),
  );
}

Widget slideLeftBackground() {
  return Container(
    color: Colors.red,
    child: Align(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Icon(
            Icons.delete,
            color: Colors.white,
          ),
          Text(
            " Delete",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.right,
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
      alignment: Alignment.centerRight,
    ),
  );
}
class SlideRightRoute extends PageRouteBuilder {
  final Widget page;
  SlideRightRoute({required this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
}
