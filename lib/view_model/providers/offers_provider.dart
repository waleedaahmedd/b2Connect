import 'dart:convert';
import 'dart:core';

import 'package:b2connect_flutter/model/models/filter_model.dart';
import 'package:b2connect_flutter/model/models/offers_models/get_offers_model.dart';
import 'package:b2connect_flutter/model/models/offers_models/product_categories.dart';
import 'package:b2connect_flutter/model/models/offers_models/product_details_model.dart';
import 'package:b2connect_flutter/model/services/http_service.dart';
import 'package:b2connect_flutter/model/services/util_service.dart';
import 'package:b2connect_flutter/model/utils/service_locator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'Repository/repository_pattern.dart';

class OffersProvider with ChangeNotifier {
  Repository? http = locator<HttpService>();
  GetOffers? offersData;
  final searchQueryController = TextEditingController();
  bool b2PayTag = true;
  bool comingFromCart = true;
  bool comingFromCartIcon = true;

  // Payment Plan Check Boxes
  bool payNowCheckBox = true;
  bool payLater3xCheckBox = false;
  bool addOn3xCheckBox = false;
  bool addOn6xCheckBox = false;
  bool payLater6xCheckBox = false;
  double? finalPrice;
  String? finalEmiScreenDescription;

  ProductDetailsModel? productDetailsData;
  List<ProductCategories> productCategories = [];
  List<ProductCategories> topUpCategories = [];
  String topUpCategoryName = '';
  UtilService utilsService = locator<UtilService>();

  //List<dynamic> productIds = [];
  double totalPriceNow = 0.0;

  //double totalPriceLater = 0.0;
  double threeInstallmentPrice = 0.0;
  double sixInstallmentPrice = 0.0;
  double threePriceAddon = 0.0;
  double sixPriceAddon = 0.0;
  double updatedThreePriceAddon = 0.0;
  double updatedSixPriceAddon = 0.0;
  double updatedThreeInstallmentPrice = 0.0;
  double updatedSixInstallmentPrice = 0.0;
  List<ProductDetailsModel> cartData = [];

  bool onlySmartPhone = false;
  bool? showLoader;

  // filter Variables

  setOnlySmartPhone(bool value) {
    this.onlySmartPhone = value;
    notifyListeners();
  }

  setTopUpCategoryId(String value) {
    this.topUpCategoryName = value;
    notifyListeners();
  }

  setComingFromCart(bool value) {
    this.comingFromCart = value;
    notifyListeners();
  }

  setComingFromCartIcon(bool value) {
    this.comingFromCartIcon = value;
    notifyListeners();
  }

  FilterData filterData = FilterData(
      sortByListIndex: 0,
      availabilityListIndex: 0,
      listOfAllOptions: [],
      addAttributeId: [],
      selectedList: [],
      addAttribute: []);

