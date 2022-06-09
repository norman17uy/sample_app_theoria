import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String buttonLabel;
  final double? width;
  final VoidCallback onButtonPressed;
  const CustomButton({
    Key? key,
    required this.buttonLabel,
    this.width,
    required this.onButtonPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: width ?? MediaQuery.of(context).size.width,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: Colors.blue,
              padding: const EdgeInsets.symmetric(vertical: 20)),
          onPressed: onButtonPressed,
          child: Text(buttonLabel),
        ),
      ),
    );
  }
}
