import 'package:b2connect_flutter/model/models/job_categories_model.dart';
import 'package:b2connect_flutter/model/models/job_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../model/services/http_service.dart';
import '../../model/utils/service_locator.dart';
import 'Repository/repository_pattern.dart';

class JobProvider with ChangeNotifier {
  JobCategories? jobCategoriesList;
  List<Jobs> jobList = [];
  List<String> jobFilterLocationsList = [];
  List<String> jobFilterSortOrderList = [];
  List<Jobs> jobPerPageList = [];
  int sortOrderFilterClickIndex = 0;
  int locationFilterClickIndex = 0;
  bool isJobListEmpty = false;
  Jobs? jobDetail;
  int page = 1;
  int perPage = 10;
  String? title = '';
  String? location = '';
  String? sortOrder = '';
  int salaryMin = 0;
  int salaryMax = 50000;
  int? dateMin;
  int? dateMax;
  String jobCategorySelected = '';
  int? jobSelectedCategoryCount;

  //int selectedJobCheckBoxIndex = 0;
  Repository? http = locator<HttpService>();

  clearJobProvider() {
    // jobFilterLocationsList = [];
    //jobFilterTypeList = [];
    /*jobCategoriesList = [];
    jobList = [];*/
    page = 1;
    perPage = 10;
    title = '';
    location = '';
    salaryMin = 0;
    salaryMax = 50000;
    sortOrder = '';
    locationFilterClickIndex = 0;
    sortOrderFilterClickIndex = 0;
    /*   dateMin;
    dateMax;*/
    //jobCategorySelected = '';
    //selectedJobCheckBoxIndex = 0;
  }

  setJobCategorySelected(String value) {
    this.jobCategorySelected = value;
    notifyListeners();
  }

  setJobSelectedCategoryCount(int value) {
    this.jobSelectedCategoryCount = value;
    notifyListeners();
  }

  setLocationFilterClickIndex(int value) {
    this.locationFilterClickIndex = value;
    notifyListeners();
  }

  setSortOrderFilterClickIndex(int value) {
    this.sortOrderFilterClickIndex = value;
    if (value == 0) {
      this.sortOrder = 'desc';
    } else {
      this.sortOrder = 'asc';
    }
    notifyListeners();
  }

  /*setSelectedJobCheckBoxIndex(int value) {
    this.selectedJobCheckBoxIndex = value;
    notifyListeners();
  }*/

  setJobList(List<Jobs> value) {
    this.jobList.addAll(value);
    notifyListeners();
  }

  setIsJobListEmpty(bool value) {
    this.isJobListEmpty = value;
    notifyListeners();
  }

  setJobCategory(JobCategories value) {
    this.jobCategoriesList = value;
    notifyListeners();
  }

  Future<JobCategories?> getJobCategories() async {
    try {
      var response = await http!.getJobsCategories();
      if (response.statusCode == 200) {
        /*for (var data in response.data) {*/
          setJobCategory(JobCategories.fromJson(response.data));
        /*}*/
        EasyLoading.dismiss();
        return jobCategoriesList;
      } else {
        EasyLoading.showError('Something went wrong Please try Again');
        return jobCategoriesList;
      }
    } on PlatformException catch (e) {
      EasyLoading.dismiss();
      print(e);
      return jobCategoriesList;
    }
    catch(e){
      EasyLoading.dismiss();
      print(e);
    }
  }

  Future<List<Jobs>> getJobList() async {
    try {
      var response = await http!.getJobs(
          page,
          perPage,
          title,
          jobCategorySelected,
          location,
          salaryMin,
          salaryMax,
          dateMin,
          dateMax,
          sortOrder);
      if (response.statusCode == 200) {
        jobPerPageList.clear();
        for (var data in response.data) {
          this.jobPerPageList.add(Jobs.fromJson(data));
        }

        if (jobPerPageList.isNotEmpty) {
          this.setIsJobListEmpty(false);
          setJobList(jobPerPageList);
        }
        if (jobList.isEmpty) {
          this.setIsJobListEmpty(true);
        }

        EasyLoading.dismiss();
        return jobList;
      } else {
        EasyLoading.showError('Something went wrong Please try Again');
        return jobList;
      }
    } on PlatformException catch (e) {
      EasyLoading.dismiss();
      print(e);
      return jobList;
    }
    catch(e){
      EasyLoading.dismiss();
      print(e);
      return jobList;
    }
  }
}
