
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todoapp/shared/components/components.dart';
import 'package:todoapp/shared/cubit/cubit.dart';
import 'package:todoapp/shared/cubit/states.dart';




class AddTasksScreen extends StatelessWidget {


  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formdKey = GlobalKey<FormState>();

  var titleController = TextEditingController();
  var dateController = TextEditingController();
  var timeController = TextEditingController();

  //@override
  // void initState() {super.initState();createDatabase();}


  @override
  Widget build(BuildContext context) {
    return BlocProvider(

      create: (BuildContext context) =>
      AppCubit()
        ..createDatabase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, AppStates state) {
          if (state is AppInsertDatabaseState) {

          }
        },
        builder: (BuildContext context, AppStates state) {

          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            resizeToAvoidBottomInset: false,

            body:  SingleChildScrollView(
              child: Container(

                  padding: const EdgeInsets.all(20.0),

                child: Form(
                  key: formdKey,

                  child: Column(

                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 50.0,
                      ),
                      Text("Add A New Task Now !",
                          style: TextStyle(
                          fontSize: 30.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                      SizedBox(
                        height: 40.0,
                      ),
                      defaultFormField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),

                            fillColor: Colors.yellow
                        ),
                        prefix: Icons.title,
                        validate: (String? val) {
                          if (val!.isEmpty) {
                            return 'title is empty';
                          }
                          return null;
                        },
                        controller: titleController,
                        label: 'Task Title',
                        type: TextInputType.text,
                      ),
                      SizedBox(height: 15),
                      defaultFormField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Enter a search term',
                            fillColor: Colors.yellow
                        ),
                        prefix: Icons.watch_later_outlined,
                        validate: (String? val) {
                          if (val!.isEmpty) {
                            return 'time is empty';
                          }
                          return null;
                        },
                        controller: timeController,
                        label: 'Task Time',
                        type: TextInputType.datetime,
                        onTap: () {
                          showTimePicker(
                              context: context,
                              builder: (context, child) {
                                return Theme(
                                  data: Theme.of(context).copyWith(
                                    colorScheme: ColorScheme.light(
                                      primary: Color(0xFFFABB43), // <-- SEE HERE
                                      onPrimary: Color(0xFFFFF2D9), // <-- SEE HERE
                                      onSurface: Colors.black, // <-- SEE HERE
                                    ),
                                    textButtonTheme: TextButtonThemeData(
                                      style: TextButton.styleFrom(
                                        primary: Color(0xFFFABB43), // button text color
                                      ),
                                    ),
                                  ),
                                  child: child!,
                                );
                              },
                              initialTime: TimeOfDay.now()).then((value) {
                            timeController.text =
                                value!.format(context).toString();

                          });
                        },
                      ),
                      SizedBox(height: 15),
                      defaultFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter a search term',
                          fillColor: Colors.yellow
                        ),
                        prefix: Icons.calendar_today,
                        validate: (String? val) {
                          if (val!.isEmpty) {
                            return 'Date is empty';
                          }
                          return null;
                        },
                        controller: dateController,
                        label: 'Task Date',
                        type: TextInputType.datetime,
                        onTap: () {
                          showDatePicker(

                              context: context,
                              builder: (context, child) {
                                return Theme(
                                  data: Theme.of(context).copyWith(
                                    colorScheme: ColorScheme.light(
                                      primary: Color(0xFFFABB43), // <-- SEE HERE
                                      onPrimary: Color(0xFFFFF2D9), // <-- SEE HERE
                                      onSurface: Colors.black, // <-- SEE HERE
                                    ),
                                    textButtonTheme: TextButtonThemeData(
                                      style: TextButton.styleFrom(
                                        primary: Color(0xFFFABB43), // button text color
                                      ),
                                    ),
                                  ),
                                  child: child!,
                                );
                              },
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime.parse('2029-12-12'))
                              .then((value) {
                            dateController.text =
                                DateFormat.yMMMd().format(value!);
                          });
                          SizedBox(height: 15);


                        },
                      ),
                    SizedBox(height: 25),

                      InkWell(
                        onTap: (){
                          cubit.insertToDatabase(title: titleController.text,
                            date: dateController.text,
                            time: timeController.text,);

                        },

                        child: Container(
                          height: 50.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Color(0xFFFABB43),
                                    Color(0xFFFABB43),

                                  ])),
                          child: Center(
                            child: Text(
                              'Add Task',
                              style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ],

                  ),
                ),


                //BottomNavigationBarItem(icon: Icon(Icons.task),label:'Tasks',),
                //BottomNavigationBarItem(icon: Icon(Icons.check),label:'Done',),
                // BottomNavigationBarItem(icon: Icon(Icons.archive),label:'Archive',),


              ),
            ),
          );
        },),);
  }


}
