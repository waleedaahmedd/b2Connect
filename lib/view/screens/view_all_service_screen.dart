import 'package:b2connect_flutter/model/locale/app_localization.dart';
import 'package:b2connect_flutter/model/models/offers_models/get_offers_model.dart';
import 'package:b2connect_flutter/model/models/offers_models/offers_list_model.dart';
import 'package:b2connect_flutter/model/services/navigation_service.dart';
import 'package:b2connect_flutter/model/utils/service_locator.dart';
import 'package:b2connect_flutter/view/widgets/appBar_with_cart_notification_widget.dart';
import 'package:b2connect_flutter/view/widgets/empty_cart.dart';
import 'package:b2connect_flutter/view/widgets/offers_list_widget.dart';
import 'package:b2connect_flutter/view/widgets/showOnWillPop.dart';
import 'package:b2connect_flutter/view_model/providers/offers_provider.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';


class ViewAllServiceScreen extends StatefulWidget {
  const ViewAllServiceScreen(
      {this.categoryId,
        this.sortBy,
        this.filterByStock,
        this.minPrice,
        this.filterBy,
        this.perPage,
        this.maxPrice,
        this.name,
        this.titleSortBy})
      : super();
  final int? categoryId;
  final String? sortBy;
  final String? filterBy;
  final String? filterByStock;
  final int? minPrice;
  final int? maxPrice;
  final int? perPage;
  final String? name;
  final String? titleSortBy;

  @override
  _ViewAllServiceScreenState createState() => _ViewAllServiceScreenState();
}

List<OffersList> _offerList = [];
var _controllers = ScrollController();
GetOffers? _offersData;
var _name;
var _pages;
var _categoryId;
var _sortBy;
var _filterBy;
var _filterByStock;
var _minPrice;
var _maxPrice;
//var utilService = locator<UtilService>();

class _ViewAllServiceScreenState extends State<ViewAllServiceScreen> {
  final CarouselController _controller = CarouselController();

  final List<String> _imgList = [
    'assets/images/latestSmartPhoneCard.png',
    'assets/images/banner_img.png',
  ];
  int _current = 0;

  //final _searchQueryController = TextEditingController();

  NavigationService _navigationService = locator<NavigationService>();

