import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/appbar_with_back_icon_and_language.dart';

class ComingSoonScreen extends StatelessWidget {
  const ComingSoonScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBarWithBackIconAndLanguage(
        onTapIcon: () {
          Navigator.pop(context);
        },
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Center(child: Padding(
          padding: const EdgeInsets.all(20),
          child: Text('COMING SOON!',style: TextStyle(color: Theme.of(context).primaryColor,fontWeight: FontWeight.bold, fontSize: 30.sp),textAlign: TextAlign.center,),
        )),
      ),
    );
  }
}
