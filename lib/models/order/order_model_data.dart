class OrderModelData {
  String? orderId;
  String? orderNo;
  String? status;
  List<StatusHistory>? statusHistory;
  String? createdAt;
  int? totalAmount;
  int? tip;
  String? promoCode;
  User? user;
  String? cartId;
  int? quantity;
  int? totalPrice;
  Meal? meal;

  OrderModelData({
    this.orderId,
    this.orderNo,
    this.status,
    this.statusHistory,
    this.createdAt,
    this.totalAmount,
    this.tip,
    this.promoCode,
    this.user,
    this.cartId,
    this.quantity,
    this.totalPrice,
    this.meal,
  });

  OrderModelData.fromJson(Map<String, dynamic> json) {
    orderId = json['orderId'];
    orderNo = json['orderNo'];
    status = json['status'];
    if (json['statusHistory'] != null) {
      statusHistory = <StatusHistory>[];
      json['statusHistory'].forEach((v) {
        statusHistory!.add(new StatusHistory.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    totalAmount = json['totalAmount'];
    tip = json['tip'];
    promoCode = json['promoCode'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    cartId = json['cartId'];
    quantity = json['quantity'];
    totalPrice = json['totalPrice'];
    meal = json['meal'] != null ? new Meal.fromJson(json['meal']) : null;
  }
}

class StatusHistory {
  String? status;
  String? changedAt;
  String? sId;

  StatusHistory({this.status, this.changedAt, this.sId});

  StatusHistory.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    changedAt = json['changedAt'];
    sId = json['_id'];
  }
}

class User {
  String? name;
  String? email;
  String? profileImage;

  User({this.name, this.email, this.profileImage});

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    profileImage = json['profileImage'];
  }
}

class Meal {
  String? name;
  String? image;
  String? description;
  int? price;
  int? pricePerPortion;

  Meal({
    this.name,
    this.image,
    this.description,
    this.price,
    this.pricePerPortion,
  });

  Meal.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
    description = json['description'];
    price = json['price'];
    pricePerPortion = json['pricePerPortion'];
  }
}