  _scrollListener() {
    if ((_controllers.position.pixels ==
        _controllers.position.maxScrollExtent) &&
        (_offersData!.offers.isNotEmpty)) {
      EasyLoading.show(
          status: AppLocalizations.of(context)!.translate('please_wait')!);
      if (mounted) {
        setState(() {
          _pages += 1;
          print('page: $_pages');
          Future.delayed(Duration.zero, () async {
            await getData();
            addMoreInOfferList();
          });
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _categoryId = widget.categoryId;
    _sortBy = widget.sortBy;
    _filterBy = widget.filterBy;
    _filterByStock = widget.filterByStock;
    _minPrice = widget.minPrice;
    _maxPrice = widget.maxPrice;
    _name = widget.name;
    _pages = 1;
    _controllers.addListener(_scrollListener);
    _offersData =
        Provider.of<OffersProvider>(context, listen: false).offersData;
    _offerList = _offersData!.offers;
    EasyLoading.dismiss();
  }

  final focus = FocusNode();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<OffersProvider>(builder: (context, i, _) {
      return WillPopScope(
        onWillPop: () {

          i.searchQueryController.clear();
          Navigator.pop(context, false);
          return Future.value(false);
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBarWithCartNotificationWidget(
            title: '${widget.name}',
            onTapIcon: ()  {

              navigationService.closeScreen();
            },
          )/*AppBar(
            centerTitle: false,
            leading: IconButton(
                padding: EdgeInsets.zero,
                constraints: BoxConstraints(),
                onPressed: () async {
                  await Provider.of<OffersProvider>(context, listen: false)
                      .clearFilterData();
                  i.searchQueryController.clear();

                  //navigationService.navigateTo(CategoriesScreenRoute);
                  Navigator.pop(context, false);
                },
                icon: Icon(Icons.arrow_back_ios)),
            automaticallyImplyLeading: false,
            elevation: 0,
            toolbarHeight: ScreenSize.appbarHeight,
            title: Text(
              'Top-Up',
              style: TextStyle(
                color: Colors.white,
                fontSize: ScreenSize.appbarText,
              ),
            ),
            actions: [
              //search
              *//*  IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SearchScreen(
                            categoryId: widget.categoryId,
                          )),
                );
              },
              icon: ImageIcon(
                size: 17,
              ),
            ),*//*

            *//*  IconButton(
                  onPressed: () {
                    _navigationService.navigateTo(WishlistScreenRoute);
                  },
                  icon: Icon(Icons.favorite_border_outlined)),*//*
            ],
            flexibleSpace: Container(
              decoration: BoxDecoration(gradient: gradientColor),
            ),
          )*/,
          body: SingleChildScrollView(
              controller: _controllers,
              child: Container(
                padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                   /* Container(
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Padding(
                        padding: EdgeInsets.zero,
                        child: TextField(
                          focusNode: focus,
                          // onChanged: onSearchTextChanged,
                          onSubmitted: onSearchTextChanged,
                          controller: i.searchQueryController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: 10),

                            suffixIcon: IconButton(
                                color: focus.hasFocus
                                    ? Theme.of(context).primaryColor
                                    : Colors.grey,
                                onPressed: () {
                                  FocusScope.of(context).unfocus();
                                  EasyLoading.show(status: 'Searching...');
                                  i.clearFilterData();

                                  setState(() async {
                                    _categoryId = null;
                                    _sortBy = null;
                                    _filterBy = null;
                                    _filterByStock = null;
                                    _minPrice = null;
                                    _maxPrice = null;
                                    _pages = 1;
                                    _name = i.searchQueryController.text;
                                    //_offerList.clear();
                                    await getData();
                                    updateOfferList();
                                  });

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
                    ),*/
                   /* Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        NewFilterScreen(widget.categoryId)),
                              );
                              *//*Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            NewFilterScreen(widget.categoryId)))
                                .then((value) {
                              setState(() {
                                *//* *//*_offersData = Provider.of<OffersProvider>(context,
                                        listen: false)
                                    .getOfferData;
                                offerList.clear();
                                offerList = _offersData!.offers;
                                EasyLoading.dismiss();*//* *//*
                              });
                            });*//*
                            },
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
                                  "${AppLocalizations.of(context)!.translate('filter')!} (${_offersData!.offerCount})",
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 14,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          SortByScreen(widget.categoryId)),
                                );
                              },
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
                                    widget.titleSortBy == null
                                        ? 'Default'
                                        : '${widget.titleSortBy}',
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
                    ),*/
                    /*   SizedBox(height: 5.0),*/
                    /* CarouselSlider(
                      carouselController: _controller,
                      options: CarouselOptions(
                        autoPlay: true,
                        height: 150,
                        viewportFraction: 1,
                        enlargeCenterPage: false,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _current = index;
                          });
                        },
                      ),
                      items: _imgList
                          .map((item) => GestureDetector(
                                onTap: () {},
                                child: Padding(
                                  padding: EdgeInsets.all(5.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                        12,
                                      ),
                                    ),
                                    width: MediaQuery.of(context).size.width,
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                          12,
                                        ),
                                        child: Image.asset(
                                          item,
                                          //fit: BoxFit.cover,
                                        )
                                        // FadeInImage(
                                        //   image: NetworkImage(item),
                                        //   placeholder: AssetImage(
                                        //   ),
                                        //   fit: BoxFit.fill,
                                        // ),
                                        ),
                                  ),
                                ),
                              ))
                          .toList(),
                    ),*/
                    /* SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: _imgList.asMap().entries.map(
                          (entry) {
                            return GestureDetector(
                              onTap: () => _controller.animateToPage(entry.key),
                              child: Container(
                                width: 15,
                                height: 7,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: _current == entry.key
                                      ? Colors.pink[400]
                                      : Colors.grey,
                                ),
                              ),
                            );
                          },
                        ).toList(),
                      ),
                    ),*/
                    // SizedBox(height: 20.0),
                    _offerList.length == 0
                        ? Container(
                      height: 500,
                      child: EmptyCart(
                        name: '',
                        desc: 'Coming Soon',
                        showButton: false,
                      ),
                    ) /*Container(
                            child: Column(
                            children: [
                              Icon(
                                Icons.do_disturb,
                                size: 30,
                                color: Theme.of(context).primaryColor,
                              ),
                              Text(
                                  'Sorry No Item with this name kindly search again'),
                            ],
                          ))*/
                        : Container(
                      child: OffersListWidget(_offerList),
                    )
                    /*FutureBuilder(
                    future: _getData,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        EasyLoading.dismiss();
                        offersData = snapshot.data;
                        print('page Number: $pages');
                        //  offersCount = offersData.offerCount;
                        if (pages == 1) {
                          offerList = offersData.offers;
                        }
                        return OffersListWidget(offerList);
                      } else {
                        return Container(
                            */ /*height: 300,
                            alignment: Alignment.bottomCenter,
                            child: new CircularProgressIndicator()*/ /*
                            );
                      }
                    },
                  ),*/
                  ],
                ),
              )),
        ),
      );
    });
  }

  onSearchTextChanged(String text) async {
    EasyLoading.show(status: 'Searching...');
    if (text.isEmpty) {
      await Provider.of<OffersProvider>(context, listen: false)
          .clearFilterData();

      setState(() async {
        _categoryId = null;
        _sortBy = null;
        _filterBy = null;
        _filterByStock = null;
        _minPrice = null;
        _maxPrice = null;
        _name = null;
        _pages = 1;
        //_offerList.clear();
        await getData();
        updateOfferList();
      });

      // _offerList.clear();
      //getData();
      return;
    } else {
      await Provider.of<OffersProvider>(context, listen: false)
          .clearFilterData();
      setState(() async {
        _categoryId = null;
        _sortBy = null;
        _filterBy = null;
        _filterByStock = null;
        _minPrice = null;
        _maxPrice = null;
        _name = text;
        _pages = 1;
        // _offerList.clear();
        await getData();
        updateOfferList();
      });

      // getData();

      //setState(() {});
    }
  }

  Future<void> getData() async {
    await Provider.of<OffersProvider>(context, listen: false).getOffers(
        perPage: widget.perPage,
        page: _pages,
        categoryId: _categoryId,
        name: _name,
        sortBy: _sortBy,
        minPrice: _minPrice,
        maxPrice: _maxPrice,
        filterBy: _filterBy,
        filterByStock: _filterByStock);
  }

  void updateOfferList() {
    setState(() {
      _offerList.clear();
      _offersData =
          Provider.of<OffersProvider>(context, listen: false).offersData;
      _offerList.addAll(_offersData!.offers);
      EasyLoading.dismiss();
    });
  }

  void addMoreInOfferList() {
    setState(() {
      _offersData =
          Provider.of<OffersProvider>(context, listen: false).offersData;
      _offerList.addAll(_offersData!.offers);
      EasyLoading.dismiss();
    });
  }

// _scrollListener() {
//   if ((_controllers.position.pixels ==
//           _controllers.position.maxScrollExtent) &&
//       (_offersData!.offers.isNotEmpty)) {
//     EasyLoading.show(status: 'Please Wait...');
//     if (mounted) {
//       setState(() {
//         pages += 1;
//         print('page: $pages');
//         Future.delayed(Duration.zero, () {
//           getData();
//         });
//       });
//     }
//   }
// }

}
