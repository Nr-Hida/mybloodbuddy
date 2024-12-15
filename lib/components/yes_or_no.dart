import 'package:flutter/material.dart';
import "package:mybb/utils/enums.dart";

class YesOrNoWidget extends StatefulWidget {
  YesOrNo question;
  void Function(YesOrNo?) parentSetState;

  YesOrNoWidget({
    super.key,
    required this.question,
    required this.parentSetState,
  });

  @override
  State<YesOrNoWidget> createState() => _YesOrNoWidgetState();
}

class _YesOrNoWidgetState extends State<YesOrNoWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio<YesOrNo>(
          activeColor: Colors.red.shade900,
          value: YesOrNo.yes,
          groupValue: widget.question,
          onChanged: (YesOrNo? value) {
            widget.parentSetState(value);
          },
        ),
        const Text("Yes"),
        Radio<YesOrNo>(
          activeColor: Colors.red.shade900,
          value: YesOrNo.no,
          groupValue: widget.question,
          onChanged: (YesOrNo? value) {
            widget.parentSetState(value);
          },
        ),
        const Text("No"),
      ],
    );
  }
}