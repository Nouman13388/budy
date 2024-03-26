class NotificationDetailModel {
  String? eventImg;
  String? eventId;
  String? title;
  String? message;
  String? date;
  String? time;

  NotificationDetailModel(
      {this.eventImg,
        this.eventId,
        this.title,
        this.message,
        this.date,
        this.time});

  NotificationDetailModel.fromJson(Map<String, dynamic> json) {
    eventImg = json['event_img'];
    eventId = json['event_id'];
    title = json['title'];
    message = json['message'];
    date = json['date'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['event_img'] = this.eventImg;
    data['event_id'] = this.eventId;
    data['title'] = this.title;
    data['message'] = this.message;
    data['date'] = this.date;
    data['time'] = this.time;
    return data;
  }
}
