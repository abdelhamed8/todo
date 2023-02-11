import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/model/todo_dm.dart';
import 'package:todo/provider/provider.dart';
import 'package:todo/screens/home/tabs/list_tab/todo_item.dart';
import 'package:todo/utils/constaans.dart';
import 'package:todo/utils/my_them_data.dart';

class ListTab extends StatefulWidget {
  @override
  State<ListTab> createState() => _ListTabState();
}

class _ListTabState extends State<ListTab> {
  late ListProvider listProvider;
  @override
  Widget build(BuildContext context) {
    listProvider = Provider.of(context);
    if (listProvider.todo.isEmpty) listProvider.getTodoFromFireStore();

    return Container(
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: Stack(
              children: [
                Column(
                  children: [
                    Expanded(
                      flex: 20,
                      child: Container(
                        color:Colors.white70,
                      ),
                    ),
                    Expanded(
                      flex: 80,
                      child: Container(
                        color: Colors.blue[200],
                      ),
                    ),
                  ],
                ),
                CalendarTimeline(
                  initialDate: listProvider.selectedDay,
                  firstDate:
                      listProvider.selectedDay.subtract(Duration(days: 365)),
                  lastDate: listProvider.selectedDay.add(Duration(days: 365)),
                  onDateSelected: (date) {
                    listProvider.changeSelected(date);
                  },
                  leftMargin: 10,
                  monthColor: MyThemData.accentColor,
                  dayColor: MyThemData.accentColor,
                  activeDayColor: Colors.blue[900],
                  activeBackgroundDayColor: MyThemData.accentColorDark,
                  dotsColor: Color(0xFF333A47),
                  //selectableDayPredicate: (date) => date.day != 23,
                  locale: 'en_ISO',
                ),
              ],
            ),
          ),
          Expanded(
              flex: 8,
              child: ListView.builder(
                  itemCount: listProvider.todo.length,
                  itemBuilder: (_, index) {
                    return TodoItem(listProvider.todo[index]);
                  }))
        ],
      ),
    );
  }
}
