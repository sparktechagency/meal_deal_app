class CookDetailsModelData {
  Cook? cook;
  List<Meals>? meals;
  List<Reviews>? reviews;

  CookDetailsModelData({this.cook, this.meals, this.reviews});

  CookDetailsModelData.fromJson(Map<String, dynamic> json) {
    cook = json['cook'] != null ? new Cook.fromJson(json['cook']) : null;
    if (json['meals'] != null) {
      meals = <Meals>[];
      json['meals'].forEach((v) {
        meals!.add(new Meals.fromJson(v));
      });
    }
    if (json['reviews'] != null) {
      reviews = <Reviews>[];
      json['reviews'].forEach((v) {
        reviews!.add(new Reviews.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.cook != null) {
      data['cook'] = this.cook!.toJson();
    }
    if (this.meals != null) {
      data['meals'] = this.meals!.map((v) => v.toJson()).toList();
    }
    if (this.reviews != null) {
      data['reviews'] = this.reviews!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Cook {
  String? sId;
  String? userId;
  String? cookName;
  String? businessNumber;
  String? profileImage;
  List<String>? kitchenImages;
  List<String>? certificates;
  String? approvedAt;
  String? rejectionReason;
  String? totalOrders;
  String? completedOrders;
  String? rejectedOrders;
  int? rating;
  String? stars;
  String? totalReviews;
  bool? isKlzhRegistered;
  bool? isCookApproved;
  bool? isDeleted;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? description;
  String? shortDescription;

  Cook(
      {this.sId,
        this.userId,
        this.cookName,
        this.businessNumber,
        this.profileImage,
        this.kitchenImages,
        this.certificates,
        this.approvedAt,
        this.rejectionReason,
        this.totalOrders,
        this.completedOrders,
        this.rejectedOrders,
        this.rating,
        this.stars,
        this.totalReviews,
        this.isKlzhRegistered,
        this.isCookApproved,
        this.isDeleted,
        this.createdAt,
        this.updatedAt,
        this.iV,
        this.description,
        this.shortDescription});

  Cook.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['userId'];
    cookName = json['cookName'];
    businessNumber = json['businessNumber'];
    profileImage = json['profileImage'];
    kitchenImages = json['kitchenImages'].cast<String>();
    certificates = json['certificates'].cast<String>();
    approvedAt = json['approvedAt'];
    rejectionReason = json['rejectionReason'];
    totalOrders = json['totalOrders'];
    completedOrders = json['completedOrders'];
    rejectedOrders = json['rejectedOrders'];
    rating = json['rating'];
    stars = json['stars'];
    totalReviews = json['totalReviews'];
    isKlzhRegistered = json['isKlzhRegistered'];
    isCookApproved = json['isCookApproved'];
    isDeleted = json['isDeleted'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    description = json['description'];
    shortDescription = json['shortDescription'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['userId'] = this.userId;
    data['cookName'] = this.cookName;
    data['businessNumber'] = this.businessNumber;
    data['profileImage'] = this.profileImage;
    data['kitchenImages'] = this.kitchenImages;
    data['certificates'] = this.certificates;
    data['approvedAt'] = this.approvedAt;
    data['rejectionReason'] = this.rejectionReason;
    data['totalOrders'] = this.totalOrders;
    data['completedOrders'] = this.completedOrders;
    data['rejectedOrders'] = this.rejectedOrders;
    data['rating'] = this.rating;
    data['stars'] = this.stars;
    data['totalReviews'] = this.totalReviews;
    data['isKlzhRegistered'] = this.isKlzhRegistered;
    data['isCookApproved'] = this.isCookApproved;
    data['isDeleted'] = this.isDeleted;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['description'] = this.description;
    data['shortDescription'] = this.shortDescription;
    return data;
  }
}

class Meals {
  String? sId;
  String? cookId;
  String? mealName;
  String? description;
  String? cuisineName;
  int? availablePortion;
  String? dietaryCategories;
  String? category;
  String? fitnessFlow;
  String? cheatFlow;
  String? timeForOrder;
  String? timeForPickUpFood;
  double? pricePerPortion;
  String? servedWarm;
  double? coldReheatPrice;
  List<String>? ingredients;
  String? allergyInformation;
  double? price;
  String? location;
  String? pickUpTime;
  String? offer;
  String? kcalories;
  List<String>? imageUrls;
  String? createdAt;
  String? updatedAt;
  int? iV;
  int? rating;

  Meals(
      {this.sId,
        this.cookId,
        this.mealName,
        this.description,
        this.cuisineName,
        this.availablePortion,
        this.dietaryCategories,
        this.category,
        this.fitnessFlow,
        this.cheatFlow,
        this.timeForOrder,
        this.timeForPickUpFood,
        this.pricePerPortion,
        this.servedWarm,
        this.coldReheatPrice,
        this.ingredients,
        this.allergyInformation,
        this.price,
        this.location,
        this.pickUpTime,
        this.offer,
        this.kcalories,
        this.imageUrls,
        this.createdAt,
        this.updatedAt,
        this.iV,
        this.rating});

  Meals.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    cookId = json['cookId'];
    mealName = json['mealName'];
    description = json['description'];
    cuisineName = json['cuisineName'];
    availablePortion = json['availablePortion'];
    dietaryCategories = json['dietaryCategories'];
    category = json['category'];
    fitnessFlow = json['fitnessFlow'];
    cheatFlow = json['cheatFlow'];
    timeForOrder = json['timeForOrder'];
    timeForPickUpFood = json['timeForPickUpFood'];
    pricePerPortion = json['pricePerPortion'];
    servedWarm = json['servedWarm'];
    coldReheatPrice = json['coldReheatPrice'];
    ingredients = json['ingredients'].cast<String>();
    allergyInformation = json['allergyInformation'];
    price = json['price'];
    location = json['location'];
    pickUpTime = json['pickUpTime'];
    offer = json['offer'];
    kcalories = json['kcalories'];
    imageUrls = json['imageUrls'].cast<String>();
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    rating = json['rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['cookId'] = this.cookId;
    data['mealName'] = this.mealName;
    data['description'] = this.description;
    data['cuisineName'] = this.cuisineName;
    data['availablePortion'] = this.availablePortion;
    data['dietaryCategories'] = this.dietaryCategories;
    data['category'] = this.category;
    data['fitnessFlow'] = this.fitnessFlow;
    data['cheatFlow'] = this.cheatFlow;
    data['timeForOrder'] = this.timeForOrder;
    data['timeForPickUpFood'] = this.timeForPickUpFood;
    data['pricePerPortion'] = this.pricePerPortion;
    data['servedWarm'] = this.servedWarm;
    data['coldReheatPrice'] = this.coldReheatPrice;
    data['ingredients'] = this.ingredients;
    data['allergyInformation'] = this.allergyInformation;
    data['price'] = this.price;
    data['location'] = this.location;
    data['pickUpTime'] = this.pickUpTime;
    data['offer'] = this.offer;
    data['kcalories'] = this.kcalories;
    data['imageUrls'] = this.imageUrls;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['rating'] = this.rating;
    return data;
  }
}

class Reviews {
  String? sId;
  UserId? userId;
  String? cookId;
  int? rating;
  String? comment;
  bool? isDeleted;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Reviews(
      {this.sId,
        this.userId,
        this.cookId,
        this.rating,
        this.comment,
        this.isDeleted,
        this.createdAt,
        this.updatedAt,
        this.iV});

  Reviews.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId =
    json['userId'] != null ? new UserId.fromJson(json['userId']) : null;
    cookId = json['cookId'];
    rating = json['rating'];
    comment = json['comment'];
    isDeleted = json['isDeleted'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.userId != null) {
      data['userId'] = this.userId!.toJson();
    }
    data['cookId'] = this.cookId;
    data['rating'] = this.rating;
    data['comment'] = this.comment;
    data['isDeleted'] = this.isDeleted;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class UserId {
  String? sId;
  String? name;

  UserId({this.sId, this.name});

  UserId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    return data;
  }
}
