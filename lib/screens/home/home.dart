import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/provider/provider.dart';
import 'package:todo/screens/home/tabs/list_tab/listTab.dart';
import 'package:todo/screens/home/tabs/setting.dart';
import 'package:todo/screens/show_bottom_sheet/show_bottom_sheet.dart';

class Home extends StatefulWidget {
  static String routeName = "Home Screen";

  @override
  State<Home> createState() => _HomeState();
}
class _HomeState extends State<Home> {
  List <Widget> tabs = [ListTab(),SittingTab()];

  int currentIndex = 0 ;
   late  ListProvider provider;
  @override
  Widget build(BuildContext context) {
   provider = Provider.of(context);
    return Scaffold(
      appBar: AppBar(

        title:
        Text("To Do List",textAlign: TextAlign.end ,),
        toolbarHeight: MediaQuery
            .of(context)
            .size
            .height * .1,
      ),

      floatingActionButton: FloatingActionButton(
        shape: StadiumBorder(
            side: BorderSide(color: Colors.white70, width: 3)
        ),
        onPressed: () {
          showAddBottomSheet();
        },
        backgroundColor: Theme
            .of(context)
            .primaryColor,
        child: Icon(Icons.add, color: Colors.black,),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 12,
        elevation: 0,
        clipBehavior: Clip.hardEdge
        ,
        child: BottomNavigationBar(
          onTap: (index) {
            currentIndex = index;
            setState(() {});
          },
          items: [
            BottomNavigationBarItem(
                icon: ImageIcon(AssetImage("assets/images/icon_list.png")),
                label: "menu"),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: "settings")
          ],
        ),
      ),
      body: tabs[currentIndex],
    );
  }
    void showAddBottomSheet() {
      showModalBottomSheet(context:context, builder:(_){
        return AddBottomSheet();
      } );
  }
}