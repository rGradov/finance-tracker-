import 'package:finance_tracker/app/ui/navigation/main_navigation.dart';
import 'package:finance_tracker/app/ui/navigation/navigation_service.dart';
import 'package:finance_tracker/app/ui/shared/fill_button.dart';
import 'package:finance_tracker/app/ui/themes/app_theme.dart';
import 'package:flutter/material.dart';

import '../../../main.dart';

class SetupAccountScreen extends StatelessWidget {
  const SetupAccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      backgroundColor: AppColor.baseLight[100],
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Stack(
          children: [
            FractionallySizedBox(
              heightFactor: 0.35,
              child: FractionallySizedBox(
                widthFactor: orientation == Orientation.portrait ? 0.8 : 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: orientation == Orientation.portrait
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.center,
                  children: const [
                    Spacer(
                      flex: 3,
                    ),
                    Header(),
                    Spacer(
                      flex: 1,
                    ),
                    SubHeader(),
                  ],
                ),
              ),
            ),

            /// Translate me
            const NextButton(
              text: "Let's go",
            ),
          ],
        ),
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      /// TODO: translate me
      'Let’s setup your account!',
      style: TextStyle(
          color: AppColor.baseDark[50],
          fontFamily: 'Inter',
          fontWeight: FontWeight.w500,
          fontSize: 36),
    );
  }
}

class SubHeader extends StatelessWidget {
  const SubHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      /// TODO: translate me
      "Account can be your bank, credit card or your wallet.",
      style: TextStyle(
          color: AppColor.baseDark[50],
          fontFamily: 'Inter',
          fontWeight: FontWeight.w500,
          fontSize: 14),
    );
  }
}

class NextButton extends StatelessWidget {
  final String text;

  const NextButton({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FillButton(
        text: text,
        action: () => getIt<NavigationService>()
            .mainNavigateTo(name: AppRoutes.addedNewAccount),
        routeName: AppRoutes.addedNewAccount);
  }
}