  Future<void> handleAttributeTap(
      String attributeId, String optionsName) async {
    if (filterData.addAttributeId.contains(attributeId)) {
      var idIndex = filterData.addAttributeId
          .indexWhere((element) => element == attributeId);
      print(idIndex);

      List<String> listOnIndex = filterData.listOfAllOptions[idIndex];

      if (filterData.listOfAllOptions[idIndex].contains(optionsName)) {
        List<String> addOptions = [];
        addOptions.addAll(listOnIndex);
        addOptions.removeWhere((element) => element == optionsName);
        filterData.listOfAllOptions.removeAt(idIndex);
        filterData.listOfAllOptions
            .insert(idIndex, addOptions.toList(growable: true));
        var optionsList = addOptions.join(';');
        if (optionsList == "") {
          filterData.addAttributeId.removeAt(idIndex);
          filterData.addAttribute.removeAt(idIndex);
          print(filterData.addAttribute.join(','));
          filterData.filterBy = filterData.addAttribute.join(',') == ""
              ? null
              : filterData.addAttribute.join(',');
        } else {
          var idWithOptions = '$attributeId:$optionsList';
          filterData.addAttribute[idIndex] = idWithOptions;
          print(filterData.addAttribute.join(','));
          filterData.filterBy = filterData.addAttribute.join(',');
          addOptions.clear();
        }
      } else {
        List<String> addOptions = [];

        addOptions.addAll(listOnIndex);
        addOptions.add(optionsName);
        filterData.listOfAllOptions.removeAt(idIndex);
        filterData.listOfAllOptions
            .insert(idIndex, addOptions.toList(growable: true));
        print(filterData.listOfAllOptions);
        var optionsList = addOptions.join(';');
        var idWithOptions = '$attributeId:$optionsList';
        filterData.addAttribute.removeAt(idIndex);
        filterData.addAttribute.insert(idIndex, idWithOptions);
        print(filterData.addAttribute.join(','));
        filterData.filterBy = filterData.addAttribute.join(',');
        addOptions.clear();
      }
    } else {
      List<String> addOptions = [];
      addOptions.add(optionsName);
      filterData.addAttributeId.add(attributeId);
      filterData.listOfAllOptions.add(addOptions.toList(growable: true));
      print(filterData.listOfAllOptions);
      var optionsList = addOptions.join(';');
      filterData.selectedList = [attributeId, optionsList];
      filterData.addAttribute.add(filterData.selectedList.join(':'));
      print(filterData.addAttribute.join(','));
      filterData.filterBy = filterData.addAttribute.join(',');
      addOptions.clear();
    }
  }

  Future<void> clearFilterData({int? catId}) async {
    filterData.availabilityListIndex = 0;
    filterData.filterByStock = null;
    // filterData.sortByListIndex = 0;
    filterData.sortBy = null;
    filterData.filterBy = null;
    filterData.selectedList.clear();
    filterData.addAttribute.clear();
    filterData.maximumPrice = null;
    filterData.minimumPrice = null;
    //filterData.addOptions.clear();
    filterData.listOfAllOptions.clear();
    filterData.addAttributeId.clear();
    filterData.colors = null;
    EasyLoading.show(status: 'Please Wait...');
    if (catId != null) {
      await getOffers(categoryId: catId);
    }
    else{
      await getOffers();
    }
  }

  void handleSortByTap(int index, sortByListId) {
    filterData.sortByListIndex = index;
    if (sortByListId == '2') {
      filterData.sortBy = 'PRICE_LOW_TO_HIGH';
    } else if (sortByListId == '3') {
      filterData.sortBy = 'PRICE_HIGH_TO_LOW';
    } else if (sortByListId == '4') {
      filterData.sortBy = 'NAME_A_Z';
    } else if (sortByListId == '5') {
      filterData.sortBy = 'NEWEST';
    } else {
      filterData.sortBy = null;
    }
  }

  void handleAvailabilityTap(int index, availabilityListId) {
    filterData.availabilityListIndex = index;
    if (availabilityListId == '2') {
      filterData.filterByStock = 'IN_STOCK';
    } else if (availabilityListId == '3') {
      filterData.filterByStock = 'ON_BACK_ORDER';
    } else {
      filterData.filterByStock = null;
    }
  }

  Future<GetOffers?> getOffers(
      {int? page,
      int? perPage,
      int? categoryId,
      String? sortBy,
      String? filterBy,
      String? filterByStock,
      String? name,
      int? minPrice,
      int? maxPrice}) async {
    try {
      var response = await http!.getOffers(page, perPage, categoryId, sortBy,
          filterBy, filterByStock, name, minPrice, maxPrice);
      if (response.statusCode == 200) {
        saveOffersList(GetOffers.fromJson(json.decode(response.body)));
        EasyLoading.dismiss();

        return offersData;
      } else {
        return utilsService
            .showToast("No Products Found");
      }
    } on PlatformException catch (e) {
      EasyLoading.dismiss();
      print(e);
    }
    catch(e){
      EasyLoading.dismiss();
      print(e);
    }
  }

