import 'dart:io';

import 'package:b2connect_flutter/view/widgets/web_view_page.dart';
import 'package:flutter/material.dart';
import 'package:relative_scale/relative_scale.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class SupportWidget extends StatefulWidget {
  final data;
  ValueChanged<dynamic>? action;
  String? tag;
  final active;
  final active1;

  SupportWidget({this.action, this.data, this.tag, this.active, this.active1});

  @override
  _SupportWidgetState createState() => _SupportWidgetState();
}

class _SupportWidgetState extends State<SupportWidget> {
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

  void handleTap() {
    widget.action!(widget.tag!);
    if (widget.tag == '4') {
      setState(() {
        _launched = _sendmail('support@bsquaredwifi.com', 'Issue report',
            'Issue description\n\n\n');
      });
    } else if (widget.tag == '5') {
      setState(() {
        _launched = _makePhoneCall('tel: 800614');
      });
    } else if (widget.tag == '3') {
      openWhatsapp();
    } else if (widget.tag == '1') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WebViewPage(
            url:
                "https://forms.zohopublic.com/bsquaredwifi/form/ComplaintForm2/formperma/O83_l2WJ9yIpGn3HczrIWCPj3gN-lJ9MRuGbTf2nY8s?SingleLine3=&SingleLine=&Name_First=dear%20guest&Email=",
            title: "Report An Issue",
          ),
        ),
      );
    } else {
      print('non');
    }
  }

  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(builder: (context, height, width, sy, sx) {
      return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 3,
        margin: EdgeInsets.all(10),
        child: InkWell(
          onTap: () {
            handleTap();
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 100.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(widget.data['Icon'],
                    size: 36.h, color: Theme.of(context).primaryColor),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  widget.data['title'],
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w600,
                    color: Color.fromRGBO(126, 125, 125, 1),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
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
