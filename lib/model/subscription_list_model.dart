class SubscriptionListModel {
  String? subId;
  String? subName;
  String? subDays;
  String? price;

  SubscriptionListModel({this.subId, this.subName, this.subDays, this.price});

  SubscriptionListModel.fromJson(Map<String, dynamic> json) {
    subId = json['sub_id'];
    subName = json['sub_name'];
    subDays = json['sub_days'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sub_id'] = this.subId;
    data['sub_name'] = this.subName;
    data['sub_days'] = this.subDays;
    data['price'] = this.price;
    return data;
  }
}
