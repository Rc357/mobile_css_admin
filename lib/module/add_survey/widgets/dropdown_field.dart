import 'package:admin/enums/question_type_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:line_icons/line_icons.dart';

class AnswerTypeDropdown extends StatelessWidget {
  AnswerTypeDropdown({
    Key? key,
    required this.onChanged,
    required this.name,
  }) : super(key: key);

  final void Function(QuestionTypeEnum?) onChanged;
  final String name;

  final questionTypeAnswer = [
    QuestionTypeEnum.twoPointsCase,
    QuestionTypeEnum.fivePointsCase,
  ];

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      alignedDropdown: true,
      child: FormBuilderDropdown(
        name: name,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        onChanged: onChanged,
        validator: (value) {
          if (value == null) {
            return "Choose a type of questioner's answer";
          }
          return null;
        },
        items: questionTypeAnswer.map((answerType) {
          return DropdownMenuItem<QuestionTypeEnum>(
            value: answerType,
            child: answerType == QuestionTypeEnum.twoPointsCase
                ? Text(
                    answerType.description + ' (Agree or Disagree)',
                    style: Theme.of(context).textTheme.bodyLarge,
                  )
                : Text(
                    answerType.description +
                        ' (Excellent, Very Satisfactory, Satisfactory, Fair or Poor)',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
          );
        }).toList(),
        decoration: InputDecoration(
          label: Text('Choose what type of answer will be display'),
          border: const OutlineInputBorder(borderSide: BorderSide()),
        ),
        icon: const Icon(LineIcons.angleDown),
        dropdownColor: Colors.white,
      ),
    );
  }
}
