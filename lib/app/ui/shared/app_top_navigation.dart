import 'package:finance_tracker/app/ui/themes/app_theme.dart';
import 'package:finance_tracker/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TopNavigation extends StatelessWidget {
  final String headerText;
  final bool isBlack;
  const TopNavigation({Key? key,required this.headerText, this.isBlack = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 64),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
               _TopNavigationBackButton(
                isBlack: isBlack,
              ),

              /// TODO: translate me extract me
              Text(
                headerText,
                style: TextStyle(
                    color: isBlack?Colors.black:AppColor.baseLight[80],
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    fontSize: 18),
              ),
              const SizedBox(
                width: 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}
/// How it should work => if we change the account type we can change it
/// in header of the top Navigation example: Added new Bank/Wallet/Credit Card
class _TopNavigationBackButton extends StatelessWidget {
  final bool isBlack;
  const _TopNavigationBackButton({Key? key,this.isBlack =false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// TODO: change to something beautifully
    return InkWell(
      onTap: () => Navigator.pop(context),
      child: RotatedBox(
        quarterTurns: 2,
        child: SvgPicture.asset(
          AppIcons.arrowRight,
          width: 16,
          height: 16,
          color: isBlack?Colors.black:AppColor.baseLight[80],
        ),
      ),
    );
  }
}