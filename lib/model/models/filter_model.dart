class FilterData {
  int sortByListIndex;
  String? sortBy;

  int availabilityListIndex;
  String? filterByStock;
  List<String> addAttributeId;
  List<List<String>> listOfAllOptions;
 // List<String> addOptions;
  List<String> addAttribute;
  List<String> selectedList;
  String? filterBy;
  String? colors;
  int? minimumPrice;
  int? maximumPrice;

  FilterData({required this.sortByListIndex,
    this.sortBy,
    required this.availabilityListIndex,
    this.filterByStock,
    this.filterBy,
    this.minimumPrice,
    this.maximumPrice,
    this.colors,
    required this.addAttributeId,
    required this.listOfAllOptions,
   // required this.addOptions,
    required this.addAttribute,
    required this.selectedList});
}
