class SavedAddressListModel {
  String? userId;
  String? location;
  String? latitude;
  String? longitude;

  SavedAddressListModel(
      {this.userId, this.location, this.latitude, this.longitude});

  SavedAddressListModel.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    location = json['location'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['location'] = this.location;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }
}
