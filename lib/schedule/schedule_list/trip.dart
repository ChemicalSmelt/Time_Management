import 'package:flutter/material.dart';
import 'scheduleDateTime.dart';
import '../../sqlite/sqlite.dart';
import '../../plugins/notification.dart';

// stores ExpansionPanel state information
class Trip {
  final int id;
  Trip({
    required this.id,
    required this.expandedValue,
    required this.headerValue,
    required this.date,
    this.isExpanded = false,
  });
  String expandedValue;
  String headerValue;
  ScheduleDateTime date;
  bool isExpanded;

  static Map<String, Object> toColTitle(){
    var map = <String, Object>{
      'ID' : 0,
      'Title' : "null",
      'Content' : "null",
      'DateTime' : DateTime.now(),
    };
    return map;
  }

  static Map<String, Object> toMapWithData(String title, String content, ScheduleDateTime date){
    var map = <String, Object>{
      'Title' : title,
      'Content' : content,
      'DateTime' : date.toString(),
    };
    return map;
  }
}

class TripDatabase extends Sql{
  List<Trip> allTrip = [];
  TripDatabase() : super(dbname: "trip", currentTable: "trip", params: Trip.toColTitle()){
    //NotificationPlugin().init();
  }
  void init() async {

  }

  selectLaterTrips() async{
    DateTime now = DateTime.now();
    List<Map> value =  await super.selectW('`DateTime`>=?', "${now.year.toString()}-${now.month.toString().padLeft(2,'0')}-${now.day.toString().padLeft(2,'0')} ${now.hour.toString().padLeft(2,'0')}-${now.minute.toString().padLeft(2,'0')}");
    if(value != []){
      for (Map element in value) {
        allTrip.add(
            Trip(
                id: int.parse(element['ID'].toString()),
                headerValue: element['Title'].toString(),
                expandedValue: element['Content'].toString(),
                date: ScheduleDateTime.fromString(element['DateTime'].toString())
            )
        );
      }
      sort();
    }
    return allTrip;
  }


  selectAllToTrip() async{
    List<Map> value =  await super.selectAll();
    if(value != []){
      for (Map element in value) {
        allTrip.add(
            Trip(
                id: int.parse(element['ID'].toString()),
                headerValue: element['Title'].toString(),
                expandedValue: element['Content'].toString(),
                date: ScheduleDateTime.fromString(element['DateTime'].toString())
            )
        );
      }
      sort();
    }
    return allTrip;
  }

  edit(int id, String title, String content, ScheduleDateTime date) async{
    var temp = Trip.toMapWithData(title, content, date);
    temp['ID'] = id;
    await super.update(temp).then(
            (value) {
          if(value is int){
            allTrip[allTrip.indexWhere((element) => element.id == id)] = Trip(id: id, headerValue: title, expandedValue: content, date: date);
            //allTrip.add(Trip(id: value, headerValue: title, expandedValue: content, date: date));
            sort();
          }
        });
  }

  add(String title, String content, ScheduleDateTime date) async{
    await super.insert(Trip.toMapWithData(title, content, date)).then(
            (value) {
              if(value is int){
                allTrip.add(Trip(id: value, headerValue: title, expandedValue: content, date: date));
                sort();
                //註冊提醒事件
                NotificationPlugin().showScheduledNotification(
                  id: value,
                  title: title,
                  body: content,
                  scheduledDate: date.getDateTime(),
                );
              }
            });
  }

  void remove(Trip trip){
    super.delete(trip.id);
    allTrip.removeWhere((Trip currentItem) => trip == currentItem);
    NotificationPlugin().removeScheduledNotification(trip.id);
  }

  void sort(){
    allTrip.sort(
            (a, b){
          var aDate = a.date.getDateTime();
          var bDate = b.date.getDateTime();
          return aDate.compareTo(bDate);
        }
    );
  }
  List<Trip> getAllTrip(){
    return allTrip;
  }

  List<Trip> getSelectDayTrip(DateTime selectDate){
    List<Trip> selectTrip = [];
    for(Trip trip in allTrip){
      if(isSelectedDay(selectDate, trip.date.getDateTime())){
        selectTrip.add(trip);
      }
    }
    return selectTrip;
  }

  bool isSelectedDay(DateTime selectDate, DateTime targetDate){
    return selectDate.year == targetDate.year &&
        selectDate.month == targetDate.month &&
        selectDate.day == targetDate.day;
  }

}