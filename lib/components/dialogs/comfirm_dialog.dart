import 'package:chord_libary/core/constants.dart';
import 'package:flutter/material.dart';

Future<bool?> showConfirmDialog(BuildContext context,
    {String? label,
    String? title,
    bool hideCancel = false,
    Color? labelColor = Colors.white}) async {
  return await showDialog<bool?>(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            padding: const EdgeInsets.all(16),
            width: 250,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title ?? 'Are you sure?',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(label ?? 'Are you sure to exist?',
                    style: TextStyle(
                      color: labelColor,
                    )),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context, false);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: double.infinity,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: AppColors.primary),
                          ),
                          child: const Text(
                            'No',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 30),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context, true);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: double.infinity,
                          height: 45,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: AppColors.primary),
                          ),
                          child: Text(
                            'Yes',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      });
}
