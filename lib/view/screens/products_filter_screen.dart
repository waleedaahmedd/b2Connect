import 'package:b2connect_flutter/model/locale/app_localization.dart';
import 'package:b2connect_flutter/model/models/filter_model.dart';
import 'package:b2connect_flutter/view/screens/view_all_offers_screen.dart';
import 'package:b2connect_flutter/view/widgets/appbar_with_back_icon_and_language.dart';
import 'package:b2connect_flutter/view_model/providers/offers_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ProductsFilterScreen extends StatefulWidget {
  const ProductsFilterScreen(this.categoryId, {Key? key}) : super(key: key);
  final categoryId;

  @override
  _ProductsFilterScreenState createState() => _ProductsFilterScreenState();
}

class _ProductsFilterScreenState extends State<ProductsFilterScreen> {


  late RangeValues _currentRangeValues;
  String? _sortBy;
  String? _filterBy;
  String? _filterByStock;

  // String? colorValue;

  // int? minPrice;
  // int? maxPrice;

  List<Map<String, dynamic>> _sortByList = [
    {"id": "1", "title": "Default"},
    {"id": "2", "title": "Price - Low to High"},
    {"id": "3", "title": "Price - High to Low"},
    {"id": "4", "title": "Name A - Z"},
    {"id": "5", "title": "Newest First"},
  ];
  List<Map<String, dynamic>> _availabilityList = [
    {"id": "1", "title": "All"},
    {"id": "2", "title": "In-Stock"},
    {"id": "3", "title": "On-Back-Order"},
  ];

  // List<Map<String, dynamic>> brandsList = [
  //   {"id": "1", "title": "Xiaomi"},
  //   {"id": "2", "title": "OnePlus"},
  //   {"id": "3", "title": "Oppo"},
  //   {"id": "4", "title": "Apple"},
  //   {"id": "5", "title": "Samsung"},
  // ];
  // List<Map<String, dynamic>> ramlist = [
  //   {"id": "1", "title": "6 GB"},
  //   {"id": "2", "title": "8 GB"},
  // ];

