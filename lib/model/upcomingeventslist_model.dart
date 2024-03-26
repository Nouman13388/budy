class UpcomingEventsListModel {
  String? status;
  String? totalInterest;
  String? eventId;
  String? distance;
  String? userId;
  String? eventName;
  String? orgName;
  String? orgNumber;
  String? about;
  String? cardId;
  String? subscriptionId;
  String? location;
  String? latitude;
  String? longitude;
  List<Category>? category;
  String? startDate;
  String? startDay;
  String? endDate;
  String? endDay;
  String? time;
  List<Images>? images;

  UpcomingEventsListModel(
      {this.status,
        this.totalInterest,
        this.eventId,
        this.distance,
        this.userId,
        this.eventName,
        this.orgName,
        this.orgNumber,
        this.about,
        this.cardId,
        this.subscriptionId,
        this.location,
        this.latitude,
        this.longitude,
        this.category,
        this.startDate,
        this.startDay,
        this.endDate,
        this.endDay,
        this.time,
        this.images});

  UpcomingEventsListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    totalInterest = json['total_interest'].toString();
    eventId = json['event_id'];
    distance = json['distance'];
    userId = json['user_id'];
    eventName = json['event_name'];
    orgName = json['org_name'];
    orgNumber = json['org_number'];
    about = json['about'];
    cardId = json['card_id'];
    subscriptionId = json['subscription_id'];
    location = json['location'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    if (json['category'] != null) {
      category = <Category>[];
      json['category'].forEach((v) {
        category!.add(new Category.fromJson(v));
      });
    }
    startDate = json['start_date'];
    startDay = json['start_day'];
    endDate = json['end_date'];
    endDay = json['end_day'];
    time = json['time'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['total_interest'] = this.totalInterest;
    data['event_id'] = this.eventId;
    data['distance'] = this.distance;
    data['user_id'] = this.userId;
    data['event_name'] = this.eventName;
    data['org_name'] = this.orgName;
    data['org_number'] = this.orgNumber;
    data['about'] = this.about;
    data['card_id'] = this.cardId;
    data['subscription_id'] = this.subscriptionId;
    data['location'] = this.location;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    if (this.category != null) {
      data['category'] = this.category!.map((v) => v.toJson()).toList();
    }
    data['start_date'] = this.startDate;
    data['start_day'] = this.startDay;
    data['end_date'] = this.endDate;
    data['end_day'] = this.endDay;
    data['time'] = this.time;
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Category {
  String? catId;
  String? catName;
  String? catImg;

  Category({this.catId, this.catName, this.catImg});

  Category.fromJson(Map<String, dynamic> json) {
    catId = json['cat_id'];
    catName = json['cat_name'];
    catImg = json['cat_img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cat_id'] = this.catId;
    data['cat_name'] = this.catName;
    data['cat_img'] = this.catImg;
    return data;
  }
}

class Images {
  String? img;

  Images({this.img});

  Images.fromJson(Map<String, dynamic> json) {
    img = json['img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['img'] = this.img;
    return data;
  }
}
