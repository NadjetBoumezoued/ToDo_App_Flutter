import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     //1 parti f scaffold c app bar
     appBar: AppBar(
       leading: Icon(
         Icons.menu,
       ),
       title: Text(
         'ChatApp'
       ),
       actions: [
         IconButton(
           icon: Icon(
             Icons.notifications,
           ),
           onPressed:() {
             print('hello');
           },
         ),

       ],
       centerTitle: true,
       backgroundColor: Colors.purple,
       //list of widget
     ),
     body: Column(
           children:
         [
           Padding(
             padding:const EdgeInsets.all(50.0),
             child: Container(
               decoration: BoxDecoration(
                 borderRadius:BorderRadius.circular(20.0),
               ),
               clipBehavior: Clip.antiAliasWithSaveLayer,
               child: Stack(
                 alignment: Alignment.bottomCenter,
                 children: [

                   Image(
                       image: NetworkImage('https://i.pinimg.com/736x/70/e8/95/70e8957ec64793bcf30f0666c7c0b96e--bougainvillea.jpg'),
                     height: 200.0,
                     width: 200.0,
                     fit: BoxFit.cover,
                   ),
                   Container(
                     width: 200.0,
                     color: Colors.black.withOpacity(.5),
                     padding: EdgeInsets.symmetric(
                        vertical: 10.0,

                     ),
                     child: Text(
                       'Flower',
                       textAlign: TextAlign.center,
                       style: TextStyle(
                         color: Colors.white,
                         fontSize: 30.0,

                       ),
                     ),
                   ),
                 ],
               ),
             ),
           ),
           Text(
             'data4',
             style: TextStyle(
               color: Colors.pink,
               fontSize: 30.0,
               backgroundColor: Colors.purple,
             ),
           ),
           Text(
             'data1',
             style: TextStyle(
               color: Colors.pink,
               fontSize: 30.0,

             ),
           ),
           Text(
             'data2',

             style: TextStyle(
               color: Colors.pink,
               fontSize: 30.0,

             ),
           ),
           Text(
             'data3',
             style: TextStyle(
               color: Colors.pink,
               fontSize: 30.0,
               backgroundColor: Colors.blue,
             ),
           ),
           Text(
             'data4',
             style: TextStyle(
               color: Colors.pink,
               fontSize: 30.0,
               backgroundColor: Colors.purple,
             ),
           ),

         ],
     ),

   );//scaffold widjet tsagemlk l ecran
  }
  void onNotif()
  {
    print('notification clicked !');
  }
  
}