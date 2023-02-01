import 'package:b2connect_flutter/model/locale/app_localization.dart';
import 'package:b2connect_flutter/model/services/navigation_service.dart';
import 'package:b2connect_flutter/model/utils/routes.dart';
import 'package:b2connect_flutter/model/utils/service_locator.dart';
import 'package:b2connect_flutter/view/screens/scan_your_emirates_id_screen.dart';
import 'package:b2connect_flutter/view/widgets/get_verified_bottom_sheet.dart';
import 'package:b2connect_flutter/view/widgets/appbar_with_back_icon_and_language.dart';
import 'package:b2connect_flutter/view/widgets/new_emirates_id_widget.dart';
import 'package:b2connect_flutter/view/widgets/user_information_widget.dart';
import 'package:b2connect_flutter/view_model/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:relative_scale/relative_scale.dart';
import '../../model/services/navigation_service.dart';
import '../../model/utils/service_locator.dart';

class PersonalInformationScreen extends StatefulWidget {
  const PersonalInformationScreen({Key? key}) : super(key: key);

  @override
  _PersonalInformationScreenState createState() =>
      _PersonalInformationScreenState();
}

class _PersonalInformationScreenState extends State<PersonalInformationScreen> {
  // late UserEmiratesData userEmiratesData;
  //late String mobileNumber;

  /*late UserInfoModel userInfoData;*/

  // late MaskedTextController phoneNumberTextMask;

  var _navigationService = locator<NavigationService>();
  //var storageService = locator<StorageService>();

  /*@override
  TextEditingController emiratesIdController = TextEditingController();*/

  // @override
  // void initState() {
  //   super.initState();
  //   /*userEmiratesData =
  //       Provider.of<ScannerProvider>(context, listen: false).userEmiratesData;
  //   userInfoData =
  //       Provider.of<AuthProvider>(context, listen: false).userInfoData!;*/
  //
  //   //checkEmiratesId();
  // }

