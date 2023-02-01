import 'package:b2connect_flutter/model/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../view_model/providers/auth_provider.dart';
import '../widgets/appbar_with_back_icon_and_language.dart';
import '../widgets/custom_buttons/gradiant_color_button.dart';
import '../widgets/showOnWillPop.dart';

class DeleteAccountScreen extends StatefulWidget {
  const DeleteAccountScreen({Key? key}) : super(key: key);

  @override
  State<DeleteAccountScreen> createState() => _DeleteAccountScreenState();
}

class _DeleteAccountScreenState extends State<DeleteAccountScreen> {
  List<dynamic> _reasons = [
    {
      'id': 1,
      'description': 'Something was broken.',
    },
    {
      'id': 2,
      'description': 'I have privacy concern.',
    },
    {
      'id': 3,
      'description': 'I\'m not interested.',
    },
    {
      'id': 4,
      'description': 'Other',
    },
  ];

  int _deleteAccountScreenNumber = 1;
  int _selectedIndex = -1;
  final TextEditingController _explanation = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (_deleteAccountScreenNumber == 1) {
          navigationService.closeScreen();
        } else {
          setState(() {
            _deleteAccountScreenNumber -= 1;
          });
        }
        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBarWithBackIconAndLanguage(
          onTapIcon: () {
            if (_deleteAccountScreenNumber == 1) {
              navigationService.closeScreen();
            } else {
              setState(() {
                _deleteAccountScreenNumber -= 1;
              });
            }
          },
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Delete Account',
                      style: TextStyle(
                          // color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.w500)),
                  SizedBox(
                    height: 40.h,
                  ),
                  Visibility(
                    visible: _deleteAccountScreenNumber == 1,
                    child: Column(
                      children: [
                        ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: _reasons.length,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (BuildContext context, int index) {
                              return Column(
                                children: [
                                  ListTile(
                                    contentPadding:
                                        EdgeInsets.only(left: 0.0, right: 0.0),
                                    title: Text(_reasons[index]['description']),
                                    leading: Radio<dynamic>(
                                      materialTapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                      value: index,
                                      activeColor:
                                          Theme.of(context).primaryColor,
                                      groupValue: _selectedIndex,
                                      onChanged: (value) {
                                        setState(() {
                                          _selectedIndex = value;
                                          Provider.of<AuthProvider>(context,
                                                  listen: false)
                                              .setReasonId(
                                                  _reasons[index]['id']);
                                        });
                                      },
                                    ),
                                  ),
                                  Divider(
                                    color: Colors.grey,
                                  ),
                                ],
                              );
                            }),
                        SizedBox(
                          height: 40.h,
                        ),
                        CustomButton(
                          width: double.infinity,
                          height: 50.h,
                          onPressed: () {
                            _selectedIndex == 3
                                ? setState(() {
                                    _deleteAccountScreenNumber = 2;
                                  })
                                : navigationService
                                    .navigateTo(DeleteConfirmationScreenRoute);
                          },
                          text: 'Submit',
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: _deleteAccountScreenNumber == 2,
                    child: Column(
                      children: [
                        Text(
                          'It\'s so sad to see you leaving, Please share your opinion it will help us to improve our services.',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w200),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.multiline,
                          maxLines: 15,
                          controller: _explanation,
                          decoration: new InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 15.0,
                                horizontal: 15.0,
                              ),
                              isDense: true,
                              // Added this
                              // border: OutlineInputBorder(),
                              filled: true,
                              fillColor: Colors.grey.shade100,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor),
                              ),
                              hintStyle: TextStyle(color: Colors.grey),
                              hintText: 'Your explanation is entirely optional'

                              //labelText: 'Sales Agent Code'
                              ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        CustomButton(
                          width: double.infinity,
                          height: 50.h,
                          onPressed: () {
                            navigationService
                                .navigateTo(DeleteConfirmationScreenRoute);
                          },
                          text: 'Continue...',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
