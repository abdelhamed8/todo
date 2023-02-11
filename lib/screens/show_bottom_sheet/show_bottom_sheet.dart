import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/model/todo_dm.dart';
import 'package:todo/provider/provider.dart';
import 'package:todo/utils/constaans.dart';

class AddBottomSheet extends StatefulWidget {
  @override
  State<AddBottomSheet> createState() => _AddBottomSheetState();
}

class _AddBottomSheetState extends State<AddBottomSheet> {
  GlobalKey<FormState> myKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  String title="";
  String description ="";
  late ListProvider listProvider;
  @override
  Widget build(BuildContext context) {
    listProvider = Provider.of(context);
    return  Container(
      padding: EdgeInsets.all(12),
      child: SingleChildScrollView(
        child: Form(
          key: myKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 14),
              Text(
                "Add New Task",
                textAlign: TextAlign.center,
                style: Theme
                    .of(context)
                    .textTheme
                    .titleMedium,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Title",
                ),
                validator: (text) {
                  if (text == null || text
                      .trim()
                      .isEmpty) {
                    return "please enter title";
                  }
                },
                onChanged: (text){
                  title = text;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Description"),
                validator: (text) {
                  if (text == null || text
                      .trim()
                      .isEmpty) {
                    return "please enter title";
                  }
                },
                onChanged: (text){
                  description = text;
                },
                minLines: 3,
                maxLines: 4,
              ),
              SizedBox(height: 25),
              InkWell(
                child: Text(
                  "Select Date",
                  textAlign: TextAlign.start,
                  style: Theme
                      .of(context)
                      .textTheme
                      .titleMedium,
                ),
                onTap: () {
                  return showMyDatePicker();
                },
              ),
              Text(
                "${selectedDate.year}/${selectedDate.month}/${selectedDate
                    .day}",
                textAlign: TextAlign.center,
                style: Theme
                    .of(context)
                    .textTheme
                    .titleSmall,
              ),
              Container(
                margin: EdgeInsets.all(12),
                child: ElevatedButton(
                    onPressed: () {
                      myKey.currentState!.validate();
                      addOnClick();
                    },
                    child: Text("add",
                        textAlign: TextAlign.start,
                        style: Theme
                            .of(context)
                            .textTheme
                            .titleMedium)),
              ),
            ],
          ),
        ),
      ),
    );
  }
  void showMyDatePicker() async {
    selectedDate = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365))) ??
        DateTime.now();
  }

  void addOnClick() {

   if( !myKey.currentState!.validate())
   return;
   var todoCollection = FirebaseFirestore.instance.collection(TodoDm.collectionName);
   var emptyDoc = todoCollection.doc();
   emptyDoc.set({
     idKey:emptyDoc.id,
   titleKey: title ,
     descripsionKey:description,
     dateTimeKey:selectedDate.millisecondsSinceEpoch,
     isDoneKey : false ,
   }).timeout(Duration(milliseconds: 500),onTimeout: (){
     listProvider.getTodoFromFireStore();
     Navigator.pop(context);
   });
  }
}
