import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:meal_deal_app/controllers/auth/cook_registrations_controller.dart';
import 'package:meal_deal_app/models/cooks/hygiene_course_model_data.dart';
import 'package:meal_deal_app/widgets/widgets.dart';
import 'package:meal_deal_app/app/utils/app_colors.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final List<Quizzes> quizzes = Get.arguments['quizzes'] as List<Quizzes>;
  final String quizID = Get.arguments['quizID'] as String;
  final CookRegistrationsController  _registrationsController = Get.find<CookRegistrationsController>();


  @override
  Widget build(BuildContext context) {

    return CustomScaffold(
      appBar: CustomAppBar(
        centerTitle: true,
        title: "Quiz",
      ),
      body: GetBuilder<CookRegistrationsController>(
        builder: (ctrl) {
          if(quizzes.isEmpty){
            return Center(
              child: CustomText(
                text: "No quiz available",
                fontSize: 16.sp,
                color: Colors.grey[600],
              ),
            );
          }
          final currentQuiz = quizzes[ctrl.currentQuestionIndex];
          bool  isLastQuestion = ctrl.currentQuestionIndex == quizzes.length - 1;
          bool  hasAnswered = ctrl.userAnswers.containsKey(ctrl.currentQuestionIndex);

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Question Progress
                CustomText(
                  text: "Question ${ctrl.currentQuestionIndex + 1} of ${quizzes.length}",
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryColor,
                ),
                SizedBox(height: 16.h),

                // Question Text
                CustomText(
                  text: currentQuiz.question ?? "No question available",
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.darkColor,
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: 16.h),

                // Question Options
                if (currentQuiz.options != null && currentQuiz.options!.isNotEmpty)
                  ...currentQuiz.options!.asMap().entries.map((entry) {
                    final index = entry.key;
                    final option = entry.value;
                    final optionLabel = String.fromCharCode(65 + index);

                    return _buildOption(
                      optionLabel,
                      option.optionText ?? "",
                      option.sId ?? optionLabel,
                    );
                  }).toList()
                else
                  CustomText(
                    text: "No options available",
                    fontSize: 14.sp,
                    color: Colors.grey[600],
                  ),

                SizedBox(height: 40.h),

                Row(
                  children: [
                    if (ctrl.currentQuestionIndex > 0)
                      Expanded(
                        child: CustomButton(
                          onPressed: () => ctrl.previousQuestion(),
                          label: "Previous",
                        ),
                      ),
                    if (ctrl.currentQuestionIndex > 0) SizedBox(width: 16.w),
                    Expanded(
                      child: CustomButton(
                        onPressed: hasAnswered
                            ? (isLastQuestion
                            ? () => submitQuiz()
                            : () => ctrl.nextQuestion(quizzes.length))
                            : null,
                        label: ctrl.isLoadingQuiz ? 'Loading...' : isLastQuestion ? "Submit" : "Next",
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildOption(String optionLabel, String text, String value) {
    return GetBuilder<CookRegistrationsController>(
      builder: (controller) {
        return RadioListTile<String>(
          title: CustomText(
            text: "$optionLabel. $text",
            fontSize: 14.sp,
            color: Colors.grey[800],
            textAlign: TextAlign.start,
          ),
          value: value,
          groupValue: controller.userAnswers[controller.currentQuestionIndex],
          onChanged: (selectedValue) {
            controller.selectAnswer(selectedValue!);
          },
          activeColor: AppColors.primaryColor,
          contentPadding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
        );
      },
    );
  }




  void submitQuiz() {
    if (_registrationsController.userAnswers.length != quizzes.length) {
      showToast(
        "Please answer all questions before submitting",
      );
      return;
    }
    List<Map<String, dynamic>> formattedAnswers = [];

    _registrationsController.userAnswers.forEach((questionIndex, selectedAnswerId) {
      formattedAnswers.add({
        "questionId": quizzes[questionIndex].sId,
        "selectedAnswer": selectedAnswerId,
      });
    });

    _registrationsController.submitQuiz(
      answers: formattedAnswers,
      quizID: quizID,
    );
  }

}
