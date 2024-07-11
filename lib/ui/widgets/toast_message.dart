import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class ToastMessage {
  const ToastMessage(
      {required this.context, required this.type, required this.message});
  final BuildContext context;
  final ToastificationType type;
  final String message;
  toastCustom() {
    return toastification.show(
      context: context,
      type: type,
      style: ToastificationStyle.flatColored,
      title: const Text('Mega Mall'),
      description: Text(message.toString()),
      alignment: Alignment.topCenter,
      autoCloseDuration: const Duration(seconds: 4),
      borderRadius: BorderRadius.circular(12.0),
      boxShadow: lowModeShadow,
    );
  }
}
