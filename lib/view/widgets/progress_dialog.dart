 import 'package:flutter/material.dart';

class ProgressDialog1 extends StatelessWidget {
  final String? message;
  ProgressDialog1({this.message});
   @override
   Widget build(BuildContext context) {
     return Dialog(
       child: Container(
         margin: EdgeInsets.all(15),
         width: double.infinity,
         child:Row(
           children: [
             SizedBox(width: 6,),
             CircularProgressIndicator(

               valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
             ),
             SizedBox(width: 26,),
             Text('$message')

           ],
         )
       ),
     );
   }
 }
