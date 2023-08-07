import 'package:analog_clock/analog_clock.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_application/layer/cubit/cubit.dart';
import 'package:todo_application/layer/cubit/states.dart';
import 'package:todo_application/shared/component/component.dart';
import 'package:todo_application/shared/style/icon_broken.dart';

import '../../shared/component/conestense.dart';

class NewTasksScreen extends StatelessWidget {

  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var infoController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();

  NewTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoAppCubit, TodoAppStates>(
      listener: (context, state){
        if(state is InsertToDatabaseSuccessState)
          {
            showToast(context: context, message: "Task added successfully", color: defaultColor);
            titleController.text = "";
            timeController.text = "";
            infoController.text = "";
            dateController.text = "";
          }
      },
      builder: (context, state){
        var cubit = TodoAppCubit.get(context);
        return Scaffold(
          key: scaffoldKey,
          body: Container(
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/image/background1.jpg'
                ),
                fit: BoxFit.cover,
                opacity: 0.1
              )
            ),
            child: ListView.separated(
                itemBuilder: (context, index) =>  ItemBuilder(cubit.newTasksRecords[index], context),
                separatorBuilder: (context, index) =>  myDivider(),
                itemCount: cubit.newTasksRecords.length,
              physics: BouncingScrollPhysics(),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: (){
              if(cubit.isBottomSheetOpen)
                {
                  if(formKey.currentState!.validate())
                    {
                      cubit.insertToDatabase(
                        title: titleController.text,
                        date: dateController.text,
                        info: infoController.text,
                        time: timeController.text.split(" ")[0],
                      );
                      Navigator.pop(context);
                      cubit.bottomSheet(bottomsheetstatus: false, fab: Icon(IconBroken.Edit_Square, color: Colors.white,size: 32,));
                    }
                  }
              else
                {
                  scaffoldKey.currentState!.showBottomSheet((context) => Container(
                    color: Colors.white,
                    child: Form(
                      key: formKey,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children:
                          [
                            TextFormField(
                              controller: titleController,
                              keyboardType: TextInputType.text,
                              validator: (String? value)
                              {
                                if(value!.isEmpty)
                                {
                                  return 'Please enter the title';
                                }
                                return null;
                              },
                              cursorColor: defaultColor,
                              decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.title,color:defaultColor,),
                                  label: Text('Title of the task',style: TextStyle(color: Colors.grey),),
                                  border: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: defaultColor
                                      )
                                  )
                              ),
                            ),
                            SizedBox(height: 10,),
                            TextFormField(
                              controller: infoController,
                              keyboardType: TextInputType.text,
                              cursorColor: defaultColor,
                              decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.info_outline,color:defaultColor,),
                                  label: Text('Description',style: TextStyle(color: Colors.grey),),
                                  border: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: defaultColor
                                    ),
                                  )
                              ),
                            ),
                            SizedBox(height: 10,),
                            TextFormField(
                              controller: timeController,
                              readOnly: true,
                              onTap: (){
                                showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                ).then((value) {
                                  timeController.text= value!.format(context).toString();
                                });
                              },
                              validator: (String? value)
                              {
                                if(value!.isEmpty)
                                {
                                  return 'Please enter the time';
                                }
                                return null;
                              },
                              cursorColor: defaultColor,
                              decoration: InputDecoration(
                                  prefixIcon: Icon(IconBroken.Time_Circle,color:defaultColor,),
                                  label: Text('Time of the task',style: TextStyle(color: Colors.grey),),
                                  border: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: defaultColor
                                      )
                                  )
                              ),
                            ),
                            SizedBox(height: 10,),
                            TextFormField(
                              controller: dateController,
                              readOnly: true,
                              onTap: (){
                                showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime.parse("2050-12-30"),

                                ).then((value)
                                {
                                  dateController.text = DateFormat('MMM dd,yyyy').format(value!);
                                });
                              },
                              keyboardType: TextInputType.text,
                              validator: (String? value)
                              {
                                if(value!.isEmpty)
                                {
                                  return 'Please enter the date';
                                }
                                return null;
                              },
                              cursorColor: defaultColor,
                              decoration: InputDecoration(
                                  prefixIcon: Icon(IconBroken.Calendar,color:defaultColor,),
                                  label: Text('Date of the task',style: TextStyle(color: Colors.grey),),
                                  border: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: defaultColor
                                      )
                                  )
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )).closed.then((value)
                  {
                    cubit.bottomSheet(bottomsheetstatus: false, fab: Icon(IconBroken.Edit_Square, color: Colors.white,size: 28,));
                  });
                  cubit.bottomSheet(bottomsheetstatus: true, fab: Icon(IconBroken.Plus, color: Colors.white,size: 32,));
                }

            },
            child: cubit.fabIcon,
            backgroundColor: defaultColor,
            tooltip: "Add New Task",
          ),
        );
      },
    );
  }
}
