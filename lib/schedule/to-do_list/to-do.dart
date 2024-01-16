import '../../sqlite/sqlite.dart';
import '../schedule_list/scheduleDateTime.dart';
import '../../plugins/notification.dart';

class Todo{
  final int id;
  final String title;
  ScheduleDateTime creationDate;
  bool isChecked;


  Todo({
    required this.id,
    required this.title,
    required this.creationDate,
    required this.isChecked,
  });

  static Map<String, Object> toColTitle(){
    var map = <String, Object>{
      'ID' : 0,
      'Title' : "null",
      'CreationDate' : DateTime.now(),
      'IsChecked' : 0,
    };
    return map;
  }

  static Map<String, Object> toMapWithData(String title, ScheduleDateTime creationDate, bool ischecked){
    var map = <String, Object>{
      'Title' : title,
      'CreationDate' : creationDate.toString(),
      'IsChecked' : ischecked ? 1 : 0,
    };
    return map;
  }


  @override
  String toString() {
    return 'Todo(id:$id,title:$id,creationDate:$creationDate,isChecked:$isChecked)';
  }
}

class TodoDatabase extends Sql{
  List<Todo> allTodo = [];
  TodoDatabase() : super(dbname: "todo", currentTable: "todo", params: Todo.toColTitle());

  Future<List<Todo>> selectTodayTodo() async{
    DateTime twentyFourHoursAgo = DateTime.now().subtract(const Duration(hours: 24));
    List<Map> value =  await super.selectW('`CreationDate`>=?', "${twentyFourHoursAgo.year.toString()}-${twentyFourHoursAgo.month.toString().padLeft(2,'0')}-${twentyFourHoursAgo.day.toString().padLeft(2,'0')} ${twentyFourHoursAgo.hour.toString().padLeft(2,'0')}-${twentyFourHoursAgo.minute.toString().padLeft(2,'0')}");
    allTodo.clear();
    if(value != []){
      for (Map element in value) {
        allTodo.add(
            Todo(
                id: int.parse(element['ID'].toString()),
                title: element['Title'].toString(),
                creationDate: ScheduleDateTime.fromString(element['CreationDate'].toString()),
                isChecked: (int.parse(element['IsChecked'].toString())) == 1 ? true : false,
            )
        );
      }
    }
    return allTodo;
  }

  edit(int id, String title, ScheduleDateTime date, bool isChecked) async{
    var temp = Todo.toMapWithData(title, date, isChecked);
    temp['ID'] = id;
    await super.update(temp).then(
            (value) {
          if(value is int){
            allTodo[allTodo.indexWhere((element) => element.id == id + 4000)] = Todo(id: id, title: title, creationDate: date, isChecked: isChecked);
            if(isChecked){
              NotificationPlugin().removeScheduledNotification(id + 4000);
            }else{
              NotificationPlugin().check(id + 4000).then((value){
                if(value == false){
                  NotificationPlugin().scheduleWeekly8And20Notification(id + 4000, title, "", DateTime.now().day, 8, 0);
                }
              });
            }
          }
        });
  }

  add(String title, ScheduleDateTime date, bool isChecked) async{
    await super.insert(Todo.toMapWithData(title, date, isChecked)).then(
            (value) {
          if(value is int){
            allTodo.add(Todo(id: value, title: title, creationDate: date, isChecked: isChecked));
            NotificationPlugin().scheduleWeekly8And20Notification(value + 4000, title, "", DateTime.now().day, 8, 0);
          }
        });
  }

  void remove(Todo todo){
    super.delete(todo.id);
    allTodo.removeWhere((Todo currentItem) => todo == currentItem);
    NotificationPlugin().removeScheduledNotification(todo.id + 4000);
  }


  List<Todo> getAllTodo(){
    return allTodo;
  }
}
