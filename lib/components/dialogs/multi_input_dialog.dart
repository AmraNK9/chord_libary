import 'package:chord_libary/core/extensions/navigator.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

Future<Values> showMultiInputDialog(BuildContext context, fields,
    {String? title}) async {
  final result = await showDialog(
    context: context,
    builder: (context) {
      List<Widget> fieldList = [];
      for (var element in fields) {
        fieldList.add(
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 8,
              ),
              TextField(
                controller: element.controller,
                decoration: InputDecoration(
                    isDense: true,
                    // border: const OutlineInputBorder(),
                    label:
                        (element.label != null) ? Text(element.label!) : null),
              ),
            ],
          ),
        );
      }
      return Dialog(
        child: SingleChildScrollView(
            child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              if (title != null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                        onTap: () {
                          context.pop();
                        },
                        child: const Icon(Icons.cancel))
                  ],
                ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: fieldList,
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  Expanded(
                      child: ElevatedButton(
                    onPressed: () {
                      List<FieldValue> valueList = [];
                      for (var element in fields) {
                        final value = FieldValue(
                          value: element.controller?.text,
                          label: element.label,
                          initialValue: element.initialValue,
                        );
                        valueList.add(value);
                      }

                      Navigator.of(context).pop(Values(values: valueList));
                    },
                    child: const Text('Save'),
                  ))
                ],
              )
            ],
          ),
        )),
      );
    },
  );

  if (result is Values) {
    return result;
  }
  throw Exception(
      "Throw Error From Multiple Input  Dialog\n Return type error");
}

class FieldModal {
  TextEditingController? controller;
  final String? label;
  final String? initialValue;

  FieldModal({this.controller, this.label, this.initialValue}) {
    controller = TextEditingController();
    controller!.text = initialValue ?? '';
  }
}

class FieldValue {
  final String? value;
  final String? label;
  final String? initialValue;

  FieldValue({
    this.initialValue,
    required this.value,
    this.label,
  });
}

class Values {
  final List<FieldValue> values;
  Values({required this.values});
  String? getValueByInitial(String initialValue) {
    final value = values
        .firstWhereOrNull((element) => element.initialValue == initialValue);
    return value?.value;
  }

  String? getValueByLabel(String label) {
    final value = values.firstWhereOrNull((element) => element.label == label);
    return value?.value;
  }
}
