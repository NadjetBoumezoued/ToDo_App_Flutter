import 'package:conditional_builder/conditional_builder.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todoapp/shared/cubit/cubit.dart';
import 'package:todoapp/shared/cubit/states.dart';





class HomeLayout extends StatelessWidget {


  var scaffoldKey = GlobalKey<ScaffoldState>();

  //@override
 // void initState() {super.initState();createDatabase();}


  @override
  Widget build(BuildContext context) {
    return BlocProvider(

      create: (BuildContext context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit,AppStates>(
        listener:(BuildContext context ,AppStates state){

        } ,
        builder: (BuildContext context ,AppStates state){
          AppCubit cubit= AppCubit.get(context);
          return Scaffold(
          key: scaffoldKey,


          appBar: AppBar(
            backgroundColor: Color(0xFFFABB43),
          title: Text(
          cubit.titles[cubit.currentIndex],
          ),
          ),
          body:ConditionalBuilder(
          condition: state is! AppGetDatabaseLoadingState,
          builder: (context) =>  cubit.screens[cubit.currentIndex],
          fallback: (context) => Center(
              child: CircularProgressIndicator()),

          ),


          bottomNavigationBar: CurvedNavigationBar(
            backgroundColor:  Colors.transparent,
         color: Color(0xFFFABB43),
         // type:BottomNavigationBarType.fixed,

         // backgroundColor: Colors.transparent,
         // elevation: 50.0,
         // currentIndex: AppCubit.get(context).currentIndex,
          onTap: (index)
          {
            AppCubit.get(context).changeIndex(index);
          //setState(()
          //{currentIndex = index ;});
          },

          items:
          [
            Icon(Icons.menu),
            Icon(Icons.add),
            Icon(Icons.done_all_rounded),

            ],
          ),

          );
        },

      ),
    );
  }
  //Future<String> getName() async //thread
  //{return 'Nadjet';}




}
