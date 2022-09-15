import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/shared/cubit/cubit.dart';


Widget defaultButton({
  double width=double.infinity,
  Color background=Colors.lightBlue,
  bool isUpperCase = true,
  required Function function,
  required String text,

}) =>
    Container(
      width: width,
      color: background,
      child: MaterialButton(
        onPressed: function(),
        child:Text(
            isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            color: Colors.white
          ),
        ) ,
      ),
);
Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  Function? onSubmit,
  Function? onChange,
  Function? onTap,
  bool isPassword = false,
  required Function validate,
  required String label,
  required IconData prefix,
  bool isClickable = true, required InputDecoration decoration,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: onSubmit as void Function(String)?,
      onChanged: onChange as void Function(String)?,
      onTap: onTap as void Function()?,
      validator: validate as String? Function(String?)?,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
        prefixIcon: Icon(
          prefix,
        ),

  ),
);
Widget buildTaskItem(Map model,context) => Dismissible(
  key: Key(model['id'].toString()),

  child:Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      decoration: BoxDecoration(

          color: Color(0xFFFFF2D9),
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(

                color: Colors.white, blurRadius: 1.0, spreadRadius: 0.3)
         ]),

      child: Padding(

        padding: const EdgeInsets.all(0.0),


        child: Row(

          children: [


            IconButton(

                onPressed: (){

                  AppCubit.get(context).updateData(

                    status: 'done',

                    id: model['id'],);

                },

                icon: Icon(

                  Icons.circle_outlined,

                  color: Color(0xFFFABB43),
                )),

            SizedBox(

              width: 20.0,

            ),
            Expanded(

              child: Column(

                mainAxisSize: MainAxisSize.min,

                crossAxisAlignment: CrossAxisAlignment.start,

                children: [

                  Text(

                    '${model['title']}',

                    style: TextStyle(

                        fontSize:18.0,

                        fontWeight: FontWeight.bold),





                  ),

                  SizedBox(

                    height: 5.0,

                  ),





                ],

              ),

            ),
            Text(

              '${model['time']} pm',
              style: TextStyle(

                  fontSize:12.0,

                  color: Colors.grey,

                  fontWeight: FontWeight.bold),

            ),

            SizedBox(

              width: 20.0,

            ),










          ],

        ),

      ),
    ),
  ),

  onDismissed:(direction)
  {
    AppCubit.get(context).deleteData(id: model['id'],);
  } ,
);
Widget tasksBuilder({
  required List<Map> tasks,
 }) => ConditionalBuilder(
  condition:tasks.length>0,
  builder:(context) => ListView.builder(
      itemBuilder: (context, index)
      {
        print('task status  ${tasks[index]['status']}');
        return buildTaskItem(tasks[index], context);
      },
      itemCount: tasks.length),
  fallback: (context) => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/no-tasks.png',
          height: 150.0,
          width: 150.0,
          fit: BoxFit.fill,
        ),
        SizedBox(
          height: 40.0,
        ),
        Text('No Tasks Yet !' ,
          style: TextStyle(
            fontSize: 18.0,
            color: Colors.grey,
            fontWeight: FontWeight.bold,
          ),),
      ],
    ),
  ),
);