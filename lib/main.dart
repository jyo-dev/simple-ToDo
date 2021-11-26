import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:techrtwo/model/todo_model.dart';
import 'package:techrtwo/screens/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(ToDoAdapter());
  await Hive.openBox<ToDo>('tasks');
  runApp(
    const MyApp()
    // MultiProvider(
    //   providers: [ChangeNotifierProvider.value(value: dataProvider())],
    //   child: MyApp(),
    // ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: () => MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          textTheme: TextTheme(
              //To support the following, you need to use the first initialization method
              button: TextStyle(fontSize: 15.sp)),
          primarySwatch: Colors.green,
        ),
        routes: {
          // When navigating to the "/" route, build the FirstScreen widget.
          '/': (context) => const HomeScreen(),
          // When navigating to the "/second" route, build the SecondScreen widget.
        },
      ),
    );
  }
}
