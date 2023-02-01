import 'package:b2connect_flutter/model/services/navigation_service.dart';
import 'package:b2connect_flutter/model/utils/service_locator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:b2connect_flutter/view_model/providers/app_language_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangeLanguageBottomSheet extends StatefulWidget {
  const ChangeLanguageBottomSheet({Key? key}) : super(key: key);

  @override
  _ChangeLanguageBottomSheetState createState() =>
      _ChangeLanguageBottomSheetState();
}

class _ChangeLanguageBottomSheetState extends State<ChangeLanguageBottomSheet> {
  String? whichLanguage;
  var navigationService = locator<NavigationService>();
  getLanguage() async {
    var prefs = await SharedPreferences.getInstance();
    setState(() {
      whichLanguage = prefs.getString('language_code');
    });

    print('this is langahe---$whichLanguage');
  }

  @override
  void initState() {
    super.initState();
    getLanguage();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Container(
      child: new Wrap(
        children: <Widget>[
          Column(
            children: [
              SizedBox(
                height: height * 0.030,
              ),
              Center(
                  child: Text(
                "Change Language",
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Lexend',
                    fontSize: height * 0.030,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1),
              )),
              Divider(
                thickness: 1,
                height: height * 0.020,
              ),
              SizedBox(
                height: height * 0.020,
              ),
              Container(
                //padding: EdgeInsets.only(left: 7.h, right: 7.h),
                width: MediaQuery.of(context).size.width,
                height: 40.h,
                child: ElevatedButton(
                  onPressed: () {
                    navigationService.closeScreen();
                    Provider.of<AppLanguage>(context, listen: false).changeLanguage(Locale("en"));
                  },
                  style: ElevatedButton.styleFrom(
                      elevation: 0, primary: Colors.transparent),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      new Text(
                        'English',
                        style: TextStyle(
                            fontFamily: 'Lexend',
                            color: Colors.black, letterSpacing: 1),
                      ),
                      whichLanguage == 'en'
                          ? Icon(
                              Icons.check,
                              size: height * 0.030,
                              color: Colors.pink,
                            )
                          : Text('')
                    ],
                  ),
                ),
              ),
              Container(
                //padding: EdgeInsets.only(left: 7.h, right: 7.h),
                width: MediaQuery.of(context).size.width,
                height: 40.h,
                child: ElevatedButton(
                  onPressed: () {
                    navigationService.closeScreen();
                    Provider.of<AppLanguage>(context, listen: false)
                        .changeLanguage(Locale("hi"));
                  },
                  style: ElevatedButton.styleFrom(
                      elevation: 0, primary: Colors.transparent),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      new Text(
                        'Hindi',
                        style: TextStyle(
                            fontFamily: 'Lexend',
                            color: Colors.black, letterSpacing: 1),
                      ),
                      whichLanguage == 'hi'
                          ? Icon(
                              Icons.check,
                              size: height * 0.030,
                              color: Colors.pink,
                            )
                          : Text(' ')
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.010,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 6,
                  width: width * 0.35,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
