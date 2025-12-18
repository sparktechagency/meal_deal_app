class MealModelData {
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

  MealModelData(
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
        this.imageUrls,
        this.createdAt,
        this.updatedAt});

  MealModelData.fromJson(Map<String, dynamic> json) {
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