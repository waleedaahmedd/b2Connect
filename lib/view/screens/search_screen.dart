import 'package:b2connect_flutter/model/locale/app_localization.dart';
import 'package:b2connect_flutter/model/models/offers_models/get_offers_model.dart';
import 'package:b2connect_flutter/model/models/offers_models/options_model.dart';
import 'package:b2connect_flutter/model/utils/routes.dart';
import 'package:b2connect_flutter/view/screens/view_all_offers_screen.dart';
import 'package:b2connect_flutter/view/widgets/no_data_screen.dart';
import 'package:b2connect_flutter/view/widgets/showOnWillPop.dart';
import 'package:b2connect_flutter/view_model/providers/offers_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({this.categoryId}) : super();

  final categoryId;

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchQueryController = TextEditingController();

  GetOffers? _offersData;
  late String _name;
  var _index = 0;
  String _errorText = "";
  String _inputText = "";

  List<Options> _searchResult = [];
  List<Options> _optionData = [];
  // late Future<void> _launched;
  //
  // Future<void> _makePhoneCall(String url) async {
  //   if (await canLaunch(url)) {
  //     await launch(url);
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }

  @override
  void initState() {
    super.initState();
    _offersData = Provider.of<OffersProvider>(context, listen: false).offersData;
    if (_offersData!.filterMeta.attributeFilterMeta!.isNotEmpty) {
      _optionData.addAll(
          _offersData!.filterMeta.attributeFilterMeta![_index].options!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
      ),
      body: _offersData!.filterMeta.attributeFilterMeta!.isNotEmpty
          ? Container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                    child: Row(
                      children: [
                        Flexible(
                          flex: 6,
                          child: Container(
                            height: 50,
                            child: Padding(
                              padding: EdgeInsets.zero,
                              child: TextField(
                                controller: _searchQueryController,
                                onSubmitted: (value){
                                  print('submitted press');
                                },
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(left: 10),
                                  prefixIcon: Icon(Icons.search,
                                      color: Theme.of(context).primaryColor),
                                  suffixIcon: IconButton(
                                      color: Colors.grey,
                                      onPressed: () {
                                        FocusScope.of(context).unfocus();
                                        setState(() {
                                          _searchQueryController.clear();
                                          _searchResult.clear();
                                          _inputText = "";
                                        });
                                      },
                                      icon: Icon(Icons.close)),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Theme.of(context).primaryColor,
                                      width: 1,
                                    ),
                                  ),

                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Theme.of(context).primaryColor,
                                      width: 1,
                                    ),
                                  ),
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  hintText: 'Seacrh...',
                                  hintStyle: TextStyle(
                                      fontSize: 14,
                                      decoration: TextDecoration.none),
                                  fillColor: Colors.white,
                                  filled: true,
                                ),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    decoration: TextDecoration.none),
                                onChanged: onSearchTextChanged,
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                            child: Container(
                          height: 50,
                          // color: Colors.pinkAccent,
                          child: Align(
                              alignment: Alignment.centerRight,
                              child: IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.mic_none,
                                      color: Colors.grey.shade400))),
                        )),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Divider(
                    height: 0,
                    thickness: 1,
                    color: Colors.grey.shade400,
                  ),
                  Container(
                    height: 60,
                    // color: Colors.pinkAccent,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _offersData!.filterMeta.attributeFilterMeta!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                  top: 20.0,
                                  left: 10.0,
                                  right: 10.0,
                                  bottom: 10.0),
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: index == _index
                                          ? Color.fromRGBO(255, 235, 242, 1)
                                          : Colors.white),
                                  onPressed: () {
                                    setState(() {
                                      _index = index;
                                      _optionData.clear();
                                      _optionData.addAll(_offersData!
                                          .filterMeta
                                          .attributeFilterMeta![_index]
                                          .options!);
                                      onSearchTextChanged(_inputText);
                                    });
                                  },
                                  child: Text(
                                    _offersData!.filterMeta.attributeFilterMeta![index].attributeName.toString(),
                                    style: TextStyle(
                                        color: index == _index ? Theme.of(context).primaryColor : Colors.grey.shade400),
                                  )),
                            );
                          }),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                        child: _errorText == "No Result Found"
                            ? Center(child: Text(_errorText,style: TextStyle(fontSize: 18),))
                            : ListView.builder(
                                itemCount: _searchResult.isEmpty
                                    ? _offersData!
                                        .filterMeta
                                        .attributeFilterMeta![_index]
                                        .options!
                                        .length
                                    : _searchResult.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        elevation: 0, primary: Colors.white),
                                    onPressed: () async {
                                      _name =
                                          '${_offersData!.filterMeta.attributeFilterMeta![_index].attributeId}:${_searchResult.isEmpty ? _offersData!.filterMeta.attributeFilterMeta![_index].options![index].value.toString() : _searchResult[index].value}';
                                      var count = 0;
                                      EasyLoading.show(
                                          status: AppLocalizations.of(context)!.translate('please_wait')!);
                                      await getData().then((value) {
                                        Navigator.popUntil(context, (route) {
                                          return count++ == 2;
                                        });
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ViewAllOffersScreen(
                                                  10,
                                              categoryId: widget.categoryId,
                                              filterBy: _name,
                                            ),
                                          ),
                                        );
                                      });
                                      EasyLoading.dismiss();
                                    },
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        _searchResult.isEmpty
                                            ? _offersData!
                                                .filterMeta
                                                .attributeFilterMeta![_index]
                                                .options![index]
                                                .value
                                                .toString()
                                            : _searchResult[index]
                                                .value
                                                .toString(),
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                  );
                                })),
                  )
                ],
              ),
            )
          : NoDataScreen(
        title: AppLocalizations.of(context)!.translate('wifi_plan')!,
        desc: "Seems, there is no  products",
        buttontxt: "Get Wifi, Today!",
        ontap: ()async{

          navigationService.navigateTo(WifiScreenRoute);
        },
      ),
    );
  }

  onSearchTextChanged(String text) async {
    _inputText = text;
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {
        _errorText = "";
      });
      return;
    } else {



      _optionData.forEach((_options) {
        String _optionValue = _options.value!;

        if (_optionValue.contains(text) ||
            _optionValue.contains(text[0].toUpperCase())) {
          _searchResult.add(_options);
          print(_searchResult);
        }

        _errorText = _searchResult.isEmpty ? "No Result Found" : "";
      });
      setState(() {});
    }
  }

  Future<void> getData() async {
    await Provider.of<OffersProvider>(context, listen: false).getOffers(
      perPage: 10,
      // page: pages,
      categoryId: widget.categoryId,
      filterBy: _name,
      //sortBy: widget.sortBy,
      // minPrice: widget.minPrice,
      // filterBy: widget.filterBy,
      /*filterByStock: widget.filterByStock*/
    );

    setState(() {
      _offersData =
          Provider.of<OffersProvider>(context, listen: false).offersData;
    });

    //offerList.addAll(_offersData!.offers);
    EasyLoading.dismiss();
  }
}
