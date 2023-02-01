import 'package:b2connect_flutter/view/widgets/appbar_with_back_icon_and_language.dart';
import 'package:b2connect_flutter/view/widgets/custom_buttons/gradiant_color_button.dart';
import 'package:b2connect_flutter/view_model/providers/job_provider.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class JobFilterScreen extends StatefulWidget {
  const JobFilterScreen({Key? key}) : super(key: key);

  @override
  _JobFilterScreenState createState() => _JobFilterScreenState();
}

class _JobFilterScreenState extends State<JobFilterScreen> {
  late RangeValues _currentRangeValues;
  bool _connectedToInternet = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<JobProvider>().jobFilterLocationsList = [
      'All',
      'Dubai',
      'Abu-Dhabi',
      'Al-Ain',
      'Sharjah',
      'Ajman',
      'Ras Al-Khaimah',
      'Fujairah',
      'Umm Al-Quwain'
    ];
    context.read<JobProvider>().jobFilterSortOrderList = [
      'Newest',
      'Oldest',
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<JobProvider>(builder: (context, i, _) {
      _currentRangeValues = RangeValues(
        i.salaryMin.toDouble(),
        i.salaryMax.toDouble(),
      );
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBarWithBackIconAndLanguage(
          icon: Icons.close,
          onTapIcon: () {
            Navigator.pop(context);
          },
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Stack(
            children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Filters",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 27.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          i.clearJobProvider();
                          setState(() {
                          });
                          //clearAll();
                        },
                        child: Text(
                          "Clear All",
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Sort By",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Wrap(
                          spacing: 20.w,
                          children: List<Widget>.generate(i.jobFilterSortOrderList.length,
                              // place the length of the array here
                                  (int index) {
                                return ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary:
                                        index == i.sortOrderFilterClickIndex
                                            ? Color.fromRGBO(255, 235, 242, 1)
                                            : Colors.white),
                                    onPressed: () async {

                                      i.setSortOrderFilterClickIndex(index);
                                      /* i.handleAvailabilityTap(
                                      index, _availabilityList[index]['id']);
                                  setState(() {
                                    _filterByStock = i.filterData.filterByStock;
                                  });
                                  EasyLoading.show(
                                      status: AppLocalizations.of(context)!
                                          .translate('please_wait')!);
                                  await getOfferDetail(i.filterData);
                                  EasyLoading.dismiss();*/
                                    },
                                    child: Text(
                                      i.jobFilterSortOrderList[index],
                                      style: TextStyle(
                                          color: index ==
                                              i.sortOrderFilterClickIndex
                                              ? Theme.of(context).primaryColor
                                              : Color(0xFF545454)),
                                    ));
                              }).toList(),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),

                        Text(
                          "Salary Range",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.grey.shade200,
                                ),
                                //width: width * 0.25,
                                padding: EdgeInsets.only(
                                    left: 20, right: 10, top: 20, bottom: 20),
                                child: Text(
                                  'AED ${_currentRangeValues.start.round().toString()}',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 20.w,
                            ),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.grey.shade200,
                                ),
                                // width: width * 0.25,
                                padding: EdgeInsets.only(
                                    left: 20, right: 10, top: 20, bottom: 20),
                                child: Text(
                                  'AED ${_currentRangeValues.end.round().toString()}',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                              activeTrackColor: Theme.of(context).primaryColor,
                              inactiveTrackColor: Colors.grey.shade200,
                              trackShape: RoundedRectSliderTrackShape(),
                              trackHeight: 4.0,
                              thumbShape:
                                  RoundSliderThumbShape(enabledThumbRadius: 12.0),
                              thumbColor: Theme.of(context).primaryColor,
                              overlayShape:
                                  RoundSliderOverlayShape(overlayRadius: 28.0),
                              tickMarkShape: RoundSliderTickMarkShape(),
                              activeTickMarkColor: Theme.of(context).primaryColor,
                              inactiveTickMarkColor: Colors.grey.shade200,
                              valueIndicatorShape:
                                  PaddleSliderValueIndicatorShape(),
                              valueIndicatorColor: Theme.of(context).primaryColor,
                              valueIndicatorTextStyle: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            child: RangeSlider(
                              values: _currentRangeValues,
                              min: 0,
                              max: 50000,
                              divisions: 26,
                              /*labels: RangeLabels(
                                            _currentRangeValues.start.round().toString(),
                                            _currentRangeValues.end.round().toString(),
                                          ),*/

                              onChanged: (RangeValues values) {
                                setState(() {
                                  _currentRangeValues = values;
                                  i.salaryMin = _currentRangeValues.start.toInt();
                                  i.salaryMax = _currentRangeValues.end.toInt();
                                  /* minPrice = i.filterData.minimumPrice;
                                                  maxPrice = i.filterData.maximumPrice;*/
                                });
                              },
                              /*onChangeEnd: (RangeValues values) {
                                getData();
                              },*/
                            )),
                        Padding(
                          padding: EdgeInsets.only(left: 15.0, right: 15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Min",
                                style: TextStyle(
                                  color: Color(0xFF545454),
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Max",
                                style: TextStyle(
                                  color: Color(0xFF545454),
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Text(
                          "Location",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Wrap(
                          spacing: 20.w,
                          children: List<Widget>.generate(i.jobFilterLocationsList.length,
                              // place the length of the array here
                              (int index) {
                            return ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary:
                                        index == i.locationFilterClickIndex
                                            ? Color.fromRGBO(255, 235, 242, 1)
                                            : Colors.white),
                                onPressed: () async {

                                  i.setLocationFilterClickIndex(index);
                                  index == 0? i.location = '': i.location = i.jobFilterLocationsList[index];


                                 /* i.handleAvailabilityTap(
                                      index, _availabilityList[index]['id']);
                                  setState(() {
                                    _filterByStock = i.filterData.filterByStock;
                                  });
                                  EasyLoading.show(
                                      status: AppLocalizations.of(context)!
                                          .translate('please_wait')!);
                                  await getOfferDetail(i.filterData);
                                  EasyLoading.dismiss();*/
                                },
                                child: Text(
                                  i.jobFilterLocationsList[index],
                                  style: TextStyle(
                                      color: index ==
                                          i.locationFilterClickIndex
                                          ? Theme.of(context).primaryColor
                                          : Color(0xFF545454)),
                                ));
                          }).toList(),
                        ),


                      ],
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomButton(
                    height: 50.h,
                    width: double.infinity,
                    onPressed: () async {
                      i.jobList.clear();
                      i.page = 1;
                      await getData();
                      Navigator.pop(context);

                      // navigationService.navigateTo(JobDetailScreenRoute);
                      //_paymentPlanBottomSheet(context);
                     /* EasyLoading.show(status: 'Please Wait');
                      await context
                          .read<PayByProvider>()
                          .payByOffersOrder(context);*/
                      //   navigationService.navigateTo(ShippingScreenRoute);

                      //navigationService.navigateTo(JobSearchScreenRoute);
                    },
                    text: 'Show Jobs',
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
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
}
