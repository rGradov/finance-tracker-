import 'package:finance_tracker/app/ui/themes/app_theme.dart';
import 'package:flutter/material.dart';

class FillButton extends StatelessWidget {
  /// FIXME: change my name ( next route)
  final String routeName;
  final String text;

  const FillButton({Key? key, required this.text, required this.routeName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, routeName),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            constraints: const BoxConstraints(maxHeight: 60),
            decoration: BoxDecoration(
              color: AppColor.violet[100]!,
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: Center(
              child: Text(
                text,
                style: TextStyle(
                    color: AppColor.baseLight[80],
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    fontSize: 18),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
