import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../custom_assets/assets.gen.dart';

class HelperData {


  static final List<Map<String, dynamic>> onboardingData = [
    {
      "image": Assets.images.img.image(height: 250.h,width: 250.w),
      "title": "Explore",
      "subtitle": "Buyers can explore a variety of meal options from different sellers, customize, and place orders for delivery. Sellers can showcase their menu, manage orders, and enhance offerings based on customer feedback."
    },
    {
      "image": Assets.images.img1.image(height: 250.h,width: 250.w),
      "title": "Order",
      "subtitle": " User can browse through various food options, customize their meal, and add it to their cart. Once the order is confirmed, the seller will receive it and begin preparation."
    },
    {
      "image": Assets.images.img2.image(height: 250.h,width: 250.w),
      "title": "Enjoy",
      "subtitle": "A Switzerland inspired recipe that is sure to add a little fun to your dinner table."
    },
  ];


  /// fake data
  static final List<Map<String, dynamic>> notifications = [
    {'name': 'Annette Black', 'message': 'Match request', 'date': DateTime.now(), 'type': 'request'},
    {'name': 'Annette Black', 'message': 'Commented on your post', 'date': DateTime.now(), 'type': 'comment'},
    {'name': 'Annette Black', 'message': 'Match request', 'date': DateTime.now().subtract(Duration(days: 1)), 'type': 'request'},
  ];




  static List<Map<String, dynamic>> messages = [
    {
      'text': 'Hey, how are you?',
      'isMe': true,
      'time': DateTime.now().subtract(Duration(minutes: 5)),
      'status': 'seen',
    },
    {
      'text': 'I am good, thanks! What about you?',
      'isMe': false,
      'time': DateTime.now().subtract(Duration(minutes: 3)),
      'status': 'seen',
    },
    {
      'text': 'I am doing great, working on a new project.',
      'isMe': true,
      'time': DateTime.now().subtract(Duration(minutes: 1)),
      'status': 'seen',
    },
    {
      'text': 'That sounds interesting!',
      'isMe': false,
      'time': DateTime.now(),
      'status': 'delivered',
    },
  ];


  static final List<Map<String, dynamic>> category = [
    {
      "title": "Turkish",
      "image": Assets.images.img.image(),
      "rating": 3.5,
      "price": '12-15',
    },
    {
      "title": "American",
      "image": Assets.images.img1.image(),
      "rating": 3.5,
      "price": '12-15',
    },
    {
      "title": "Mexican",
      "image": Assets.images.img2.image(),
      "rating": 3.5,
      "price": '12-15',
    },{
      "title": "Chinese",
      "image": Assets.images.img1.image(),
      "rating": 3.5,
      "price": '12-15',
    },{
      "title": "Turkish",
      "image": Assets.images.img.image(),
      "rating": 3.5,
      "price": '12-15',
    },
  ];

  static final List<Map<String, dynamic>> categoryItem = [
    {
      "title": "Dietary categories",
      "items": ["Vegan", "Vegetarian", "Halal", "Gluten Free"]
    },
    {
      "title": "Category",
      "items": ["Main", "Dessert", "Snacks", "Drinks", "Seafood"]
    },
    {
      "title": "Fitness Flow",
      "items": ["Protein", "Low-Carbs", "Smoothies"]
    },
    {
      "title": "Cheat Flow",
      "items": ["Comfort", "Sweet", "Street Food"]
    },
  ];

  static final List<String> cuisines = [
    "Italian", "Swiss", "Asian", "Mexican", "American"
  ];