  Future<ProductDetailsModel?> getProductDetails(String id) async {
    print('id from api--$id');
    try {
      var response = await http!.getProductsDetails(id);
      if (response.statusCode == 200) {
        saveProductDetails(
            ProductDetailsModel.fromJson(json.decode(response.body)));
        return productDetailsData;
      } else {
        return utilsService
            .showToast("Something went wrong, Please Enter again");
      }
    } on PlatformException catch (e) {
      EasyLoading.dismiss();
      print(e);
    }
    catch(e){
      EasyLoading.dismiss();
      print(e);
    }
  }

  Future<List<ProductCategories>> getProductCategories() async {
    try {
      productCategories.clear();
      var response = await http!.productCategories();
      if (response.statusCode == 200) {
        for (var abc in response.data) {
          if (ProductCategories.fromJson(abc).parent == 0) {
            saveProductCategory(ProductCategories.fromJson(abc));
          }
        }
        return productCategories;
      } else {
        return utilsService
            .showToast("Something went wrong, Please Enter again");
      }
    }on PlatformException catch (e) {
      EasyLoading.dismiss();
      print(e);
      return productCategories;
    }
    catch(e){
      EasyLoading.dismiss();
      print(e);
      return productCategories;

    }
  }

  Future<List<ProductCategories>> getTopUpCategories() async {
    try {
      topUpCategories.clear();
      var response = await http!.topUpCategories();
      if (response.statusCode == 200) {
        for (var abc in response.data) {
          if (ProductCategories.fromJson(abc).parent == 0) {
            saveTopUpCategory(ProductCategories.fromJson(abc));
          }
        }
        return topUpCategories;
      } else {
        return utilsService
            .showToast("Something went wrong, Please Enter again");
      }
    } on PlatformException catch (e) {
      EasyLoading.dismiss();
      print(e);
      return topUpCategories;

    }
    catch(e){
      EasyLoading.dismiss();
      print(e);
      return topUpCategories;

    }
  }


  saveTotalNow(double value) {
    totalPriceNow = totalPriceNow + value;
    notifyListeners();
  }

  minusTotalNow(double value) {
    totalPriceNow = totalPriceNow - value;
    notifyListeners();
  }

/*  saveTotalLater(double value) {
    totalPriceLater = totalPriceLater + value;
    notifyListeners();
  } */

  remove3xInstallmentPrice(double installment, double addOn) {
    //  var removeInstallmentPrice = value / 3;
    updatedThreeInstallmentPrice = updatedThreeInstallmentPrice - installment;
    updatedThreePriceAddon = threePriceAddon - addOn;
    notifyListeners();
  }

  remove6xInstallmentPrice(double installment, double addOn) {
    //  var removeInstallmentPrice = value / 3;
    updatedSixInstallmentPrice = updatedSixInstallmentPrice - installment;
    updatedSixPriceAddon = sixPriceAddon - addOn;

    notifyListeners();
  }

  saveOffersList(GetOffers value) {
    offersData = value;
    notifyListeners();
  }

  set3xInstallmentPrice(double installment, double addOn) {
    threeInstallmentPrice = installment;
    threePriceAddon = addOn;
    notifyListeners();
  }

  set6xInstallmentPrice(double installment, double addOn) {
    sixInstallmentPrice = installment;
    sixPriceAddon = addOn;
    notifyListeners();
  }

  updatedOfInstallmentPrice(double emi3xPrice, double emi6xPrice,
      double emi3xAddon, double emi6xAddon) {
    /*var calculationWithRegularPrice = totalPriceNow - salePrice;
    calculationWithRegularPrice = calculationWithRegularPrice + regularPrice;
    var threeInstallment = threeInstallmentPrice * 2;
    updatedThreeInstallmentPrice = calculationWithRegularPrice - threeInstallment;

    var sixInstallment = sixInstallmentPrice * 5;*/
    updatedThreeInstallmentPrice = updatedThreeInstallmentPrice + emi3xPrice;

    updatedSixInstallmentPrice = updatedSixInstallmentPrice + emi6xPrice;

    updatedThreePriceAddon = updatedThreePriceAddon + emi3xAddon;

    updatedSixPriceAddon = updatedSixPriceAddon + emi6xAddon;
  }

