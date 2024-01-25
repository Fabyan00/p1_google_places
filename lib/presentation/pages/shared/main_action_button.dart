import 'package:flutter/material.dart';
import 'package:p1_places_api/presentation/pages/shared/body_widget.dart';

class MainActionButton extends StatelessWidget {
  MainActionButton({super.key, this.width = 200, this.height = 50, required this.text, required this.action});

  double width, height;
  final String text;
  final Function()? action;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.black54
      ),
      child: TextButton(
        onPressed: action, 
        child: BodyWidget(text: text, fontColor: Colors.white,)
      ),
    );
  }
}