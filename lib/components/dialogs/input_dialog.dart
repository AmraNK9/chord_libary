import 'package:chord_libary/core/extensions/navigator.dart';
import 'package:flutter/material.dart';

Future<dynamic> showInputDialog(BuildContext context,
    {String? initialValue, String? title, String? btnLabel}) {
  return showDialog(
      context: context,
      builder: (context) {
        final controller = TextEditingController();
        controller.text = initialValue ?? '';
        return Dialog(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title ?? "Title",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      GestureDetector(
                          onTap: () {
                            context.pop();
                          },
                          child: const Icon(Icons.cancel))
                    ],
                  ),
                  // ConstWidgets.sizedBoxHeightL,
                  const SizedBox(
                    height: 16,
                  ),

                  TextField(
                    controller: controller,
                    decoration:
                        const InputDecoration(border: OutlineInputBorder()),
                  ),
                  // ConstWidgets.sizedBoxHeight,
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop(controller.text);
                        },
                        child: Text(btnLabel ?? 'Save'),
                      ))
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      });
}
