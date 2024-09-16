import 'package:flutter/material.dart';
import 'package:auth_app/utils/constant.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.label, this.onPressed});

  final String label;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 50,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white, // Solid white background for the button container
          borderRadius: BorderRadius.circular(30), // Rounded corners
          boxShadow: [ // Add shadow to make it pop
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent, // Transparent button to let the container's color show
            elevation: 0, // No button shadow to avoid conflict with the container's shadow
            foregroundColor: const Color(0xffae1c8e), // Text color
          ),
          onPressed: onPressed,
          child: Text(
            label,
            style: montserratBody.copyWith(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
