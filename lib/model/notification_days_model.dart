class NotificationDaysModel {
  String? notiId;
  String? notifiyDay;

  NotificationDaysModel({this.notiId, this.notifiyDay});

  NotificationDaysModel.fromJson(Map<String, dynamic> json) {
    notiId = json['noti_id'];
    notifiyDay = json['notifiy_day'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['noti_id'] = this.notiId;
    data['notifiy_day'] = this.notifiyDay;
    return data;
  }
}
