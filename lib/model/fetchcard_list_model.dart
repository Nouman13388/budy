class FetchCardListModel {
  String? cardId;
  String? cardNumber;
  String? cardHolderName;
  String? expMonth;
  String? expYear;
  String? cvv;

  FetchCardListModel(
      {this.cardId,
        this.cardNumber,
        this.cardHolderName,
        this.expMonth,
        this.expYear,
        this.cvv});

  FetchCardListModel.fromJson(Map<String, dynamic> json) {
    cardId = json['card_id'];
    cardNumber = json['card_number'];
    cardHolderName = json['card_holder_name'];
    expMonth = json['exp_month'];
    expYear = json['exp_year'];
    cvv = json['cvv'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['card_id'] = this.cardId;
    data['card_number'] = this.cardNumber;
    data['card_holder_name'] = this.cardHolderName;
    data['exp_month'] = this.expMonth;
    data['exp_year'] = this.expYear;
    data['cvv'] = this.cvv;
    return data;
  }
}



