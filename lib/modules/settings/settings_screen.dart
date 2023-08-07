import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_application/layer/cubit/cubit.dart';
import 'package:todo_application/layer/cubit/states.dart';
import 'package:todo_application/shared/component/component.dart';
import 'package:todo_application/shared/component/conestense.dart';

class SettingsScreen extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoAppCubit, TodoAppStates >(
      listener: (context, state){},
      builder: (context, state){

        var cubit = TodoAppCubit.get(context);
        List<Widget> rightSide =
        [
          Text(
            'The number of new tasks',
            style: TextStyle(
                fontFamily: "Jannah",
                fontSize: 20
            ),
          ),
          Text(
            'The number of done tasks',
            style: TextStyle(
                fontFamily: "Jannah",
                fontSize: 20
            ),
          ),
          Text(
            'The number of archived tasks',
            style: TextStyle(
                fontFamily: "Jannah",
                fontSize: 20
            ),
          ),
        ];

        List<Widget> leftSide =
        [
          Text(
            '${cubit.newTasksRecords.length}',
            style: TextStyle(
                fontFamily: "Jannah",
                fontSize: 24,
                color: defaultColor
            ),
          ),
          Text(
            '${cubit.doneTasksRecords.length}',
            style: TextStyle(
                fontFamily: "Jannah",
                fontSize: 24,
                color: defaultColor
            ),
          ),
          Text(
            '${cubit.archivedTasksRecords.length}',
            style: TextStyle(
                fontFamily: "Jannah",
                fontSize: 24,
                color: defaultColor
            ),
          ),
        ];

        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView.separated(
              itemBuilder: (context, index) => SettingItem(rightSide: rightSide[index], leftSide: leftSide[index]),
              separatorBuilder: (context, index) => SizedBox(height: 20,),
              itemCount: rightSide.length),
        );
      },
    );
  }
}
