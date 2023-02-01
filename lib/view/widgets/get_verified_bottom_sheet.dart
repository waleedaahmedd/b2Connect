import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class GetVerifiedBottomSheet extends StatefulWidget {
  const GetVerifiedBottomSheet({Key? key}) : super(key: key);

  @override
  _GetVerifiedBottomSheetState createState() => _GetVerifiedBottomSheetState();
}

class _GetVerifiedBottomSheetState extends State<GetVerifiedBottomSheet> {
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Container(
      child: Wrap(
        children: [
          Column(
            children: [
              SizedBox(
                height: height * 0.030,
              ),
              Center(
                  child: Text(
                    "How to get verified?",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1),
                  )),
              SizedBox(
                height: 10,
              ),
              Divider(
                thickness: 1,
                height: height * 0.020,
              ),
              SizedBox(
                height: height * 0.030,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: Text(
                  "Please Scan FRONT and BACK side your Emirates ID, This will help us verify you as on authorised user.\nAfter this step,you'll be able to buy our products.",
                  style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade500,
                      height: 1.4),
                ),
              ),
              SizedBox(
                height: height * 0.030,
              ),

              Image.asset(
                "assets/images/cardscan.png",
                width: 200.0.w,
                //height: 250.0.h,
              ),
              SizedBox(
                height: height * 0.030,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
