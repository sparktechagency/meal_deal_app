
class Meta {
  int? total;
  int? page;
  int? limit;
  int? totalPage;

  Meta({this.total, this.page, this.limit, this.totalPage});

  Meta.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    page = json['page'];
    limit = json['limit'];
    totalPage = json['totalPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['page'] = this.page;
    data['limit'] = this.limit;
    data['totalPage'] = this.totalPage;
    return data;
  }
}

class MealModelData {
  Meta? meta;
  List<Meals>? meals;
  List<TopRatedCooks>? topRatedCooks;
  List<PopularMeals>? popularMeals;

  MealModelData({this.meta, this.meals, this.topRatedCooks, this.popularMeals});

  MealModelData.fromJson(Map<String, dynamic> json) {
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
    if (json['meals'] != null) {
      meals = <Meals>[];
      json['meals'].forEach((v) {
        meals!.add(new Meals.fromJson(v));
      });
    }
    if (json['topRatedCooks'] != null) {
      topRatedCooks = <TopRatedCooks>[];
      json['topRatedCooks'].forEach((v) {
        topRatedCooks!.add(new TopRatedCooks.fromJson(v));
      });
    }
    if (json['popularMeals'] != null) {
      popularMeals = <PopularMeals>[];
      json['popularMeals'].forEach((v) {
        popularMeals!.add(new PopularMeals.fromJson(v));
      });
    }
  }
}

class TopRatedCooks {
  String? sId;
  String? cookName;
  String? businessNumber;
  String? profileImage;
  int? rating;

  TopRatedCooks(
      {this.sId,
        this.cookName,
        this.businessNumber,
        this.profileImage,
        this.rating});

  TopRatedCooks.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    cookName = json['cookName'];
    businessNumber = json['businessNumber'];
    profileImage = json['profileImage'];
    rating = json['rating'];
  }
}

class PopularMeals {
  String? sId;
  String? cookId;
  String? mealName;
  String? kcalories;
  int? availablePortion;
  String? description;
  double? price;
  List<String>? imageUrls;
  Cook? cook;

  PopularMeals(
      {this.sId,
        this.cookId,
        this.mealName,
        this.kcalories,
        this.description,
        this.availablePortion,
        this.price,
        this.imageUrls,
        this.cook});

  PopularMeals.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    cookId = json['cookId'];
    mealName = json['mealName'];
    kcalories = json['kcalories'];
    description = json['description'];
    availablePortion = json['availablePortion'];
    price = _toDouble(json['price']);
    imageUrls = json['imageUrls'].cast<String>();
    cook = json['cook'] != null ? new Cook.fromJson(json['cook']) : null;
  }

  double? _toDouble(dynamic value) {
    if (value == null) return null;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value);
    return null;
  }

}

class Cook {
  String? sId;
  String? cookName;
  String? profileImage;
  String? rating;

  Cook({this.sId, this.cookName, this.profileImage, this.rating});

  Cook.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    cookName = json['cookName'];
    profileImage = json['profileImage'];
    rating = json['rating']?.toString();
  }
}







class Meals {
  String? sId;
  Cook?  cookId;
  String? mealName;
  String? kcalories;
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
  List<String>? imageUrls;
  String? createdAt;
  String? updatedAt;

  Meals(
      {this.sId,
        this.cookId,
        this.kcalories,
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
        this.imageUrls,
        this.createdAt,
        this.updatedAt});

  Meals.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    cookId = json['cookId'] != null ?  Cook.fromJson(json['cookId']) : null;
    mealName = json['mealName'];
    kcalories = json['kcalories'];
    description = json['description'];
    cuisineName = json['cuisineName'];
    availablePortion = json['availablePortion'];
    dietaryCategories = json['dietaryCategories'];
    category = json['category'];
    fitnessFlow = json['fitnessFlow'];
    cheatFlow = json['cheatFlow'];
    timeForOrder = json['timeForOrder'];
    timeForPickUpFood = json['timeForPickUpFood'];

    // Convert to double, handling both int and double types
    pricePerPortion = _toDouble(json['pricePerPortion']);
    coldReheatPrice = _toDouble(json['coldReheatPrice']);
    price = _toDouble(json['price']);

    servedWarm = json['servedWarm'];

    ingredients = json['ingredients'] != null
        ? List<String>.from(json['ingredients'])
        : null;
    allergyInformation = json['allergyInformation'];
    location = json['location'];
    pickUpTime = json['pickUpTime'];
    offer = json['offer'];

    imageUrls = json['imageUrls'] != null
        ? List<String>.from(json['imageUrls'])
        : null;

    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  // Helper method to safely convert values to double
  double? _toDouble(dynamic value) {
    if (value == null) return null;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value);
    return null;
  }
}



class MealsDetailsModelData {
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
  List<String>? imageUrls;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? kcalories;
  int? rating;

  MealsDetailsModelData({
    this.sId,
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
    this.imageUrls,
    this.createdAt,
    this.updatedAt,
    this.iV,
    this.kcalories,
    this.rating,
  });

  MealsDetailsModelData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    cookId = json['cookId'];
    mealName = json['mealName'];
    description = json['description'];
    cuisineName = json['cuisineName'];

    // Handle int conversion
    availablePortion = json['availablePortion'] is String
        ? int.tryParse(json['availablePortion'])
        : json['availablePortion'];

    dietaryCategories = json['dietaryCategories'];
    category = json['category'];
    fitnessFlow = json['fitnessFlow'];
    cheatFlow = json['cheatFlow'];
    timeForOrder = json['timeForOrder'];
    timeForPickUpFood = json['timeForPickUpFood'];

    // Handle double conversion
    pricePerPortion = json['pricePerPortion'] is String
        ? double.tryParse(json['pricePerPortion'])
        : (json['pricePerPortion'] as num?)?.toDouble();

    servedWarm = json['servedWarm'];

    // Handle double conversion
    coldReheatPrice = json['coldReheatPrice'] is String
        ? double.tryParse(json['coldReheatPrice'])
        : (json['coldReheatPrice'] as num?)?.toDouble();

    // Handle list safely
    ingredients = json['ingredients'] != null
        ? List<String>.from(json['ingredients'])
        : null;

    allergyInformation = json['allergyInformation'];

    // Handle double conversion
    price = json['price'] is String
        ? double.tryParse(json['price'])
        : (json['price'] as num?)?.toDouble();

    location = json['location'];
    pickUpTime = json['pickUpTime'];
    offer = json['offer'];

    // Handle list safely
    imageUrls = json['imageUrls'] != null
        ? List<String>.from(json['imageUrls'])
        : null;

    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];

    // Handle int conversion
    iV = json['__v'] is String
        ? int.tryParse(json['__v'])
        : json['__v'];

    kcalories = json['kcalories']?.toString();

    // Handle int conversion
    rating = json['rating'] is String
        ? int.tryParse(json['rating'])
        : json['rating'];
  }
}