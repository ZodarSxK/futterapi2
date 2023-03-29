import 'dart:ffi';

class GetOrder {
  List<Data>? data;

  GetOrder({this.data});

  GetOrder.fromJson(Map<String, dynamic> json) {
    if (json['Data'] != null) {
      data = <Data>[];
      json['Data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['Data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? order_no;
  int? order_num;
  String? product_name;
  String? product_source;
  int? amount;

  Data(
      {this.order_no,
      this.order_num,
      this.product_name,
      this.product_source,
      this.amount});

  Data.fromJson(Map<String, dynamic> json) {
    order_no = json['order_no'];
    order_num = json['piece'];
    product_name = json['product_name'];
    product_source = json['product_source'];
    amount = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_no'] = this.order_no;
    data['order_num'] = this.order_num;
    data['product_name'] = this.product_name;
    data['product_source'] = this.product_source;
    data['amount'] = this.amount;
    return data;
  }
}
