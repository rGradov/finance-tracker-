import 'package:finance_tracker/app/ui/navigation/main_navigation.dart';
import 'package:finance_tracker/app/ui/shared/fill_button.dart';
import 'package:finance_tracker/app/ui/themes/app_theme.dart';
import 'package:finance_tracker/app/view_model/added_new_wallet_vm.dart';
import 'package:finance_tracker/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

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
              Text(
                'Added new wallet',
                style: TextStyle(
                    color: AppColor.baseLight[80],
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
class TopNavigationBackButton extends StatelessWidget {
  const TopNavigationBackButton({Key? key}) : super(key: key);

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
        ),
      ),
    );
  }
}

/// FIXME: change my name ( make it more better )
/// it should be rounded container with dropdown and inputted field
///
class _InputWalletData extends StatelessWidget {
  const _InputWalletData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

/// FIXME: if this widget not provide the option to input balance value rename it
class _BalanceInput extends StatelessWidget {
  const _BalanceInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

/// TODO: add reusable ui for this button form let's go screen
/// TODO: added opacity to validate this button
class _ContinueButton extends StatelessWidget {
  const _ContinueButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool showButton = context
        .select((AddedNewWalletViewModel vm) => vm.continueButtonIsVisible);
    return AnimatedOpacity(
      opacity: showButton ? 1 : 0.5,
      duration: const Duration(milliseconds: 250),
      child: const FillButton(
        text: 'continue',
        routeName: AppRoutes.addedNewAccount,
      ),
    );
  }
}