  // List<Map<String, dynamic>> storagelist = [
  //   {"id": "1", "title": "32 GB"},
  //   {"id": "2", "title": "64 GB"},
  //   {"id": "3", "title": "128 GB"},
  //   {"id": "4", "title": "256 GB"},
  //   {"id": "5", "title": "512 GB"},
  // ];

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery
        .of(context)
        .size
        .height;
    final width = MediaQuery
        .of(context)
        .size
        .width;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBarWithBackIconAndLanguage(
          icon: Icons.close, onTapIcon: () {
          Provider
              .of<OffersProvider>(context, listen: false)
              .clearFilterData(catId: widget.categoryId);
          Navigator.pop(context);
        },


        ),
        body: Consumer<OffersProvider>(builder: (context, i, _) {
          _currentRangeValues = RangeValues(
            i.filterData.minimumPrice == null ? 0 : i.filterData.minimumPrice!
                .toDouble(),
            i.filterData.maximumPrice == null ? 2000 : i.filterData
                .maximumPrice!.toDouble(),
          );
          return WillPopScope(
            onWillPop: () async {
              await i.clearFilterData(catId: widget.categoryId);
              Navigator.pop(context, false);
              return Future.value(false);
            },
            child: Container(
              padding: EdgeInsets.all(height * 0.020),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Filters",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 27.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                         await i.clearFilterData(catId: widget.categoryId);
                          /*setState(() {

                          });*/
                          //clearAll();
                        },
                        child: Text(
                          "Clear All",
                          style: TextStyle(
                            color: Theme
                                .of(context)
                                .primaryColor,
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
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                         /* Text(
                            "Sort By",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: height * 0.020,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: height * 0.020,
                          ),
                          Wrap(
                            spacing: width * 0.040,
                            children: List<Widget>.generate(_sortByList.length,
                                // place the length of the array here
                                    (int index) {
                                  return ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: index ==
                                              i.filterData.sortByListIndex
                                              ? Color.fromRGBO(255, 235, 242, 1)
                                              : Colors.white),
                                      onPressed: () async {
                                        i.handleSortByTap(
                                            index, _sortByList[index]['id']);
                                        setState(() {
                                          _sortBy = i.filterData.sortBy;
                                        });
                                        *//*handleSortByTap(
                                        index, sortByList[index]['id']);*//*
                                        EasyLoading.show(
                                            status: AppLocalizations.of(context)!.translate('please_wait')!);
                                        await getOfferDetail(i.filterData);
                                        EasyLoading.dismiss();
                                      },
                                      child: Text(
                                        _sortByList[index]['title'],
                                        style: TextStyle(
                                            decoration: TextDecoration.none,
                                            color: index ==
                                                i.filterData.sortByListIndex
                                                ? Theme
                                                .of(context)
                                                .primaryColor
                                                : Color(0xFF545454)),
                                      ));
                                }).toList(),
                          ),
                          SizedBox(
                            height: 10,
                          ),*/
                          Text(
                            "Price Range",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: height * 0.020,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: height * 0.020,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.grey.shade200,
                                  ),
                                  //width: width * 0.25,
                                  padding: EdgeInsets.only(
                                      left: 20,
                                      right: width * 0.010,
                                      top: height * 0.020,
                                      bottom: height * 0.020),
                                  child: Text(
                                    'AED ${_currentRangeValues.start.round()
                                        .toString()}',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: height * 0.015,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: width * 0.010,
                              ),
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.grey.shade200,
                                  ),
                                  // width: width * 0.25,
                                  padding: EdgeInsets.only(
                                      left: 20,
                                      right: width * 0.010,
                                      top: height * 0.020,
                                      bottom: height * 0.020),
                                  child: Text(
                                    'AED ${_currentRangeValues.end.round()
                                        .toString()}',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: height * 0.015,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: height * 0.020,
                          ),
                          SliderTheme(
                              data: SliderTheme.of(context).copyWith(
                                activeTrackColor: Theme
                                    .of(context)
                                    .primaryColor,
                                inactiveTrackColor: Colors.grey.shade200,
                                trackShape: RoundedRectSliderTrackShape(),
                                trackHeight: 4.0,
                                thumbShape: RoundSliderThumbShape(
                                    enabledThumbRadius: 12.0),
                                thumbColor: Theme
                                    .of(context)
                                    .primaryColor,
                                overlayShape:
                                RoundSliderOverlayShape(overlayRadius: 28.0),
                                tickMarkShape: RoundSliderTickMarkShape(),
                                activeTickMarkColor:
                                Theme
                                    .of(context)
                                    .primaryColor,
                                inactiveTickMarkColor: Colors.grey.shade200,
                                valueIndicatorShape:
                                PaddleSliderValueIndicatorShape(),
                                valueIndicatorColor:
                                Theme
                                    .of(context)
                                    .primaryColor,
                                valueIndicatorTextStyle: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              child: RangeSlider(
                                values: _currentRangeValues,
                                min: 0,
                                max: 2000,
                                divisions: 26,
                                /*labels: RangeLabels(
                              _currentRangeValues.start.round().toString(),
                              _currentRangeValues.end.round().toString(),
                            ),*/

                                onChanged: (RangeValues values) {
                                  setState(() {
                                    _currentRangeValues = values;
                                    i.filterData.minimumPrice =
                                        _currentRangeValues.start.toInt();
                                    i.filterData.maximumPrice =
                                        _currentRangeValues.end.toInt();
                                    /* minPrice = i.filterData.minimumPrice;
                                    maxPrice = i.filterData.maximumPrice;*/
                                  });
                                },
                                onChangeEnd: (RangeValues values) {
                                  getOfferDetail(i.filterData);
                                },
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
                                    fontSize: height * 0.017,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "Max",
                                  style: TextStyle(
                                    color: Color(0xFF545454),
                                    fontSize: height * 0.017,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: height * 0.030,
                          ),
                          Text(
                            "Availability",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: height * 0.020,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: height * 0.020,
                          ),
                          Wrap(
                            spacing: width * 0.040,
                            children:
                            List<Widget>.generate(_availabilityList.length,
                                // place the length of the array here
                                    (int index) {
                                  return ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: index ==
                                              i.filterData.availabilityListIndex
                                              ? Color.fromRGBO(255, 235, 242, 1)
                                              : Colors.white),
                                      onPressed: () async {
                                        i.handleAvailabilityTap(
                                            index,
                                            _availabilityList[index]['id']);
                                        setState(() {
                                          _filterByStock =
                                              i.filterData.filterByStock;
                                        });
                                        EasyLoading.show(
                                            status: AppLocalizations.of(context)!.translate('please_wait')!);
                                        await getOfferDetail(i.filterData);
                                        EasyLoading.dismiss();
                                      },
                                      child: Text(
                                        _availabilityList[index]['title'],
                                        style: TextStyle(
                                            color: index ==
                                                i.filterData
                                                    .availabilityListIndex
                                                ? Theme
                                                .of(context)
                                                .primaryColor : Color(
                                                0xFF545454)),
                                      ));
                                }).toList(),
                          ),
                          Wrap(
                            spacing: width * 0.040,
                            children: List<Widget>.generate(
                                i.offersData!.filterMeta.attributeFilterMeta!
                                    .length,
                                // place the length of the array here
                                    (int index) {
                                  return i.offersData!.filterMeta
                                      .attributeFilterMeta![index]
                                      .attributeName == "Color" ?
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,

                                    children: [
                                      SizedBox(
                                        height: height * 0.030,
                                      ),
                                      Text(
                                        i.offersData!.filterMeta
                                            .attributeFilterMeta![index]
                                            .attributeName
                                            .toString(),
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: height * 0.020,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        height: height * 0.020,
                                      ),
                                      Card(
                                        color: i.filterData.colors == null? Colors.white : Color.fromRGBO(
                                            255, 235, 242, 1),
                                        semanticContainer: true,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10.0),
                                        ),
                                        elevation: 2,
                                        child: DropdownButtonHideUnderline(
                                          child: ButtonTheme(
                                            alignedDropdown: true,
                                            child: DropdownButton<String>(
                                              hint: new Text("Select Color",style: TextStyle(
                                                color: i.filterData.colors == null? Color(
                                                    0xFF545454) : Theme
                                                    .of(context)
                                                    .primaryColor, fontWeight: FontWeight.w500,fontSize: 15
                                              ),),
                                              value:  i.filterData.colors,
                                              onChanged: (String? newValue) {
                                                setState(() async {
                                                  i.filterData.colors = newValue;
                                                  await i.handleAttributeTap(
                                                    i
                                                        .offersData!
                                                        .filterMeta
                                                        .attributeFilterMeta![index]
                                                        .attributeId
                                                        .toString(),
                                                    i.filterData.colors!,
                                                  );
                                                  _filterBy =
                                                      i.filterData.filterBy;
                                                  EasyLoading.show(
                                                      status: AppLocalizations.of(context)!.translate('please_wait')!);
                                                  await getOfferDetail(
                                                      i.filterData);
                                                  EasyLoading.dismiss();
                                                });
                                              },
                                              items: i.offersData!
                                                  .filterMeta
                                                  .attributeFilterMeta![index]
                                                  .options!
                                                  .map((options) {
                                                return new DropdownMenuItem<
                                                    String>(alignment: Alignment.center,
                                                  value: options.value,
                                                  child: new Text(
                                                      options.value.toString(),
                                                      style: new TextStyle(
                                                          color: i.filterData.colors == null? Color(
                                                              0xFF545454) : Theme
                                                              .of(context)
                                                              .primaryColor, fontWeight: FontWeight.w500,fontSize: 15
                                                      ),),
                                                );
                                              }).toList(),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ) : Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,

                                    children: [
                                      SizedBox(
                                        height: height * 0.030,
                                      ),
                                      Text(
                                        i.offersData!.filterMeta
                                            .attributeFilterMeta![index]
                                            .attributeName
                                            .toString(),
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: height * 0.020,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        height: height * 0.020,
                                      ),
                                      Wrap(
                                        spacing: width * 0.040,
                                        children: List<Widget>.generate(
                                            i
                                                .offersData!
                                                .filterMeta
                                                .attributeFilterMeta![index]
                                                .options!
                                                .length,
                                            // place the length of the array here
                                                (int optionIndex) {
                                              return ElevatedButton(
                                                  style: ElevatedButton
                                                      .styleFrom(
                                                      primary: i.filterData
                                                          .addAttributeId
                                                          .contains(i
                                                          .offersData!
                                                          .filterMeta
                                                          .attributeFilterMeta![
                                                      index]
                                                          .attributeId
                                                          .toString()) &&
                                                          (i.filterData
                                                              .listOfAllOptions
                                                              .any(
                                                                  (item) =>
                                                                  item.contains(
                                                                      i
                                                                          .offersData!
                                                                          .filterMeta
                                                                          .attributeFilterMeta![index]
                                                                          .options![optionIndex]
                                                                          .value
                                                                          .toString())))
                                                          ? Color.fromRGBO(
                                                          255, 235, 242, 1)
                                                          : Colors.white),
                                                  onPressed: () async {
                                                    await i.handleAttributeTap(
                                                      i
                                                          .offersData!
                                                          .filterMeta
                                                          .attributeFilterMeta![index]
                                                          .attributeId
                                                          .toString(),
                                                      i
                                                          .offersData!
                                                          .filterMeta
                                                          .attributeFilterMeta![index]
                                                          .options![optionIndex]
                                                          .value
                                                          .toString(),
                                                    );
                                                    _filterBy =
                                                        i.filterData.filterBy;
                                                    EasyLoading.show(
                                                        status: AppLocalizations.of(context)!.translate('please_wait')!);
                                                    await getOfferDetail(
                                                        i.filterData);
                                                    EasyLoading.dismiss();
                                                  },
                                                  child: Text(
                                                    i
                                                        .offersData!
                                                        .filterMeta
                                                        .attributeFilterMeta![index]
                                                        .options![optionIndex]
                                                        .value
                                                        .toString(),
                                                    style: TextStyle(
                                                        color: i.filterData
                                                            .addAttributeId
                                                            .contains(i
                                                            .offersData!
                                                            .filterMeta
                                                            .attributeFilterMeta![
                                                        index]
                                                            .attributeId
                                                            .toString()) &&
                                                            (i.filterData
                                                                .listOfAllOptions
                                                                .any(
                                                                    (item) =>
                                                                    item
                                                                        .contains(
                                                                        i
                                                                            .offersData!
                                                                            .filterMeta
                                                                            .attributeFilterMeta![index]
                                                                            .options![optionIndex]
                                                                            .value
                                                                            .toString())))
                                                            ? Theme
                                                            .of(context)
                                                            .primaryColor
                                                            : Color(
                                                            0xFF545454)),
                                                  ));
                                            }).toList(),
                                      ),
                                    ],
                                  );
                                }).toList(),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: height * 0.060,
                    child: ElevatedButton(
                      onPressed: () async {
                        /*setState(() {

                        });*/
                        var count = 0;
                        EasyLoading.show(status: AppLocalizations.of(context)!.translate('please_wait')!);
                        i.searchQueryController.clear();
                        i.filterData.sortByListIndex = 0;

                        await getOfferDetail(i.filterData).then((value) {
                          Navigator.popUntil(context, (route) {
                            return count++ == 2;
                          });
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ViewAllOffersScreen(
                                      10,
                                        sortBy: i.filterData.sortBy,
                                        categoryId: widget.categoryId,
                                        filterBy: i.filterData.filterBy,
                                        filterByStock: i.filterData.filterByStock,
                                        minPrice: i.filterData.minimumPrice,
                                        maxPrice: i.filterData.maximumPrice)),
                          );
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        textStyle: TextStyle(
                            fontSize: MediaQuery
                                .of(context)
                                .size
                                .height * 0.03,
                            fontWeight: FontWeight.w500),
                        primary: Theme
                            .of(context)
                            .primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      child: new Text(
                        "Show ${i.offersData!.offerCount.toString()} Products",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: height * 0.025,
                          //fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }));
  }

/*  getData() {
    getOffers =
        Provider.of<OffersProvider>(context, listen: false).getOfferData;

    _currentRangeValues = RangeValues(
        getOffers == null ? 10 : getOffers!.filterMeta.minPrice!.toDouble(),
        getOffers == null ? 100 : getOffers!.filterMeta.maxPrice!.toDouble());
  }*/

  /*void handleSortByTap(int index, sortByListId) {
    setState(() {
      _sortByListIndex = index;
      if (sortByListId == '2') {
        sortBy = 'PRICE_LOW_TO_HIGH';
      } else if (sortByListId == '3') {
        sortBy = 'PRICE_HIGH_TO_LOW';
      } else if (sortByListId == '4') {
        sortBy = 'NAME_A_Z';
      } else if (sortByListId == '5') {
        sortBy = 'NEWEST';
      } else {
        sortBy = null;
      }
    });
  }*/

  /*void handleAvailabilityTap(int index, availabilityListId) {
    setState(() {
      _availabilityListIndex = index;
      if (availabilityListId == '2') {
        filterByStock = 'IN_STOCK';
      } else if (availabilityListId == '3') {
        sortBy = 'PRICE_HIGH_TO_LOW';
      } else {
        filterByStock = null;
      }
    });
  }*/

  Future<void> getOfferDetail(FilterData filterData) async {
    await Provider.of<OffersProvider>(context, listen: false).getOffers(
        sortBy: _sortBy,
        categoryId: widget.categoryId,
        minPrice: filterData.minimumPrice,
        maxPrice: filterData.maximumPrice,
        filterBy: _filterBy,
        filterByStock: _filterByStock,
        perPage: 10);
  }

/*void clearAll() {
   // addAttributeId.clear();
   // listOfAllOptions.clear();

    setState(() async {
     // _availabilityListIndex = 0;
   //   _sortByListIndex = 0;
      _currentRangeValues = RangeValues(0, 2000);
      filterBy = null;
      EasyLoading.show(
          status: 'Please Wait...');
      await getOfferDetail();
      EasyLoading.dismiss();
    });
  }*/

/* void handleAttributeTap(String attributeId, String optionsName) {
    if (addAttributeId.contains(attributeId)) {
      var idIndex =
          addAttributeId.indexWhere((element) => element == attributeId);
      print(idIndex);

      List<String> listOnIndex = listOfAllOptions[idIndex];

      if (listOfAllOptions[idIndex].contains(optionsName)) {
        addOptions.clear();

        addOptions.addAll(listOnIndex);

        addOptions.removeWhere((element) => element == optionsName);

        listOfAllOptions.removeAt(idIndex);

        listOfAllOptions.insert(idIndex, addOptions.toList(growable: true));

        var optionsList = addOptions.join(';');

        if (optionsList == "") {
          addAttributeId.removeAt(idIndex);
          addAttribute.removeAt(idIndex);
          print(addAttribute.join(','));

          setState(() {
            filterBy =
                addAttribute.join(',') == "" ? null : addAttribute.join(',');
          });
        } else {
          var idWithOptions = '$attributeId:$optionsList';

          //addAttributeId.indexWhere((element) => element == attributeId);

          addAttribute[idIndex] = idWithOptions;

          //  addAttribute.removeAt(idIndex);

          // addAttribute.insert(idIndex, idWithOptions);

          print(addAttribute.join(','));

          setState(() {
            filterBy = addAttribute.join(',');
          });
        }
      } else {
        addOptions.clear();

        addOptions.addAll(listOnIndex);

        addOptions.add(optionsName);

        listOfAllOptions.removeAt(idIndex);

        listOfAllOptions.insert(idIndex, addOptions.toList(growable: true));

        print(listOfAllOptions);

        var optionsList = addOptions.join(';');

        var idWithOptions = '$attributeId:$optionsList';

        addAttribute.removeAt(idIndex);

        addAttribute.insert(idIndex, idWithOptions);

        print(addAttribute.join(','));

        setState(() {
          filterBy = addAttribute.join(',');
        });
      }
    } else {
      addOptions.clear();
      addOptions.add(optionsName);
      addAttributeId.add(attributeId);
      //idIndex = addAttributeId.indexWhere((element) => element == attributeId);

      listOfAllOptions.add(addOptions.toList(growable: true));

      print(listOfAllOptions);

      var optionsList = addOptions.join(';');

      selectedList = [attributeId, optionsList];

      addAttribute.add(selectedList.join(':'));

      print(addAttribute.join(','));

      setState(() {
        filterBy = addAttribute.join(',');
      });
    }
  }*/
}
