import 'package:finance_tracker/app/ui/themes/app_theme.dart';
import 'package:finance_tracker/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Header == Navigation arrow? and Name
///
///AnimatedContainer ->Two DropDowns -> type? display something and change the
/// height of Animated Container
/// continue button with validations ()
///
/// */
///
/// Important to trace this account types
enum AccountTypes { wallet, creditCard, bank }

class AddedNewAccountScreen extends StatelessWidget {
  const AddedNewAccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.violet[100]!,
      body: SafeArea(
        child: SizedBox.expand(
          child: Column(
            children: const [
              TopNavigation(),
            ],
          ),
        ),
      ),
    );
  }
}
/// TODO: extract it because we use it at the same screen's
class TopNavigation extends StatelessWidget {
  const TopNavigation({Key? key}) : super(key: key);

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
              const TopNavigationBackButton(),
              /// TODO: translate me extract me
              Text('Added new Account',style:TextStyle(
                  color: AppColor.baseLight[80],
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  fontSize: 18),),
              const SizedBox(width: 10,)
            ],
          ),
        ),
      ),
    );
  }
}

/// How it should work => if we change the account type we can change it
/// in header of the top Navigation example: Added new Bank/Wallet/Credit Card
class TopNavigationBackButton extends StatelessWidget {
  const TopNavigationBackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// TODO: change to something beautifully
    return  InkWell(
      onTap:()=>Navigator.pop(context),
      child: RotatedBox(
          quarterTurns: 2,
          child: SvgPicture.asset(AppIcons.arrowRight,width: 16,height: 16,),),
    );
  }
}

