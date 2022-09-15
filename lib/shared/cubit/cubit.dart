

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todoapp/modules/add_tasks/add_screen.dart';
import 'package:todoapp/modules/done_tasks/done_tasks_screen.dart';
import 'package:todoapp/modules/new_tasks/new_tasks_screen.dart';
import 'package:todoapp/shared/cubit/states.dart';


class AppCubit extends Cubit<AppStates>
{
  AppCubit() : super(AppInitialState());
  static AppCubit get(context) =>BlocProvider.of(context);
  List <Widget> screens =
  [
    NewTasksScreen(),
    AddTasksScreen(),
    DoneTasksScreen(),

  ];
  List <String> titles =
  [
    'New Tasks',
    'Add Tasks',
    'Done Tasks',


  ];
  int currentIndex = 0;
  late Database database;
  List<Map> newTasks =[];
  List<Map> doneTasks =[];
  void changeIndex(int index)
  {
    currentIndex = index;
    emit(AppChangeBottomNavBarState());
  }

  void createDatabase()
  {
    openDatabase(
        'todo.db',
        version: 1,
        onCreate: (database,version)
        {
          print('database created');
          database.execute('CREATE TABLE tasks (id INTEGER PRIMARY KEY,title TEXT,date TEXT,time TEXT,status TEXT)').then((value)
          {
            print('table created');

          }).catchError((error){
            print('Error When Creating Table ${error.toString()}') ;
          });
        },
        onOpen:(database)
        {


          getDataFromDatabase(database);
         print('database opened');
        },
    ).then((value){
      database=value;
      emit(AppCreateDatabaseState());
    });
  }
  insertToDatabase({
    required String title,
    required String date,
    required String time,
  }) async {
     await database.transaction((txn)=> txn.rawInsert('INSERT INTO tasks (title,date,time,status) VALUES ("$title","$date","$time","new")'
      ).then((value) {
        print('task inserted');
        emit(AppInsertDatabaseState());


        getDataFromDatabase(database);
      }).catchError((err) {
        print(err.toString());
      }));
  }



  void getDataFromDatabase(Database database) {
    newTasks = [];
    doneTasks = [];
    emit(AppGetDatabaseLoadingState());
    database.rawQuery('SELECT * FROM tasks').then((value) {
      value.forEach((element) {
        if (element['status'] == 'new')
          newTasks.add(element);
        else if (element['status'] == 'done')
          doneTasks.add(element);

      });
      emit(AppGetDatabaseState());
    });
  }

  void updateData({required String status, required int id}) async {
    database.rawUpdate('UPDATE tasks SET status = ? WHERE id = ?', ['$status', id]).then((value) {
      getDataFromDatabase(database);
      emit(AppUpdateDatabaseState());
    });

  }
  void deleteData({ required int id}) async {
    database.rawUpdate(
        'DELETE from tasks WHERE id = ?', [id]).then((value) {
      getDataFromDatabase(database);
      emit(AppDeleteDatabaseState());
    });
  }
    bool isBottomSheetShown = false;
    IconData fabIcon = Icons.edit;

    void changeBottomSheetState({
      required bool isShow,
      required IconData icon,
    }) {
      isBottomSheetShown = isShow;
      fabIcon = icon;
      emit(AppChangeBottomSheetState());
    }
  }