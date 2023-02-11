class TodoDm {
  static String collectionName = "todo";
  String? id;
  String title ;
  DateTime date ;
  String descripsion ;
  bool isDone ;

  TodoDm({this.id,required this.title,required this.date,required this.descripsion,required this.isDone});
}