import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../view_model/providers/scanner_provider.dart';
import '../widgets/appbar_with_back_icon_and_language.dart';
import '../widgets/custom_buttons/button_with_loader.dart';
import '../widgets/custom_buttons/gradiant_color_button.dart';
import '../widgets/indicator.dart';

class UploadEidImageScreen extends StatefulWidget {
  const UploadEidImageScreen({Key? key}) : super(key: key);

  @override
  _UploadEidImageScreenState createState() => _UploadEidImageScreenState();
}

class _UploadEidImageScreenState extends State<UploadEidImageScreen> {
  bool onTapUploadImage = true;
  bool onTapUploadPdf = false;
  bool onTapUploadDoc = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<ScannerProvider>(builder: (context, i, _) {
      return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBarWithBackIconAndLanguage(
            onTapIcon: () {
              Navigator.pop(context);
            },
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IndicatorWidget("2"),
                  SizedBox(
                    height: 40.h,
                  ),
                  Text(
                    'Upload your\nEmirates ID',
                    style: TextStyle(
                        fontSize: 30.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  Text(
                    'Choose document type',
                    style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        height: 1.4),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            onTapUploadImage = true;
                            onTapUploadDoc = false;
                            onTapUploadPdf = false;
                          });
                        },
                        child: Container(
                          decoration: onTapUploadImage
                              ? selectedBox()
                              : unSelectedBox(),
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Text(
                              'Image (JPG, PNG)',
                              style: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: onTapUploadImage
                                      ? FontWeight.bold
                                      : FontWeight.w200,
                                  color: onTapUploadImage
                                      ? Theme.of(context).primaryColor
                                      : Colors.grey),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            onTapUploadImage = false;
                            onTapUploadDoc = false;
                            onTapUploadPdf = true;
                          });
                        },
                        child: Container(
                          decoration: onTapUploadPdf
                              ? selectedBox()
                              : unSelectedBox(),
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Text(
                              'PDF',
                              style: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: onTapUploadPdf
                                      ? FontWeight.bold
                                      : FontWeight.w200,
                                  color: onTapUploadPdf
                                      ? Theme.of(context).primaryColor
                                      : Colors.grey),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            onTapUploadImage = false;
                            onTapUploadDoc = true;
                            onTapUploadPdf = false;
                          });
                        },
                        child: Container(
                          decoration: onTapUploadDoc
                              ? selectedBox()
                              : unSelectedBox(),
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Text(
                              'Docx.',
                              style: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: onTapUploadDoc
                                      ? FontWeight.bold
                                      : FontWeight.w200,
                                  color: onTapUploadDoc
                                      ? Theme.of(context).primaryColor
                                      : Colors.grey),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  Text(
                    'Upload ${onTapUploadImage ? 'image' : onTapUploadPdf ? 'pdf' : onTapUploadDoc ? 'document' : ''}',
                    style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        height: 1.4),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: DottedBorder(
                      color: Theme.of(context).primaryColor,
                      strokeWidth: 2,
                      radius: Radius.circular(10),
                      dashPattern: [10, 5],
                      customPath: (size) {
                        return Path()
                          ..moveTo(10, 0)
                          ..lineTo(size.width - 10, 0)
                          ..arcToPoint(Offset(size.width, 10),
                              radius: Radius.circular(10))
                          ..lineTo(size.width, size.height - 10)
                          ..arcToPoint(Offset(size.width - 10, size.height),
                              radius: Radius.circular(10))
                          ..lineTo(10, size.height)
                          ..arcToPoint(Offset(0, size.height - 10),
                              radius: Radius.circular(10))
                          ..lineTo(0, 10)
                          ..arcToPoint(Offset(10, 0),
                              radius: Radius.circular(10));
                      },
                      child: Container(
                        height: 130.h,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text('**File size was too large. Please try again.',style: TextStyle(color: Colors.red),),
                  SizedBox(
                    height: 10.h,
                  ),
                ],
              ),

              ButtonWithLoader(
                clickEnableColor: false,
                height: 50.h,
                width: double.infinity,
                onPressed: () async {},
                text: 'Continue',
              ),
            ]),
          ));
    });
  }

  BoxDecoration selectedBox() {
    return new BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.1),
        borderRadius: new BorderRadius.all(Radius.circular(10)));
  }

  BoxDecoration unSelectedBox() {
    return new BoxDecoration(
        borderRadius: new BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: Colors.grey));
  }
}