  static final List<Map<String, dynamic>> products = [
    {
      "title": "Lotteria - 124 Sandiago",
      "author": "Leslie Alexander",
      "authorImage": "",
      "image": Assets.images.img.image(),
      "rating": 4.5,
      "reviews": 232,
      "distance": "1.3 km",
      "kcal": 450,
      "portions": 3,
    },
    {
      "title": "Lotteria - 124 Sandiago",
      "author": "Guy Hawkins",
      "authorImage": "",
      "image": Assets.images.img1.image(),
      "rating": 3.5,
      "reviews": 42,
      "distance": "1.3 km",
      "kcal": 450,
      "portions": 3,
    },
    {
      "title": "Lotteria - 124 Sandiago",
      "author": "Leslie Alexander",
      "authorImage": "",
      "image": Assets.images.img.image(),
      "rating": 4.5,
      "reviews": 232,
      "distance": "1.3 km",
      "kcal": 450,
      "portions": 3,
    },
    {
      "title": "Lotteria - 124 Sandiago",
      "author": "Guy Hawkins",
      "authorImage": "",
      "image": Assets.images.img1.image(),
      "rating": 3.5,
      "reviews": 42,
      "distance": "1.3 km",
      "kcal": 450,
      "portions": 3,
    },
    {
      "title": "Lotteria - 124 Sandiago",
      "author": "Leslie Alexander",
      "authorImage": "",
      "image": Assets.images.img.image(),
      "rating": 4.5,
      "reviews": 232,
      "distance": "1.3 km",
      "kcal": 450,
      "portions": 3,
    },
    {
      "title": "Lotteria - 124 Sandiago",
      "author": "Guy Hawkins",
      "authorImage": "",
      "image": Assets.images.img1.image(),
      "rating": 3.5,
      "reviews": 42,
      "distance": "1.3 km",
      "kcal": 450,
      "portions": 3,
    },
    {
      "title": "Lotteria - 124 Sandiago",
      "author": "Leslie Alexander",
      "authorImage": "",
      "image": Assets.images.img.image(),
      "rating": 4.5,
      "reviews": 232,
      "distance": "1.3 km",
      "kcal": 450,
      "portions": 3,
    },
    {
      "title": "Lotteria - 124 Sandiago",
      "author": "Guy Hawkins",
      "authorImage": "",
      "image": Assets.images.img1.image(),
      "rating": 3.5,
      "reviews": 42,
      "distance": "1.3 km",
      "kcal": 450,
      "portions": 3,
    },
  ];


  static final List<Map<String, dynamic>> restaurants = [
    {
      "name": "Jacob Jones",
      "image": Assets.images.cook.image(),
      "time": "10AM - 10PM",
      "rating": 4.5,
      "reviews": 232,
      "distance": "1.3 km"
    },
    {
      "name": "Eleanor Pena",
      "image": Assets.images.cook2.image(),
      "time": "10AM - 10PM",
      "rating": 4.5,
      "reviews": 232,
      "distance": "1.3 km"
    },

    {
      "name": "Jacob Jones",
      "image": Assets.images.cook.image(),
      "time": "10AM - 10PM",
      "rating": 4.5,
      "reviews": 232,
      "distance": "1.3 km"
    },
    {
      "name": "Eleanor Pena",
      "image": Assets.images.cook2.image(),
      "time": "10AM - 10PM",
      "rating": 4.5,
      "reviews": 232,
      "distance": "1.3 km"
    },
  ];
  static final List<Map<String, dynamic>> restaurantsCard = [
    {
      "name": "Jacob Jones",
      "image": Assets.images.cook.path,
      'item' : 2
    },
    {
      "name": "Eleanor Pena",
      "image": Assets.images.cook2.path,
      'item' : 7
    },

    {
      "name": "Jacob Jones",
      "image": Assets.images.cook.path,
      'item' : 3

    },
    {
      "name": "Eleanor Pena",
      "image": Assets.images.cook2.path,
      'item' : 5

    },
  ];




  static List<CartItem> cartItems = [
    CartItem(name: 'Fondue', price: 12.52, rating: 4.2, reviewCount: 232),
    CartItem(name: 'Pizza', price: 8.99, rating: 4.5, reviewCount: 150),
    CartItem(name: 'Burger', price: 15.25, rating: 4.0, reviewCount: 98),
    CartItem(name: 'Pasta', price: 10.50, rating: 4.3, reviewCount: 180),
    CartItem(name: 'Salad', price: 6.75, rating: 4.1, reviewCount: 76),
  ];




}

class CartItem {
  String name;
  double price;
  double rating;
  int reviewCount;
  int quantity;
  CartItem({
    required this.name,
    required this.price,
    required this.rating,
    required this.reviewCount,
    this.quantity = 1,
  });
}
