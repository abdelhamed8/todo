import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/model/todo_dm.dart';
import 'package:todo/provider/provider.dart';
import 'package:todo/screens/show_bottom_sheet/update_filed.dart';

class UpdateScreen extends StatefulWidget {
  static String routeName = "update";

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  late TextEditingController tileController;

  late TextEditingController descControler;
  var formKey = GlobalKey<FormState>();
  late ListProvider provider ;
  @override
  Widget build(BuildContext context) {
    provider =Provider.of(context);
    TodoDm todo = ModalRoute.of(context)!.settings.arguments as TodoDm;
    double hight = MediaQuery.of(context).size.height;
    double wight = MediaQuery.of(context).size.width;
    tileController = TextEditingController(text: todo.title);
    descControler = TextEditingController(text: todo.descripsion);
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  AppBar(
                    title: Text("ToDo List"),
                    flexibleSpace: SizedBox(
                      height: hight * .2,
                    ),
                  ),
                  Container(
                    padding: EdgeInsetsDirectional.all(20),
                    margin: EdgeInsets.symmetric(
                        vertical: hight * 0.13, horizontal: wight * 0.06),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Form(
                       key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Edit Task",
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          SizedBox(
                            height: hight * 0.02,
                          ),
                          UpDateFiled(tileController, "title", TextInputType.text,(value){
                            todo.title=value;
                          },(value){
                            if (value!.isEmpty){
                              return "Title is not be empty";
                            }
                            return null;
                          },),
                          SizedBox(
                            height: hight * 0.02,
                          ),
                          UpDateFiled(descControler, "description",
                              TextInputType.multiline,(value){
                                todo.descripsion=value;
                              },(value){
                                if (value!.isEmpty){
                                  return "Description is not be empty";
                                }
                                return null;
                              }),
                          SizedBox(
                            height: hight * 0.05,
                          ),
                          Align(
                              alignment: AlignmentDirectional.centerStart,
                              child: Text("Select Date",
                                  style: Theme.of(context).textTheme.bodyMedium)),
                          SizedBox(
                            height: hight * 0.02,
                          ),
                          InkWell(
                            onTap: () {
                              showPicer(todo);
                            },
                            child: Text(
                              "${todo.date.day}-${todo.date.month}-${todo.date.year}",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(color: Colors.black54),
                            ),
                          ),
                          SizedBox(
                            height: hight * 0.2,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()){
                              provider.UpdateTodoFirestore(todo);
                              }
                            },
                            child: Text("Save Changes"),
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadiusDirectional.circular(20)),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showPicer(TodoDm todo) {
    showDatePicker(
            context: context,
            initialDate: todo.date,
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(Duration(days: 365)))
        .then((value) {
      todo.date = value ?? todo.date;
      setState(() {});
    });
  }
}
