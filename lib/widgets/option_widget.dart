import 'package:flutter/cupertino.dart';

import '../presentation/main/question_screen.dart';
import '../utility/category_detail_list.dart';

class OptionWidget extends StatelessWidget {
  const OptionWidget({Key? key,
    required this.widget,
    required this.option,
    required this.onTap,
    required this.optionColor})
      : super(key: key);

  final QuestionsScreen widget;
  final String option;
  final VoidCallback onTap;
  final Color optionColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
        alignment: Alignment.center,
        height: 50,
        width: MediaQuery
            .of(context)
            .size
            .width,
        decoration: BoxDecoration(
          color: optionColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          option,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: categoryDetailList[widget.categoryIndex].textColor,
          ),
        ),
      ),
    );
  }
}