  addOtherProductsPriceWithEmiProduct(double salePrice) {
    updatedThreeInstallmentPrice = updatedThreeInstallmentPrice + salePrice;
    updatedSixInstallmentPrice = updatedSixInstallmentPrice + salePrice;
    updatedThreePriceAddon = updatedThreePriceAddon + salePrice;
    updatedSixPriceAddon = updatedSixPriceAddon + salePrice;
  }

  removeOtherProductsPriceWithEmiProduct(double salePrice) {
    updatedThreeInstallmentPrice = updatedThreeInstallmentPrice - salePrice;
    updatedSixInstallmentPrice = updatedSixInstallmentPrice - salePrice;
    updatedThreePriceAddon = updatedThreePriceAddon - salePrice;
    updatedSixPriceAddon = updatedSixPriceAddon - salePrice;
  }

  /* addToCartList(int value) {
    productIds.add(value);
    notifyListeners();
  }*/

  /*removeFromCartList(int value) {
    productIds.remove(value);
    notifyListeners();
  }*/

  /*removeCartListRepeat(int value) {
    productIds.removeWhere((element) => element == value);
    notifyListeners();
  }*/

  /*addCartData(ProductDetailsModel value) {
    this.cartData.add(value);
    notifyListeners();
  }*/
  clearCartData() {
    this.cartData.clear();
    notifyListeners();
  }

  /*clearProduct() {
    this.productIds.clear();
    notifyListeners();
  }*/

  removeCartData(int value) {
    this.cartData.removeWhere((element) => element.offer.id == value);
    notifyListeners();
  }

  saveProductCategory(ProductCategories value) {
    this.productCategories.add(value);
    notifyListeners();
  }

  saveTopUpCategory(ProductCategories value) {
    this.topUpCategories.add(value);
    notifyListeners();
  }

  saveProductDetails(ProductDetailsModel value) {
    this.productDetailsData = value;
    notifyListeners();
  }

  clearAllData() {
    this.payNowCheckBox = true;
    this.payLater3xCheckBox = false;
    this.addOn3xCheckBox = false;
    this.addOn6xCheckBox = false;
    this.payLater6xCheckBox = false;
    this.cartData.clear();
    this.onlySmartPhone = false;
    this.totalPriceNow = 0.0;
    this.updatedThreeInstallmentPrice = 0.0;
    this.threeInstallmentPrice = 0.0;
    this.updatedSixInstallmentPrice = 0.0;
    this.sixInstallmentPrice = 0.0;
    this.sixPriceAddon = 0.0;
    this.threePriceAddon = 0.0;
    this.updatedSixPriceAddon = 0.0;
    this.updatedThreePriceAddon = 0.0;
    notifyListeners();
  }

  updateFilterData(FilterData value) {
    this.filterData = value;
    notifyListeners();
  }

  setPayNowCheckBox(bool value) {
    this.payNowCheckBox = value;
    notifyListeners();
  }

  setPayLater3xCheckBox(bool value) {
    this.payLater3xCheckBox = value;
    notifyListeners();
  }

  setPayLater6xCheckBox(bool value) {
    this.payLater6xCheckBox = value;
    notifyListeners();
  }

  setAddOn3xCheckBox(bool value) {
    this.addOn3xCheckBox = value;
    notifyListeners();
  }

  setAddOn6xCheckBox(bool value) {
    this.addOn6xCheckBox = value;
    notifyListeners();
  }
  setFinalPrice(double value) {
    this.finalPrice = value;
    notifyListeners();
  }

  setFinalEmiScreenDescription(String value) {
    this.finalEmiScreenDescription = value;
    notifyListeners();
  }
}
