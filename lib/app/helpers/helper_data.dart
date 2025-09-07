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




}
