class Announcement {
  int? id;
  String? title;
  String? category;
  String? description;
  String? image;
  double? created;
  double? expiry;
  String? status;
  int? siteId;

  Announcement(
      {this.id,
        this.title,
        this.category,
        this.description,
        this.image,
        this.created,
        this.expiry,
        this.status,
        this.siteId});

  Announcement.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    category = json['category'];
    description = json['description'];
    image = 'https://api-qa2.b2connect.me/app/images/'+json['image'];
    created = json['created'];
    expiry = json['expiry'];
    status = json['status'];
    siteId = json['siteId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['category'] = this.category;
    data['description'] = this.description;
    data['image'] = this.image;
    data['created'] = this.created;
    data['expiry'] = this.expiry;
    data['status'] = this.status;
    data['siteId'] = this.siteId;
    return data;
  }
}