import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo/utils/constaans.dart';

import '../model/todo_dm.dart';

class ListProvider  extends ChangeNotifier{
  List<TodoDm>todo = [];
  DateTime selectedDay = DateTime.now();

  getTodoFromFireStore() async{
    var TodoCollection =  FirebaseFirestore.instance.collection(TodoDm.collectionName);
    var query = await TodoCollection.get();
    todo = query.docs.map((doc) {
      var map = doc.data();
      return TodoDm(id:map[idKey] ,title:map [titleKey],
          date:DateTime.fromMillisecondsSinceEpoch(map [dateTimeKey]),
          descripsion:map [descripsionKey], isDone:map [isDoneKey]);
    }).toList();
    todo = todo.where((todo){
      return todo.date.year == selectedDay.year && todo.date.month == selectedDay.month
          && todo.date.day ==selectedDay.day ;
    }).toList();
    todo.sort((todo1,todo2){
      return todo1.date.compareTo(todo2.date);
    });
    notifyListeners();
  }

  changeSelected(DateTime newDate){
    selectedDay = newDate;
    getTodoFromFireStore();
  }
  UpdateTodoFirestore(TodoDm todo){
   FirebaseFirestore.instance.collection("todo").doc(todo.id).update(
     {
       'id':todo.id,
       'title':todo.title,
       'descripsion':todo.descripsion,
       'date':todo.date.millisecondsSinceEpoch,
       'isDone': todo.isDone
     }
   ).timeout(Duration(milliseconds: 500),onTimeout: (){
     getTodoFromFireStore();

   });
  }
  UpdateDone(TodoDm todo){
FirebaseFirestore.instance.collection("todo").doc(todo.id).update(
  {
  'isDone': true
  }
).timeout(Duration(milliseconds: 500),onTimeout: (){
  getTodoFromFireStore();
  notifyListeners();
});
  }
}