  @override
  Widget build(BuildContext context) {
    // final double width = MediaQuery.of(context).size.width;
    return RelativeBuilder(builder: (context, height, width, sy, sx) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBarWithBackIconAndLanguage(
          onTapIcon: () {
            Navigator.pop(context);
          },
        ),
        body: Consumer<AuthProvider>(builder: (context, i, _) {

          return SingleChildScrollView(
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Text(
                          AppLocalizations.of(context)!
                              .translate('my_profile')!,
                          style: TextStyle(
                            //height: 1.2,
                            fontSize: 30.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.translate('emirates_id')!,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 18.sp,
                              ),
                            ),
                           /* GestureDetector(
                              onTap: (){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ScanYourEmiratesIDScreen()))
                                    .then((value) {
                                  *//* setState(() {
                                  checkEmiratesId();
                                });*//*
                                });
                              },
                              child: Text(
                                AppLocalizations.of(context)!.translate('scan_now')!,
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ),*/
                          ],
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        NewEmiratesIdWidget(enableEditing: false),
                       /* SizedBox(
                          height: 20.h,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ScanYourEmiratesIDScreen()))
                                .then((value) {
                              *//* setState(() {
                                  checkEmiratesId();
                                });*//*
                            });
                            *//*_getVerifiedModalBottomSheet(context);*//*
                          },
                          child: Text(
                            AppLocalizations.of(context)!
                                .translate('how_verified')!,
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              *//*letterSpacing: 0.5*//*),
                          ),
                        ),*/
                        /*  Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                          *//*  Container(
                              width: 130.w,
                              height: 40.h,
                              child:
                             *//**//* CustomButton(
                                height: 50.h,
                                width: double.infinity,
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ScanYourEmiratesIDScreen()))
                                      .then((value) {
                                    *//**//**//**//* setState(() {
                                  checkEmiratesId();
                                });*//**//**//**//*
                                  });
                                },
                                text:
                                AppLocalizations.of(context)!.translate('scan_now')!,
                              ),*//**//*

                             *//**//* ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ScanYourEmiratesIDScreen()))
                                      .then((value) {
                                    *//**//**//**//* setState(() {
                                  checkEmiratesId();
                                });*//**//**//**//*
                                  });
                                  *//**//**//**//* navigationService
                                .navigateTo(ScanYourEmiratesIDScreenRoute);*//**//**//**//*
                                },
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  textStyle: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                  shape: new RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(6.0),
                                  ),
                                  primary: Theme.of(context).primaryColor,
                                ),
                                child: new Text(
                                  AppLocalizations.of(context)!
                                      .translate('scan_now')!,
                                  style: TextStyle(
                                      color: Color.fromRGBO(255, 235, 242, 1),
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 1),
                                ),
                              ),*//**//*
                            ),*//*
                            InkWell(
                              onTap: () {
                                _getVerifiedModalBottomSheet(context);
                              },
                              child: Text(
                                AppLocalizations.of(context)!
                                    .translate('how_verified')!,
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 0.5),
                              ),
                            ),
                          ],
                        ),*/
                        SizedBox(
                          height: 40.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.translate('your_info')!,
                              style: TextStyle(
                                // height: 1.2,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            GestureDetector(
                              onTap: (){
                                _navigationService.navigateTo(EditPersonalInformationScreenRoute);

                              },
                              child: Text(
                                AppLocalizations.of(context)!.translate('edit_button')!,
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  //height: 1.2,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 40.h,
                        ),
                        UserInformationWidget(false),
                      ]),
                  // Column(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     SizedBox(
                  //       height: 20.h,
                  //     ),
                  //     Container(
                  //       width: 80.w,
                  //       height: 40.h,
                  //       child: ElevatedButton(
                  //         onPressed: () {
                  //           navigationService.navigateTo(EditPersonalInformationScreenRoute);
                  //         },
                  //         style: ElevatedButton.styleFrom(
                  //           elevation: 0,
                  //           textStyle: TextStyle(
                  //               fontSize: 14, fontWeight: FontWeight.w500),
                  //           shape: new RoundedRectangleBorder(
                  //             borderRadius: new BorderRadius.circular(6.0),
                  //           ),
                  //           primary: Theme.of(context).primaryColor,
                  //         ),
                  //         child: new Text(
                  //           "Edit",
                  //           style: TextStyle(
                  //               color: Color.fromRGBO(255, 235, 242, 1),
                  //               fontSize: 16.sp,
                  //               fontWeight: FontWeight.w500,
                  //               letterSpacing: 1),
                  //         ),
                  //       ),
                  //     ),
                  //     SizedBox(
                  //       height: 20.h,
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
          );
        }),
      );
    });
  }

/*void checkEmiratesId() {
    if (userInfoData.emiratesId == "" && userEmiratesData.emiratesId == null) {
      emiratesIdTextMask = MaskedTextController(
          mask: '000-0000-0000000-0', text: '000-0000-0000000-0');
      verificationText = Text(
        'Not Verified',
        style: TextStyle(color: Colors.yellow),
      );
      verificationIcon = Icon(
        Icons.info_outline,
        color: Colors.yellow,
      );
    } else if ((userEmiratesData.emiratesId == null && userInfoData.emiratesId != "")|| (userEmiratesData.emiratesId != null && userInfoData.emiratesId != "")) {
      emiratesIdTextMask = MaskedTextController(
          mask: '000-0000-0000000-0', text: userInfoData.emiratesId);
      verificationText = Text(
        'Verified',
        style: TextStyle(color: Colors.green),
      );
      verificationIcon = Icon(
        Icons.check,
        color: Colors.green,
      );
    } else {
      emiratesIdTextMask = MaskedTextController(
          mask: '000-0000-0000000-0', text: userEmiratesData.emiratesId);
      verificationText = Text(
        'Verified',
        style: TextStyle(color: Colors.green),
      );
      verificationIcon = Icon(
        Icons.check,
        color: Colors.green,
      );
    }
  }*/
}

void _getVerifiedModalBottomSheet(context) {
  showModalBottomSheet(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(30.0),
        topLeft: Radius.circular(30.0),
      ),
    ),
    context: context,
    builder: (BuildContext bc) {
      return GetVerifiedBottomSheet();
    },
  );
}

/*void changeLanguageBottomSheet(context) {
  showModalBottomSheet(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(30.0),
        topLeft: Radius.circular(30.0),
      ),
    ),
    context: context,
    builder: (BuildContext bc) {
      return ChangeLanguageBottomSheet();
    },
  );
}*/
