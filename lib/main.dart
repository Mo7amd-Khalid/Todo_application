import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_application/layer/cubit/cubit.dart';
import 'package:todo_application/shared/bloc_observer.dart';
import 'package:todo_application/shared/component/conestense.dart';
import 'package:todo_application/shared/cubit/cubit.dart';
import 'package:todo_application/shared/cubit/states.dart';
import 'package:todo_application/shared/network/local/cache_helper.dart';

import 'layer/todo_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (BuildContext context) => AppCubit(),
          ),
          BlocProvider(
            create: (BuildContext context) => TodoAppCubit()..createDatabase(),
          ),
        ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state){},
        builder: (context, state){

          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'TODO App',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: defaultColor),
              useMaterial3: true,
            ),
            themeMode: ThemeMode.light,
            home: TodoScreen(),
          );
        },

      )
    );
  }
}
