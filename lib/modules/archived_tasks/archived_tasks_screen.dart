import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layer/cubit/cubit.dart';
import '../../layer/cubit/states.dart';
import '../../shared/component/component.dart';

class ArchivedTasksScreen extends StatelessWidget {
  const ArchivedTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoAppCubit, TodoAppStates>(
      listener: (context, state){},
      builder: (context, state){
        var cubit = TodoAppCubit.get(context);
        return ListView.separated(
          itemBuilder: (context, index) =>  ItemBuilder(cubit.archivedTasksRecords[index], context),
          separatorBuilder: (context, index) =>  myDivider(),
          itemCount: cubit.archivedTasksRecords.length,
          physics: BouncingScrollPhysics(),
        );
      },
    );
  }
}
