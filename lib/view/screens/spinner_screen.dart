import 'dart:async';
import 'dart:math';
import 'package:b2connect_flutter/model/utils/constant.dart';
import 'package:b2connect_flutter/view/widgets/custom_buttons/gradiant_color_button.dart';
import 'package:b2connect_flutter/view_model/providers/auth_provider.dart';
import 'package:b2connect_flutter/view_model/providers/fortune_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:provider/provider.dart';

class SpinnerScreen extends StatefulWidget {
  const SpinnerScreen() : super();

  @override
  _SpinnerScreenState createState() => _SpinnerScreenState();
}

class _SpinnerScreenState extends State<SpinnerScreen> {
  StreamController<int> fortuneSelected = StreamController<int>();
  var selectedNumber = 0;
  bool _showCoupon = false;
  var _randomCode;
  var _couponCode = '';
  int _spinCounts = 1;
  Timer? timer;

  /* final items = <String>[
    'phones',
    'popcorn',
    'speaker',
    'socks',
    'headphones',
    '2x speed',
    'free wifi',
    'big draw',
    'big draw',
    'big draw',
    'big draw',
  ];*/
  final List<Color> colors = <Color>[
    Colors.redAccent,
    Colors.deepOrangeAccent,
    Colors.purple,
    Colors.purpleAccent,
    Colors.deepPurpleAccent,
    Colors.blueGrey,
    Colors.blueAccent,
    Colors.lightBlueAccent,
    Colors.green,
    Colors.lightGreen,
    Colors.yellow,
  ];

  @override
  void initState() {
    super.initState();
    Random random = Random();
    _randomCode = random.nextInt(999) + 100;
  }

/*
  @override
  void dispose() {
    fortuneSelected.close();
    super.dispose();
  }
*/

  @override
  Widget build(BuildContext context) {
    return Consumer<FortuneProvider>(builder: (context, i, _) {
      return Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                "assets/images/bg_spinner.png",
              ),
              fit: BoxFit.fill),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            automaticallyImplyLeading: true,
            //  leading:
            //  automaticallyImplyLeading: false,
            elevation: 0,
            //toolbarHeight: height * 0.08,
            title: Text('Special Spin & Win'),

            flexibleSpace: Container(
              decoration: BoxDecoration(gradient: gradientColor),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Text(
                  'Special Spin & Win',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Get a chance to win a Smart Phone & much more amazing prizes!',
                  textAlign: TextAlign.center,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: FortuneWheel(
                      duration: Duration(seconds: 5),
                      indicators: <FortuneIndicator>[
                        FortuneIndicator(
                          alignment: Alignment.topCenter,
                          // <-- changing the position of the indicator
                          child: TriangleIndicator(
                            color: Colors.greenAccent,
                            // <-- changing the color of the indicator
                          ),
                        ),
                      ],
                      animateFirst: false,
                      // onAnimationStart: showSelected(),
                      //onAnimationEnd: showSelected(),
                      selected: fortuneSelected.stream,
                      items: List.generate(
                        i.fortuneList.length,
                        (index) {
                          return FortuneItem(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Text(
                                i.fortuneList[index].name.toString(),
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            style: FortuneItemStyle(
                                color: colors[index].withOpacity(1),
                                borderWidth: 0),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: _showCoupon ? true : false,
                  child: Container(
                    color: Colors.yellow,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40.0, vertical: 10),
                      child: Text(
                          '$_couponCode'),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text('You have $_spinCounts spin left.'),
                // Text('$selectedNumber'),
                SizedBox(
                  height: 20,
                ),
                Visibility(
                  visible: _spinCounts == 0 ? false : true,
                  child: CustomButton(
                    text: 'Spin Now',
                    height: 50,
                    width: 300,
                    onPressed: () {
                      setState(() {
                        selectedNumber =
                            Fortune.randomInt(0, i.fortuneList.length);
                        fortuneSelected.add(selectedNumber);
                        _couponCode = '${i.fortuneList[selectedNumber].name!.substring(0, 3)}$_randomCode' ;
                        int timestamp = DateTime.now().millisecondsSinceEpoch;
                        Provider.of<AuthProvider>(context, listen: false).updateUserInfo(context,'','','',timestamp,_couponCode,'','');
                        timer = Timer.periodic(
                            Duration(seconds: 5), (Timer t) => showSelected());
                        _spinCounts -= 1;
                      });
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }

  showSelected() {
    setState(() {
      _showCoupon = true;
    });
  }
}
