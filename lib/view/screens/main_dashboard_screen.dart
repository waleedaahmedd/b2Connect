import 'package:b2connect_flutter/model/locale/app_localization.dart';
import 'package:b2connect_flutter/model/utils/constant.dart';
import 'package:b2connect_flutter/view_model/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../view/screens/support_screen.dart';
import '../../view/screens/main_profile_screen.dart';
import '../../view/screens/home_screen.dart';

class MainDashBoard extends StatefulWidget {
  final int? selectedIndex;
  const MainDashBoard({Key? key,this.selectedIndex}) : super(key: key);


  @override
  _MainDashBoardState createState() => _MainDashBoardState();
}

class _MainDashBoardState extends State<MainDashBoard> {
  int? _selectedIndex;



  //bool? _active;

  List<Widget> _items = [
    HomeScreen(),
    SupportScreen(),
    MainProfileScreen(),
  ];

  setNavigateDecision() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setBool('isShowHome', true);
  }
  callFcmToken(){
   Provider.of<AuthProvider>(context,listen: false).callFcmToken(Provider.of<AuthProvider>(context,listen: false).fcmToken!);
  }
  @override
  void initState() {
    callFcmToken();
    setNavigateDecision();
    super.initState();
    setState(() {
      _selectedIndex=widget.selectedIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: IndexedStack(
        index: _selectedIndex,
        children: _items,
      ) //_items.elementAt(_index),
          ),
      bottomNavigationBar: _showBottomNav(),
    );
  }

  Widget _showBottomNav() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        //Color(0xFF0D0B26),
        boxShadow: [
          BoxShadow(
            blurRadius: 10,

            color: Colors.grey[200]!,
          )
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
          child: GNav(
            rippleColor: Colors.grey[300]!,
            hoverColor: Colors.grey[100]!,
            gap: 8,
            activeColor: Colors.white,
            iconSize: 24,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            duration: Duration(milliseconds: 400),
            tabBackgroundColor: pink,
            color: Colors.black,
            tabs: [
              GButton(
                icon: Icons.home_filled,
                text: AppLocalizations.of(context)!.translate('home')!,
              ),
              GButton(
                icon: Icons.headset_mic_rounded,
                text: AppLocalizations.of(context)!.translate('support')!,
              ),
              GButton(
                icon: Icons.account_circle_sharp,
                text: AppLocalizations.of(context)!.translate('profile')!,
              ),

            ],
            selectedIndex: _selectedIndex!,
            onTabChange: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }

  // void _onTap(int index) {
  //   _selectedIndex = index;
  //   setState(() {});
  // }
}
