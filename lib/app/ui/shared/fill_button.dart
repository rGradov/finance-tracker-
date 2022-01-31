import 'package:finance_tracker/app/ui/themes/app_theme.dart';
import 'package:flutter/material.dart';

class FillButton extends StatelessWidget {
  /// FIXME: change my name ( next route)
  final String routeName;
  final String text;
  final bool needPadding;
  final Color? color;
  final Color? textColor;
  final void Function()? action;

  const FillButton(
      {Key? key,
        this.action,
        this.textColor,
        this.color,
      required this.text,
      required this.routeName,
      this.needPadding = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _style = TextStyle(
        color: textColor??AppColor.baseLight[80],
        fontFamily: 'Inter',
        fontWeight: FontWeight.w600,
        fontSize: 18);
    return GestureDetector(
      onTap: action,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            constraints: const BoxConstraints(maxHeight: 60),
            decoration: BoxDecoration(
              color:color?? AppColor.violet[100]!,
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: Center(
              child: Text(
                text,
                style: _style,
              ),
            ),
          ),
          needPadding
              ? const SizedBox(
                  height: 30,
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
