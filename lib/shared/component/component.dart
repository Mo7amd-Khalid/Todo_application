import 'dart:io';

import 'package:analog_clock/analog_clock.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:todo_application/layer/cubit/cubit.dart';
import 'package:todo_application/shared/component/conestense.dart';

import '../style/icon_broken.dart';

Widget myDivider() => Container(
  width: double.infinity,
  height: 1.0,
  color: Colors.grey[300],
);

Widget myDivider2() => Container(
  width: 1.0,
  height: 40,
  color: Colors.grey[300],
);

void navigateTo(context, widget) => Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
);

void navigateAndFinish(context, widget) => Navigator.pushReplacement(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
);

void showToast({
  required BuildContext context,
  required String message,
  Color color = Colors.black87,
})
{
  ToastContext().init(context);
  Toast.show(
    message,
    duration: Toast.lengthLong,
    gravity: Toast.bottom,
    backgroundColor: color,
    textStyle: TextStyle(
      color: Colors.white
    ),
  );
}



Widget ItemBuilder(Map tasks, context) => Dismissible(
  key: Key(tasks['id'].toString()),
  direction: DismissDirection.startToEnd,
  child: Padding(
    padding: const EdgeInsets.all(10.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
      [
        AnalogClock(
          decoration: BoxDecoration(
              border: Border.all(width: 3.0, color: Colors.black),
              color: Colors.black,
              shape: BoxShape.circle), // d
          height: 100,// ecoration
          width: 100.0,
          isLive: false,
          hourHandColor: defaultColor,
          minuteHandColor: Colors.white,
          showSecondHand: false,
          numberColor: Colors.white,
          showNumbers: true,
          textScaleFactor: 2,
          showTicks: true,
          showAllNumbers: true,
          datetime: DateTime(0, 0, 0, int.parse(tasks['time'].split(':')[0]), int.parse(tasks['time'].split(':')[1]).toInt(), 7),
        ),
        SizedBox(
          width: 15,
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children:
          [
            Text(
              "${tasks['title']}",
              style: TextStyle(
                  fontSize: 24,
                  fontFamily: "Jannah"
              ),
            ),
            Text(
              "${tasks['description']}",
              style: TextStyle(
                  fontSize: 18,
                  fontFamily: "Jannah",
                  color: Colors.grey
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "${tasks['date']}",
              style: TextStyle(
                  fontSize: 14,
                  fontFamily: "Jannah",
                  color: Colors.grey
              ),
            ),
          ],
        ),
        Spacer(),
        if(tasks['status'] != 'done')
          IconButton(
            onPressed: (){
              TodoAppCubit.get(context).updateItem(tasks['id'], "done");
            },
            icon: Icon(Icons.check_circle, color: defaultColor,)),
        if(tasks['status'] != 'archived')
          IconButton(
            onPressed: (){
              TodoAppCubit.get(context).updateItem(tasks['id'], 'archived');
            },
            icon: Icon(Icons.archive_rounded, color: Colors.grey,)),
      ],
    ),
  ),
  onDismissed: (direction){
    TodoAppCubit.get(context).deleteItem(tasks['id']);
  },
);

Widget SettingItem({
  Widget? rightSide,
  Widget? leftSide,
}) => Column(
  children:
  [
    Container(
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
            color: Colors.grey
        ),
        color: Colors.grey[200],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children:
          [
            rightSide!,
            Spacer(),
            leftSide!,
          ],
        ),
      ),
    ),
  ],
);
