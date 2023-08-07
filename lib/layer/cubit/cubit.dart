import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_application/layer/cubit/states.dart';
import 'package:todo_application/modules/archived_tasks/archived_tasks_screen.dart';
import 'package:todo_application/modules/done_task/done_tasks_screen.dart';
import 'package:todo_application/modules/new_tasks/new_tasks_screen.dart';
import 'package:todo_application/modules/settings/settings_screen.dart';

import '../../shared/style/icon_broken.dart';

class TodoAppCubit extends Cubit<TodoAppStates>{
  TodoAppCubit() : super(InitialTodoAppState());

  static TodoAppCubit get(context) => BlocProvider.of(context);

  List<Widget> screens = [
    NewTasksScreen(),
    DoneTasksScreen(),
    ArchivedTasksScreen(),
    SettingsScreen(),
  ];

  int currentIndex = 0;

  void changeBottomNavBarIndex(int index)
  {
    currentIndex = index;
    emit(ChangeBottomNavBarIndexState());
  }

  bool isBottomSheetOpen = false;
  Icon? fabIcon = Icon(IconBroken.Edit_Square, color: Colors.white,size: 28,);

  void bottomSheet({
    required bool bottomsheetstatus,
    required Icon fab
})
  {
    isBottomSheetOpen = bottomsheetstatus;
    fabIcon = fab;
    emit(ChangeBottomSheetState());
  }


  Database? database;
  void createDatabase()
  async {
    database = await openDatabase(
        'todo.db',
      version: 1,
      onCreate: (database, version){
          database.execute('CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, description TEXT, date TEXT, time TEXT, status TEXT)').then((value)
          {
            print("database created successfully");
            emit(CreateDatabaseSuccessState());
          }).catchError((error){
            print(error.toString());
            emit(CreateDatabaseErrorState());
          });
      },
      onOpen: (database){
          print("database opened successfully");

          emit(OpenDatabaseSuccessState());
          getRecords(database);
      }
    );
  }

  void insertToDatabase({
    required String title,
    required String info,
    required String time,
    required String date,
  }){
    database!.transaction((txn) {
      txn.rawInsert('INSERT INTO tasks(title, description, date, time, status) VALUES("$title", "$info", "$date", "$time", "new")').then((value) {
        emit(InsertToDatabaseSuccessState());
        getRecords(database!);
      }).catchError((error){
        print(error.toString());
        emit(InsertToDatabaseErrorState());
      });
      return Future(() => null);
    });
  }


  List<Map> newTasksRecords = [];
  List<Map> doneTasksRecords = [];
  List<Map> archivedTasksRecords = [];

  void getRecords(Database database) {
    newTasksRecords = [];
    doneTasksRecords = [];
    archivedTasksRecords = [];
    database.rawQuery('SELECT * FROM tasks').then((value) {
      value.forEach((element) {
        if(element['status'] == "new")
          {
            newTasksRecords.add(element) ;
          }else if(element['status'] == "done")
            {
              doneTasksRecords.add(element);
            }else
              {
                archivedTasksRecords.add(element);
              }
      });
      emit(GetDataFromDatabaseSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(GetDataFromDatabaseErrorState());
    });
  }
  
  void deleteItem(int id){
    database?.rawDelete('DELETE FROM tasks WHERE id = ?',[id]).then((value)
    {
      getRecords(database!);
      emit(DeleteDataFromDatabaseSuccessState());
    }).catchError((error)
    {
      print(error.toString());
      emit(DeleteDataFromDatabaseErrorState());
    });
  }
  
  void updateItem(int id, String status)
  {
    database?.rawUpdate('UPDATE tasks SET status = ? WHERE id = ?', [status, id]).then((value)
    {
      getRecords(database!);
      emit(UpdateDataInDatabaseSuccessState());
    }).catchError((error){
      print(error.toString());
    });
  }
}