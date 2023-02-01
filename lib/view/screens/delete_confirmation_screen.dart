import 'package:b2connect_flutter/view_model/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:salesiq_mobilisten/salesiq_mobilisten.dart';

import '../widgets/appbar_with_back_icon_and_language.dart';
import '../widgets/custom_buttons/gradiant_color_button.dart';
import '../widgets/showOnWillPop.dart';

class DeleteConfirmationScreen extends StatelessWidget {
  const DeleteConfirmationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBarWithBackIconAndLanguage(
          onTapIcon: () {
            navigationService.closeScreen();
          },
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
            /*  Text('Delete Account',
                  style: TextStyle(
                      // color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.w500)),
              SizedBox(
                height: 40.h,
              ),*/
              Text('Before Requesting to delete your account',
                  style: TextStyle(
                      // color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500)),
              SizedBox(
                height: 20.h,
              ),
              Text('Please Check the following:',
                  style: TextStyle(
                      // color: Colors.black,
                      fontSize: 18, fontWeight: FontWeight.w200)),
              SizedBox(
                height: 10.h,
              ),
              Row(
                children: [
                  Text(
                    '• ',
                    style: TextStyle(
                      // color: Colors.black,
                      fontSize: 30,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'You need to complete any ongoing orders.',
                      style: TextStyle(fontWeight: FontWeight.w200),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                children: [
                  Text(
                    '• ',
                    style: TextStyle(
                      // color: Colors.black,
                      fontSize: 30,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'You need to cancel any scheduled orders.',
                      style: TextStyle(fontWeight: FontWeight.w200),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                children: [
                  Text(
                    '• ',
                    style: TextStyle(
                      // color: Colors.black,
                      fontSize: 30,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Active Subscriptions & pending payments should be cleared.',
                      style: TextStyle(fontWeight: FontWeight.w200),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                children: [
                  Text(
                    '• ',
                    style: TextStyle(
                      // color: Colors.black,
                      fontSize: 30,
                    ),
                    maxLines: 1,
                  ),
                  Expanded(
                    child: Text(
                      'Smartphone purchase and EMI payments should be cleared before seeking deletion of account.',
                      style: TextStyle(fontWeight: FontWeight.w200),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.1),
                    border: Border.all(color: Colors.orange),
                  borderRadius: BorderRadius.all(
                      Radius.circular(5.0)
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Center(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text(
                            'Once you submit your request, you will be automatically logged out.',
                            style: TextStyle(fontWeight: FontWeight.w200),
                          ),
                        ),
                        SizedBox(height: 20,),
                        Text(
                          'If you login before the completion of the 30 day grace period, your deletion request will be cancelled and your account will remain unchanged.',
                          style: TextStyle(fontWeight: FontWeight.w200),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Spacer(),
              CustomButton(
                width: double.infinity,
                height: 50.h,
                onPressed: () async {
                  Provider.of<AuthProvider>(context, listen: false)
                      .deleteUserAccount(context);
                },
                text: 'Confirm Deletion',
              ),

            ],
          ),
        ));
  }
}
