class ProfileModel {
  String? result;
  String? username;
  String? fullName;
  String? email;
  String? age;
  String? code;
  String? contact;
  String? address;
  String? latitude;
  String? longitude;
  String? gender;
  String? image;
  List<Category>? category;

  ProfileModel(
      {this.result,
        this.username,
        this.fullName,
        this.email,
        this.age,
        this.code,
        this.contact,
        this.address,
        this.latitude,
        this.longitude,
        this.gender,
        this.image,
        this.category});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    username = json['username'];
    fullName = json['full_name'];
    email = json['email'];
    age = json['age'];
    code = json['code'];
    contact = json['contact'];
    address = json['address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    gender = json['gender'];
    image = json['image'];
    if (json['category'] != null) {
      category = <Category>[];
      json['category'].forEach((v) {
        category!.add(new Category.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this.result;
    data['username'] = this.username;
    data['full_name'] = this.fullName;
    data['email'] = this.email;
    data['age'] = this.age;
    data['code'] = this.code;
    data['contact'] = this.contact;
    data['address'] = this.address;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['gender'] = this.gender;
    data['image'] = this.image;
    if (this.category != null) {
      data['category'] = this.category!.map((v) => v.toJson()).toList();
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
