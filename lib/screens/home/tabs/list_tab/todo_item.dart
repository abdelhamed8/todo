import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo/model/todo_dm.dart';
import 'package:todo/provider/provider.dart';
import 'package:todo/screens/update_screen.dart';
import 'package:todo/utils/my_them_data.dart';

class TodoItem extends StatelessWidget {
  TodoDm todo;
  TodoItem(this.todo);
  late ListProvider provider ;

  @override
  Widget build(BuildContext context){
    provider=Provider.of(context);
    return Slidable(
      startActionPane: ActionPane(
        motion: StretchMotion(),
        children: [
          SlidableAction(onPressed: (_){
            deleteTodo();
          },
          backgroundColor: Colors.red,
            borderRadius: BorderRadius.circular(30),
            icon: Icons.delete,
            foregroundColor: Colors.black,
            spacing: 8,
          )
        ],
      ),
      child: InkWell(
        onTap: (){
          Navigator.pushNamed(context, UpdateScreen.routeName,arguments: todo);
        },
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
          padding: EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),

          child: Row(
            children: [
              Container(
                color: todo.isDone?MyThemData.accentColor:Theme.of(context).primaryColor,
                width: 3,
                height: 70,
                margin: EdgeInsets.all(20),
              ),
              Expanded(
                flex: 6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      todo.title,
                      style:todo.isDone?Theme.of(context).textTheme.headline4!.copyWith(
                     color:Colors.green) : Theme.of(context).textTheme.titleMedium,
                    ),SizedBox(height: 10,),
                    Text(
                      todo.descripsion,
                      style: Theme.of(context).textTheme.titleSmall,textAlign: TextAlign.start,
                    )
                  ],
                ),
              ),
              Spacer(),
              InkWell(
                onTap: (){
                 if(todo.isDone){
                 provider.UpdateDone(todo);
                 }
                },
                child:todo.isDone?Text("Done!"):

                Container(
                  padding: EdgeInsets.symmetric(vertical: 14, horizontal: 16.5),
                  decoration: BoxDecoration(
                    color: MyThemData.primiryColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Image.asset("assets/images/icon_check.png"),
                ),
              ),
              Spacer(
                flex: 1,
              )
            ],
          ),
        ),
      ),
    );
  }

  void deleteTodo() {
  FirebaseFirestore.instance.collection("todo").doc(todo.id).delete().timeout
    (Duration(milliseconds: 500),onTimeout: (){
    provider.getTodoFromFireStore();
  });
  }
}