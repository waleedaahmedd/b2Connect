import 'package:b2connect_flutter/model/locale/app_localization.dart';
import 'package:b2connect_flutter/model/utils/routes.dart';
import 'package:b2connect_flutter/view/widgets/appbar_with_back_icon_and_language.dart';
import 'package:b2connect_flutter/view/widgets/showOnWillPop.dart';
import 'package:b2connect_flutter/view_model/providers/job_provider.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';


class JobSearchScreen extends StatefulWidget {
  const JobSearchScreen({Key? key}) : super(key: key);

  @override
  _JobSearchScreenState createState() => _JobSearchScreenState();
}

class _JobSearchScreenState extends State<JobSearchScreen> {
  final focus = FocusNode();
  bool _connectedToInternet = true;
  var _controllers = ScrollController();
  final searchQueryController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controllers.addListener(_scrollListener);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    searchQueryController.dispose();
    super.dispose();
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
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 40.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        AppLocalizations.of(context)!
                            .translate('job_search')!,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 20.sp,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: EdgeInsets.zero,
                      child: TextField(
                        focusNode: focus,
                        // onChanged: onSearchTextChanged,
                        onSubmitted: setText,
                        controller: searchQueryController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 10),

                          suffixIcon: IconButton(
                              color: focus.hasFocus
                                  ? Theme.of(context).primaryColor
                                  : Colors.grey,
                              onPressed: () {
                                FocusScope.of(context).unfocus();
                                setText(searchQueryController.text);
                                //EasyLoading.show(status: 'Searching...');

                                /*setState(() async {
                                  */ /*  _categoryId = null;
                                  _sortBy = null;
                                  _filterBy = null;
                                  _filterByStock = null;
                                  _minPrice = null;
                                  _maxPrice = null;
                                  _pages = 1;
                                  _name = i.searchQueryController.text;
                                  //_offerList.clear();
                                  await getData();
                                  updateOfferList();*/ /*
                                });
*/
                                // _offerList.clear();
                                // getData();
                              },
                              icon: Icon(
                                Icons.search,
                              )),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                              color: Colors.grey,
                              //Theme.of(context).primaryColor,
                              width: 1,
                            ),
                          ),
                          focusColor: Theme.of(context).primaryColor,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                              color: Theme.of(context).primaryColor,
                              width: 1,
                            ),
                          ),

                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          hintText: AppLocalizations.of(context)!
                              .translate('search')!,
                          hintStyle: TextStyle(
                              fontSize: 14, decoration: TextDecoration.none),
                          fillColor: Colors.white,

                          // Color.fromRGBO(
                          //   243,
                          //   244,
                          //   246,
                          //   1,
                          // ),
                          filled: true,
                        ),
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            decoration: TextDecoration.none),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          navigationService.navigateTo(JobFilterScreenRoute);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Container(
                            child: Row(
                              // mainAxisSize: MainAxisSize.end,

                              children: [
                                ImageIcon(
                                  AssetImage('assets/images/filter_icon.png'),
                                  color: Theme.of(context).primaryColor,
                                  size: 17,
                                ),
                                // Icon(
                                //   Icons
                                //   size: 24,
                                //   color: Theme.of(context).primaryColor,
                                // ),
                                SizedBox(width: 10),
                                Text(
                                  "${AppLocalizations.of(context)!.translate('filter')!}",
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 14,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          i.sortOrderFilterClickIndex == 0? i.setSortOrderFilterClickIndex(1): i.setSortOrderFilterClickIndex(0);
                          i.jobList.clear();
                          i.page = 1;
                          await getData();
                          /*   Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    SortByScreen(widget.categoryId)),
                          );*/
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ImageIcon(
                                AssetImage('assets/images/new_list.png'),
                                color: Theme.of(context).primaryColor,
                                size: 17,
                              ),
                              SizedBox(width: 10),
                              Text(
                                i.sortOrderFilterClickIndex == 0?
                                AppLocalizations.of(context)!.translate('recent_posts')!
                               :  AppLocalizations.of(context)!.translate('old_posts')!,
                                // AppLocalizations.of(context)!.translate('newly_listed')!,
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 14,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Flexible(
                    child: AnimationLimiter(
                      child: ListView.builder(
                        controller: _controllers,
                        itemCount: i.jobList.length,
                        itemBuilder: (context, index) {
                          var date = new DateTime.fromMillisecondsSinceEpoch(i.jobList[index].createdAt!);
                          var format = new DateFormat.yMMMMd('en_US').add_jm();
                          var dateString = format.format(date);
                          return AnimationConfiguration.staggeredList(
                            position: index,
                            duration: const Duration(milliseconds: 1000),
                            child: ScaleAnimation(
                              scale: 1,
                              child: FlipAnimation(
                                child: GestureDetector(
                                  onTap: () {
                                    //navigationService.navigateTo(JobDetailScreenRoute);
                                    i.jobDetail = i.jobList[index];
                                   // i.setSelectedJobCheckBoxIndex(index);
                                    navigationService
                                        .navigateTo(JobDetailScreenRoute);
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
                                            color: Theme.of(context)
                                                .primaryColor)),
                                    margin: EdgeInsets.symmetric(vertical: 10),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          /*gradient:
                                              i.selectedJobCheckBoxIndex ==
                                                      index
                                                  ? gradientColor
                                                  : null,*/
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: Column(
                                          children: [
                                            Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  '$dateString',
                                                  style: TextStyle(
                                                      fontSize: 10.sp,
                                                      color:
                                                         /* i.selectedJobCheckBoxIndex ==
                                                                  index
                                                              ? Colors.white
                                                              : */Colors.grey
                                                                  .shade500),
                                                )),
                                            SizedBox(
                                              height: 10.h,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                    width: 100.w,
                                                    child: Text(
                                                      i.jobList[index].title!,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 12.sp,
                                                        /*  color:
                                                              i.selectedJobCheckBoxIndex ==
                                                                      index
                                                                  ? Colors.white
                                                                  : null*/),
                                                    )),
                                                Text(
                                                    i.jobList[index].expectedSalaryMin == i.jobList[index].expectedSalaryMax?
                                                    '${AppLocalizations.of(context)!.translate('salary')!}: AED ${i.jobList[index].expectedSalaryMin}':
                                                    '${AppLocalizations.of(context)!.translate('salary')!}: AED ${i.jobList[index].expectedSalaryMin} - ${i.jobList[index].expectedSalaryMax}',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 12.sp,
                                                        color: /*i.selectedJobCheckBoxIndex ==
                                                                index
                                                            ? Colors.white
                                                            :*/ Theme.of(context)
                                                                .primaryColor)),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5.h,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                    width: 150.w,
                                                    child: Text(
                                                        i.jobList[index]
                                                            .companyName!,
                                                        style: TextStyle(
                                                            fontSize: 12.sp,
                                                            color:
                                                               /* i.selectedJobCheckBoxIndex ==
                                                                        index
                                                                    ? Colors
                                                                        .white
                                                                    :*/ Colors
                                                                        .grey))),
                                              /*  Text('Not Specified',
                                                    style: TextStyle(
                                                        fontSize: 10.sp,
                                                        color: *//*i.selectedJobCheckBoxIndex ==
                                                                index
                                                            ? Colors.white
                                                            :*//* Theme.of(context)
                                                                .primaryColor)),*/
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10.h,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                    decoration: BoxDecoration(
                                                        color:
                                                            /*i.selectedJobCheckBoxIndex ==
                                                                    index
                                                                ? Colors.white
                                                                :*/ Theme.of(
                                                                        context)
                                                                    .primaryColor
                                                                    .withOpacity(
                                                                        0.2),
                                                        /*border: Border.all(
                                                          color: Theme.of(context).primaryColor,
                                                        ),*/
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    20))),
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 10.0,
                                                          vertical: 2.0),
                                                      child: Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.zero,
                                                            child: Icon(
                                                              Icons
                                                                  .location_on_outlined,
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor,
                                                              size: 15.h,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 5.w,
                                                          ),
                                                          Text(
                                                              i
                                                                  .jobList[
                                                                      index]
                                                                  .jobLocation!
                                                                  .cityId!,
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      10.sp,
                                                                  color: Theme.of(
                                                                          context)
                                                                      .primaryColor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500)),
                                                        ],
                                                      ),
                                                    )),
                                              /*  Visibility(
                                                    visible:
                                                        i.selectedJobCheckBoxIndex ==
                                                                index
                                                            ? true
                                                            : false,
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          color: i.selectedJobCheckBoxIndex ==
                                                                  index
                                                              ? Colors.white
                                                              : Theme.of(
                                                                      context)
                                                                  .primaryColor
                                                                  .withOpacity(
                                                                      0.2),
                                                          *//*border: Border.all(
                                                           color: Theme.of(context).primaryColor,
                                                         ),*//*
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          10))),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 5.0,
                                                                vertical: 7.0),
                                                        child: Text('Apply',
                                                            style: TextStyle(
                                                                fontSize: 10.sp,
                                                                color: Theme.of(
                                                                        context)
                                                                    .primaryColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                      ),
                                                    ))*/
                                                /* Text('${i.jobList![index].type}'),*/
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
            Visibility(
              visible: i.isJobListEmpty,
              child: Container(
                height: double.infinity,
                child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/error.jpg',
                           height: 200.h,
                        ),
                        Text('Sorry no jobs Found')
                      ],
                    ),),
              ),
            ),
            /* Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomButton(
                    height: 50.h,
                    width: double.infinity,
                    onPressed: () async {
                     // navigationService.navigateTo(JobDetailScreenRoute);
                      //_paymentPlanBottomSheet(context);
                    */ /*   EasyLoading.show(status: 'Please Wait');
                                await context
                                    .read<PayByProvider>()
                                    .payByOffersOrder(context);*/ /*
                      //   navigationService.navigateTo(ShippingScreenRoute);

                      //navigationService.navigateTo(JobSearchScreenRoute);
                    },
                    text: 'Continue',
                  ),
                ],
              ),
            )*/
          ],
        ),
      );
    });
  }

  _scrollListener() {
    if ((_controllers.position.pixels ==
            _controllers.position.maxScrollExtent) &&
        (context.read<JobProvider>().jobPerPageList.isNotEmpty)) {
      EasyLoading.show(
          status: AppLocalizations.of(context)!.translate('please_wait')!);
      if (mounted) {
        setState(() {
          context.read<JobProvider>().page += 1;
          // print('page: $_pages');
          Future.delayed(Duration.zero, () async {
            await getData();
            // addMoreInOfferList();
          });
        });
      }
    }
  }

  getData() async {
    EasyLoading.show(status: 'Please Wait...');
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      await context.read<JobProvider>().getJobList();
    } else {
      setState(() {
        _connectedToInternet = false;
      });
    }
  }

  setText(String text) async {
    EasyLoading.show(status: 'Searching...');

    if (text.isEmpty) {
      await context.read<JobProvider>().clearJobProvider();

      context.read<JobProvider>().jobList.clear();
      // _offerList.clear();
      getData();
      return;
    } else {
      await context.read<JobProvider>().clearJobProvider();
      context.read<JobProvider>().jobList.clear();
      context.read<JobProvider>().title = searchQueryController.text;
      await getData();
    }
  }
}
