import 'dart:io';
import 'package:b2connect_flutter/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class SupportWidgetNew extends StatefulWidget {
  final String? txt;
  final String? icon;
  final String? subTxt;
  // ValueChanged<dynamic>? action;
  // String? tag;
  // final active;
  SupportWidgetNew({this.icon,this.subTxt, this.txt,});
  @override
  _SupportWidgetNewState createState() => _SupportWidgetNewState();
}

class _SupportWidgetNewState extends State<SupportWidgetNew> {
  late Future<void> _launched;

  Future<void> _sendmail(String toMailId, String subject, String body) async {
    var url = 'mailto:$toMailId?subject=$subject&body=$body';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  // void handletap() {
  //   widget.action!(widget.tag!);
  //   if (widget.tag == '4') {
  //     setState(() {
  //       _launched = _sendmail('support@bsquaredwifi.com', 'Issue report',
  //           'Issue description\n\n\n');
  //     });
  //   } else if (widget.tag == '1') {
  //     setState(() {
  //       _launched = _makePhoneCall('tel: 800614');
  //     });
  //   } else if (widget.tag == '3') {
  //     openWhatsapp();
  //   } else if (widget.tag == '5') {
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => WebViewPage(
  //             title: 'Support',
  //             url:
  //                 "https://forms.zohopublic.com/bsquaredwifi/form/ComplaintForm2/formperma/O83_l2WJ9yIpGn3HczrIWCPj3gN-lJ9MRuGbTf2nY8s?SingleLine3=&SingleLine=&Name_First=dear%20guest&Email="),
  //       ),
  //     );
  //   } else {
  //     print('non');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    //return RelativeBuilder(builder: (context, height, width, sy, sx) {
      return Container(
        padding: EdgeInsets.fromLTRB(5.w, 10.h, 5.w, 10.h),
        margin:
            EdgeInsets.only(top: height * 0.010.h, bottom: height * 0.010.h),
        decoration: BoxDecoration(
            color: Color.fromRGBO(255, 245, 249, 1),
            borderRadius: BorderRadius.circular(10.r)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(height * 0.015.h),
                  decoration: BoxDecoration(
                      color: Colors.white, shape: BoxShape.circle),
                  child: Image.asset(widget.icon!,
                      fit: BoxFit.fill, height: ScreenSize.supportIcons),
                ),
                SizedBox(width: width * 0.030.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.txt!,
                      style: TextStyle(
                          fontSize: ScreenSize.productCardText,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          height: height * 0.001.h),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Container(
                      height: 20.h,
                      width: width*0.62,

                      child: Text(
                        widget.subTxt!,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,

                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Container(
              width: ScreenSize.supportContainerWidth,
              height: ScreenSize.supportContainerHeight,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                //borderRadius: BorderRadius.circular(5.r),
                color: Colors.white,
              ),
              child: Image.asset(
                "assets/images/send.png",
              ),
            )
          ],
        ),
      );
    //});
  }

  openWhatsapp() async {
    var whatsapp = "+97148753894";
    var whatsappURlAndroid = "whatsapp://send?phone=" + whatsapp + "&text=%s";
    var whatappURLIos = "https://wa.me/$whatsapp?text=${Uri.parse("%s")}";
    if (Platform.isIOS) {
      // for iOS phone only
      if (await canLaunch(whatappURLIos)) {
        await launch(whatappURLIos, forceSafariVC: false);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: new Text("whatsapp no installed")));
      }
    } else {
      // android , web
      if (await canLaunch(whatsappURlAndroid)) {
        await launch(whatsappURlAndroid);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: new Text("whatsapp no installed")));
      }
    }
  }
}
