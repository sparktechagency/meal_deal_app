import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meal_deal_app/app/utils/app_colors.dart';
import 'package:meal_deal_app/feature/home/widgets/cart_section_cook_widget.dart';
import 'package:meal_deal_app/widgets/chat_card.dart';
import 'package:meal_deal_app/widgets/widgets.dart';

class ChatInboxScreen extends StatefulWidget {
  const ChatInboxScreen({super.key});

  @override
  State<ChatInboxScreen> createState() => _ChatInboxScreenState();
}

class _ChatInboxScreenState extends State<ChatInboxScreen> {
  final TextEditingController _messageController = TextEditingController();

  /// Dummy Chat List
  final List<Map<String, dynamic>> _dummyMessages = [
    {"text": "Hey! How are you?", "time": "10:20 AM", "isMe": false},
    {"text": "I'm good, what about you?", "time": "10:22 AM", "isMe": true},
    {
      "text": "Doing well, thanks for asking!",
      "time": "10:25 AM",
      "isMe": false,
    },
    {"text": "Are you free this evening?", "time": "10:28 AM", "isMe": false},
    {"text": "Yes, I am. Any plans?", "time": "10:30 AM", "isMe": true},
    {"text": "Let’s catch up at the café.", "time": "10:32 AM", "isMe": false},
    {"text": "Perfect, see you then!", "time": "10:35 AM", "isMe": true},
  ];

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      paddingSide: 0,
      appBar: CustomAppBar(title: 'Order # 23241232'),
      body: Column(
        children: [
          CartSectionCookWidget(radiusAll: 0),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.w),
              itemCount: _dummyMessages.length,
              itemBuilder: (context, index) {
                final message = _dummyMessages[index];
                return ChatBubbleMessage(
                  text: message["text"],
                  time: message["time"],
                  isMe: message["isMe"],
                );
              },
            ),
          ),
          _buildMessageSender(),
        ],
      ),
    );
  }

  Widget _buildMessageSender() {
    return CustomTextField(
      contentPaddingVertical: 16.h,
      contentPaddingHorizontal: 16.h,
      border: InputBorder.none,
      filColor: Colors.white,
      validator: (_) => null,
      controller: _messageController,
      hintextSize: 14.sp,
      hintText: 'Type your reply here...',
      suffixIcon: IconButton(
        onPressed: () {
          if (_messageController.text.isNotEmpty) {
            setState(() {
              _dummyMessages.add({
                "text": _messageController.text,
                "time": "Now",
                "isMe": true,
              });
            });
            _messageController.clear();
          }
        },
        icon: CustomContainer(
          radiusAll: 8.r,
          paddingVertical: 10.r,
          paddingHorizontal: 16.r,
          color: AppColors.primaryColor,
          child: CustomText(text: 'Send'.toUpperCase(), color: Colors.white),
        ),
      ),
    );
  }
}
