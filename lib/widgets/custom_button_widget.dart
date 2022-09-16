import 'package:flutter/material.dart';
import 'package:food_pe/constant/dimens.dart';

class CustomButtonWidget extends StatelessWidget {
  final Color textColor;
  final Color btnColor;
  final bool isLoading;
  final bool disabled;
  final Widget child;
  final VoidCallback onPressed;

  const CustomButtonWidget(
      {Key? key,
      this.textColor = Colors.white,
      this.btnColor = const Color.fromARGB(255, 254, 229, 76),
      this.disabled = false,
      this.isLoading = false,
      required this.onPressed,
      required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: disabled ? null : onPressed,
        style: ElevatedButton.styleFrom(
            primary: btnColor,
            minimumSize: const Size.fromHeight(Dimens.button_height),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Dimens.radius))),
        child: isLoading ? const CircularProgressIndicator() : child);
  }
}
