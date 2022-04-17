import 'package:flutter/material.dart';
import 'package:get/get.dart';

const Color backgroundColor = Color(0xffebeaef);

void showSnackBar(String text) {
  Get.showSnackbar(
    GetSnackBar(
      messageText: Text(
        text,
        style: const TextStyle(
          color: Colors.black87,
        ),
      ),
      backgroundColor: Colors.grey,
      borderRadius: 25,
      margin: const EdgeInsets.all(24),
      duration: const Duration(milliseconds: 1200),
    ),
  );
}
