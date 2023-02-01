import 'package:b2connect_flutter/model/models/locations_model.dart';
import 'package:flutter/cupertino.dart';

import '../../model/models/location_categories_model.dart';

class LocationProvider with ChangeNotifier {
  List<LocationCategoriesModel> _dummyCategoriesList = [
    LocationCategoriesModel(
        id: 1, image: 'assets/images/map-location.png', name: 'All'),
    LocationCategoriesModel(
        id: 2, image: 'assets/images/map-location.png', name: 'Hospital'),
    LocationCategoriesModel(
        id: 3, image: 'assets/images/map-location.png', name: 'Food'),
    LocationCategoriesModel(

        id: 4,
        image: 'assets/images/map-location.png',
        name: 'Transport'),
    LocationCategoriesModel(
        id: 5, image: 'assets/images/map-location.png', name: 'Shop'),
    LocationCategoriesModel(
        id: 5, image: 'assets/images/map-location.png', name: 'Shop'),
    LocationCategoriesModel(
        id: 5, image: 'assets/images/map-location.png', name: 'Shop'),

  ];

  List<LocationsModel> _dummyLocationsList = [
    LocationsModel(id: 1, rating: 1.2, name: 'Contraste',location: 'Via Giuseppe Meda, 2, 20136 Milano MI', area: 'Modern European'),
    LocationsModel(id: 1, rating: 1.2, name: 'Contraste',location: 'Via Giuseppe Meda, 2, 20136 Milano MI', area: 'Modern European'),
    LocationsModel(id: 1, rating: 1.2, name: 'Contraste',location: 'Via Giuseppe Meda, 2, 20136 Milano MI', area: 'Modern European'),
    LocationsModel(id: 1, rating: 1.2, name: 'Contraste',location: 'Via Giuseppe Meda, 2, 20136 Milano MI', area: 'Modern European'),
    LocationsModel(id: 1, rating: 1.2, name: 'Contraste',location: 'Via Giuseppe Meda, 2, 20136 Milano MI', area: 'Modern European'),

  ];

  List<LocationCategoriesModel> _locationCategoriesList = [];
  List<LocationsModel> _locationsList = [];
  int _selectedCategory = 0;

  List<LocationCategoriesModel> get getLocationCategoriesList =>
      _locationCategoriesList;

  int get getSelectedCategory =>
      _selectedCategory;

  List<LocationsModel> get getLocationsList => _locationsList;

  void setLocationsList(List<LocationsModel> value) {
    _locationsList.addAll(value);
    notifyListeners();
  }

  void setLocationCategoriesList(List<LocationCategoriesModel> value) {
    _locationCategoriesList.addAll(value);
    notifyListeners();
  }

  void setSelectedCategory(int value) {
    _selectedCategory = value;
    notifyListeners();
  }

  Future<void> callLocationCategoriesList() async {
    _locationCategoriesList.clear();
    setLocationCategoriesList(_dummyCategoriesList);
  }

  Future<void> callLocationsList() async {
    _locationsList.clear();
    setLocationsList(_dummyLocationsList);
  }
}
