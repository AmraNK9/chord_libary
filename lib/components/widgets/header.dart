import 'package:chord_libary/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Header extends StatelessWidget {
  const Header({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.header,
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomIconBtn(
                onPressed: () {},
                iconData: FontAwesomeIcons.sort,
              ),
              const SizedBox(
                width: 4,
              ),
              CustomIconBtn(
                onPressed: () {},
                iconData: FontAwesomeIcons.filter,
              )
            ],
          )
        ],
      ),
    );
  }
}

class CustomIconBtn extends StatelessWidget {
  const CustomIconBtn({
    super.key,
    required this.iconData,
    required this.onPressed,
  });
  final IconData iconData;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onPressed,
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              // border: Border.all(
              //   color: Colors.grey,
              // ),
              borderRadius: BorderRadius.circular(18)),
          clipBehavior: Clip.antiAlias,
          padding: const EdgeInsets.all(8),
          child: Icon(
            iconData,
            color: AppColors.headerIcon,
            size: AppDimans.headerIconSize,
          ),
        ));
  }
}
