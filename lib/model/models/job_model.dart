class Jobs {
  int? id;
  int? expectedSalaryMin;
  int? expectedSalaryMax;
  String? expectedSalaryCurrency;
  String? title;
  String? categoryId;
  String? companyName;
  String? companyLogo;
  String? jobDescription;
  InterviewLocation? interviewLocation;
  int? interviewDate;
  InterviewLocation? jobLocation;
  String? link;
  int? createdAt;

  Jobs(
      {this.id,
        this.expectedSalaryMin,
        this.expectedSalaryMax,
        this.expectedSalaryCurrency,
        this.title,
        this.categoryId,
        this.companyName,
        this.companyLogo,
        this.jobDescription,
        this.interviewLocation,
        this.interviewDate,
        this.jobLocation,
        this.link,
        this.createdAt});

  Jobs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    expectedSalaryMin = json['expected_salary_min'];
    expectedSalaryMax = json['expected_salary_max'];
    expectedSalaryCurrency = json['expected_salary_currency'];
    title = json['title'];
    categoryId = json['category_id'];
    companyName = json['company_name'];
    companyLogo = json['company_logo'];
    jobDescription = json['job_description'];
    interviewLocation = json['interview_location'] != null
        ? new InterviewLocation.fromJson(json['interview_location'])
        : null;
    interviewDate = json['interview_date'];
    jobLocation = json['job_location'] != null
        ? new InterviewLocation.fromJson(json['job_location'])
        : null;
    link = json['link'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['expected_salary_min'] = this.expectedSalaryMin;
    data['expected_salary_max'] = this.expectedSalaryMax;
    data['expected_salary_currency'] = this.expectedSalaryCurrency;
    data['title'] = this.title;
    data['category_id'] = this.categoryId;
    data['company_name'] = this.companyName;
    data['company_logo'] = this.companyLogo;
    data['job_description'] = this.jobDescription;
    if (this.interviewLocation != null) {
      data['interview_location'] = this.interviewLocation!.toJson();
    }
    data['interview_date'] = this.interviewDate;
    if (this.jobLocation != null) {
      data['job_location'] = this.jobLocation!.toJson();
    }
    data['link'] = this.link;
    data['created_at'] = this.createdAt;
    return data;
  }
}

class InterviewLocation {
  String? cityId;
  String? stateId;
  String? countryId;

  InterviewLocation({this.cityId, this.stateId, this.countryId});

  InterviewLocation.fromJson(Map<String, dynamic> json) {
    cityId = json['city_id'];
    stateId = json['state_id'];
    countryId = json['country_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['city_id'] = this.cityId;
    data['state_id'] = this.stateId;
    data['country_id'] = this.countryId;
    return data;
  }
}