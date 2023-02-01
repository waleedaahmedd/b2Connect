import 'package:b2connect_flutter/model/locale/app_localization.dart';
import 'package:b2connect_flutter/view/widgets/appbar_with_back_icon_and_language.dart';
import 'package:b2connect_flutter/view/widgets/custom_buttons/gradiant_color_button.dart';
import 'package:b2connect_flutter/view/widgets/showOnWillPop.dart';
import 'package:b2connect_flutter/view_model/providers/job_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart' as ul;
import 'package:provider/provider.dart';

class JobDetailScreen extends StatefulWidget {
  const JobDetailScreen({Key? key}) : super(key: key);

  @override
  State<JobDetailScreen> createState() => _JobDetailScreenState();
}

class _JobDetailScreenState extends State<JobDetailScreen> {
  String? dateString;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var date = new DateTime.fromMillisecondsSinceEpoch(
        context.read<JobProvider>().jobDetail!.createdAt!);
    var format = new DateFormat.yMMMMd('en_US').add_jm();
    dateString = format.format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<JobProvider>(builder: (context, i, _) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBarWithBackIconAndLanguage(
          onTapIcon: () {
            navigationService.closeScreen();
          },
        ),
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 100.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 30.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            AppLocalizations.of(context)!
                                .translate('job_detail')!,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 20.sp,
                            ),
                          ),
                        ),
                      ),
                      Card(
                        elevation: 10,
                        shadowColor: Theme.of(context).primaryColor,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                child: Center(
                                  child: i.jobDetail!.companyLogo == ""
                                      ? Image.asset(
                                          'assets/images/not_found1.png',
                                          // height: 100.h,
                                        )
                                      : CachedNetworkImage(
                                          // width: 100.w,
                                          // height: 100.h,
                                          imageUrl: i.jobDetail!.companyLogo!,
                                          height: 50.h,

                                          placeholder: (context, url) =>
                                              Image.asset(
                                            'assets/images/placeholder1.png',
                                          ),
                                          errorWidget: (context, url, error) =>
                                              Image.asset(
                                            'assets/images/not_found1.png',
                                            // height: 100,
                                          ),
                                          fit: BoxFit.fill,
                                        ),
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      '${i.jobDetail!.title}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400),
                                    ),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    Text(
                                      '${i.jobDetail!.companyName}',
                                      style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          //fontWeight: FontWeight.w400,
                                          fontSize: 12.sp),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Divider(
                        height: 2.h,
                        color: Theme.of(context).primaryColor,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.translate('salary')!,
                            style: TextStyle(
                              color: Colors.black,
                              //fontWeight: FontWeight.w400,
                              fontSize: 12.sp,
                            ),
                          ),
                          Text(
                            i.jobDetail!.expectedSalaryMin ==
                                    i.jobDetail!.expectedSalaryMax
                                ? 'AED ${i.jobDetail!.expectedSalaryMin}'
                                : 'AED ${i.jobDetail!.expectedSalaryMin} - ${i.jobDetail!.expectedSalaryMax}',
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              //fontWeight: FontWeight.w400,
                              fontSize: 12.sp,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      /*  Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Type',
                            style: TextStyle(
                              color: Colors.black,
                              //fontWeight: FontWeight.w400,
                              fontSize: 12.sp,
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.2),
                                */ /*  border: Border.all(
                                  color: Theme.of(context).primaryColor,
                                ),*/ /*
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 5.0),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.watch_later_outlined,
                                    color: Theme.of(context).primaryColor,
                                    size: 15.h,
                                  ),
                                  Text(
                                    ' Not Specified',
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),*/
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppLocalizations.of(context)!
                                .translate('location')!,
                            style: TextStyle(
                              color: Colors.black,
                              //fontWeight: FontWeight.w400,
                              fontSize: 12.sp,
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.2),
                                /*  border: Border.all(
                                  color: Theme.of(context).primaryColor,
                                ),*/
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 5.0),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.location_on_outlined,
                                    color: Theme.of(context).primaryColor,
                                    size: 15.h,
                                  ),
                                  Text(
                                    '${i.jobDetail!.jobLocation!.cityId}',
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.translate('date')!,
                            style: TextStyle(
                              color: Colors.black,
                              //fontWeight: FontWeight.w400,
                              fontSize: 12.sp,
                            ),
                          ),
                          Text(
                            '$dateString',
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              //fontWeight: FontWeight.w400,
                              fontSize: 12.sp,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Divider(
                        height: 2.h,
                        color: Theme.of(context).primaryColor,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          AppLocalizations.of(context)!
                              .translate('job_description')!,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 15.sp,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '${i.jobDetail!.jobDescription}',
                          style: TextStyle(
                            color: Colors.black,
                            //fontWeight: FontWeight.w400,
                            fontSize: 12.sp,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      /* Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'You Might Also Like',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 15.sp,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),*/
                      /*  ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: i.jobList!.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              navigationService
                                  .navigateTo(JobDetailScreenRoute);
                              //i.setSelectedJobCheckBoxIndex(index);
                            },
                            child: Card(
                              //color: i.selectedJobCheckBoxIndex == index? Colors.green: Colors.yellow,
                              elevation: 10,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  side: BorderSide(
                                      width: 1.w,
                                      color: Theme.of(context).primaryColor)),
                              margin: EdgeInsets.symmetric(vertical: 10),
                              child: Container(
                                */ /* decoration: BoxDecoration(
                                    gradient: i.selectedJobCheckBoxIndex == index?
                                    gradientColor: null,
                                    borderRadius:
                                    BorderRadius.circular(10)),*/ /*
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Column(
                                    children: [
                                      Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            '${i.jobList![index].date}',
                                            style: TextStyle(
                                                fontSize: 10.sp,
                                                color: */ /*i.selectedJobCheckBoxIndex == index? Colors.white:*/ /* Colors
                                                    .grey.shade500),
                                          )),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                              width: 150.w,
                                              child: Text(
                                                i.jobList![index].name,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 12.sp,
                                                    color: */ /*i.selectedJobCheckBoxIndex == index? Colors.white:*/ /* null),
                                              )),
                                          Text(
                                              'Salary: ${i.jobList![index].salary}',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12.sp,
                                                  color: */ /*i.selectedJobCheckBoxIndex == index? Colors.white:*/ /* Theme
                                                          .of(context)
                                                      .primaryColor)),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                              width: 150.w,
                                              child: Text(
                                                  i.jobList![index]
                                                      .organisation,
                                                  style: TextStyle(
                                                      fontSize: 12.sp,
                                                      color: */ /*i.selectedJobCheckBoxIndex == index? Colors.white:*/ /* Colors
                                                          .grey))),
                                          Text('${i.jobList![index].type}',
                                              style: TextStyle(
                                                  fontSize: 10.sp,
                                                  color: */ /* i.selectedJobCheckBoxIndex == index? Colors.white:*/ /* Theme
                                                          .of(context)
                                                      .primaryColor)),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                              decoration: BoxDecoration(
                                                  color: */ /* i.selectedJobCheckBoxIndex == index? Colors.white:*/ /* Theme
                                                          .of(context)
                                                      .primaryColor
                                                      .withOpacity(0.2),
                                                  */ /*border: Border.all(
                                                    color: Theme.of(context).primaryColor,
                                                  ),*/ /*
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(20))),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10.0,
                                                        vertical: 2.0),
                                                child: Row(
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.zero,
                                                      child: Icon(
                                                        Icons
                                                            .location_on_outlined,
                                                        color: Theme.of(context)
                                                            .primaryColor,
                                                        size: 15.h,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 5.w,
                                                    ),
                                                    Text(i.jobList![index].city,
                                                        style: TextStyle(
                                                            fontSize: 10.sp,
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500)),
                                                  ],
                                                ),
                                              )),
                                          */ /* Visibility(
                                              visible: i.selectedJobCheckBoxIndex == index? true : false,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: i.selectedJobCheckBoxIndex == index? Colors.white: Theme.of(context).primaryColor.withOpacity(0.2),
                                                    border: Border.all(
                                                      color: Theme.of(context).primaryColor,
                                                    ),
                                                    borderRadius: BorderRadius.all(Radius.circular(10))
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 7.0),
                                                  child: Text('Apply',style: TextStyle(fontSize: 10.sp,color: Theme.of(context).primaryColor,fontWeight: FontWeight.w400)),
                                                ),
                                              ))*/ /*
                                          */ /* Text('${i.jobList![index].type}'),*/ /*
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      )*/
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomButton(
                    height: 50.h,
                    width: double.infinity,
                    onPressed: () async {
                      // EasyLoading.show(status: 'Loading..');
                      //    print(i.jobDetail!.link);
                      //  await  ul.launch(i.jobDetail!.link!.trim(),);

                      var url = '${i.jobDetail!.link}';
                      if (await ul.canLaunch(url)) {
                        await ul.launch(url);
                      } else {
                        throw 'Could not launch $url';
                      }

                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => WebViewPage(
                      //       url:
                      //           'https://skillbee.com/?referral=b2Apply',
                      //       //'${i.jobDetail!.link}',
                      //       title: '${i.jobDetail!.title}',
                      //     ),
                      //   ),
                      // );
                      //_paymentPlanBottomSheet(context);
                      /* EasyLoading.show(status: 'Please Wait');
                                await context
                                    .read<PayByProvider>()
                                    .payByOffersOrder(context); */
                      //   navigationService.navigateTo(ShippingScreenRoute);

                      //navigationService.navigateTo(JobSearchScreenRoute);
                    },
                    text: AppLocalizations.of(context)!.translate('apply_now')!,
                  ),
                ],
              ),
            )
          ],
        ),
      );
    });
  }
}
