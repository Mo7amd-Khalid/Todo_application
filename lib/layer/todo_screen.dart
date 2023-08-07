import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_application/layer/cubit/cubit.dart';
import 'package:todo_application/layer/cubit/states.dart';
import 'package:todo_application/shared/component/component.dart';

import '../shared/component/conestense.dart';
import '../shared/style/icon_broken.dart';

class TodoScreen extends StatelessWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = TodoAppCubit.get(context);
    return BlocConsumer<TodoAppCubit, TodoAppStates>(
      listener: (context,state){
        if(state is DeleteDataFromDatabaseSuccessState)
          {
            showToast(context: context, message: "Task deleted successfully", color: defaultColor);
          }
      },
      builder: (context,state) {
      return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Text(
                  "TODO ",
                style: TextStyle(
                  color: defaultColor,
                  fontFamily: "Jannah"
                ),
              ),
              Text(
                  "App",
                style: TextStyle(
                    fontFamily: "Jannah"
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: defaultColor,
          unselectedItemColor: Colors.grey,
          currentIndex: cubit.currentIndex,
          items:
          const [
            BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.done_all_outlined),label: "Done"),
            BottomNavigationBarItem(icon: Icon(Icons.archive_rounded),label: "Archived"),
            BottomNavigationBarItem(icon: Icon(Icons.settings),label: "Settings"),
          ],
          onTap: (int index){
            cubit.bottomSheet(bottomsheetstatus: false, fab: Icon(IconBroken.Edit_Square, color: Colors.white,size: 28,));
            cubit.changeBottomNavBarIndex(index);
          },
        ),
        body: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                        'assets/image/background1.jpg'
                    ),
                    fit: BoxFit.cover,
                    opacity: 0.1
                )
            ),
            child: cubit.screens[cubit.currentIndex]
        ),

      );
    },
    );
  }
}
