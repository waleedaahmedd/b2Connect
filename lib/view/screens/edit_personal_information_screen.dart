import 'package:b2connect_flutter/model/models/userinfo_model.dart';
import 'package:b2connect_flutter/view/widgets/appbar_with_back_icon_and_language.dart';
import 'package:b2connect_flutter/view/widgets/user_information_widget.dart';
import 'package:b2connect_flutter/view_model/providers/auth_provider.dart';
import 'package:flutter/material.dart';
//import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:relative_scale/relative_scale.dart';

class EditPersonalInformationScreen extends StatefulWidget {
  const EditPersonalInformationScreen({Key? key}) : super(key: key);

  @override
  _EditPersonalInformationScreenState createState() =>
      _EditPersonalInformationScreenState();
}


class _EditPersonalInformationScreenState
    extends State<EditPersonalInformationScreen> {
  //String? _countryValue;
  //String? _stateValue;
  //String? _cityValue;
  late UserInfoModel _userInfoData;

  //bool _checkbox1 = false;
  // ignore: unused_field
  //bool _showPassword = false;
  //String _initialCountry = 'NG';
  //PhoneNumber _number = PhoneNumber(isoCode: 'NG');
  //var navigationService = locator<NavigationService>();
  //var storageService = locator<StorageService>();
  //DateTime _selectedFromDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _userInfoData =
    Provider.of<AuthProvider>(context, listen: false).userInfoData!;
  }

  @override


  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(builder: (context, height, width, sy, sx) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBarWithBackIconAndLanguage(
          onTapIcon: () {
            Navigator.pop(context);
          },
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(15),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  "Edit Personal \nInformation",
                  style: TextStyle(
                    height: 1.2,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  color: Colors.white,
                  child: UserInformationWidget(true),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}


