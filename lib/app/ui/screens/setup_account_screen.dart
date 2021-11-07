import 'package:finance_tracker/app/ui/themes/app_theme.dart';
import 'package:flutter/material.dart';

class SetupAccountScreen extends StatelessWidget {
  const SetupAccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColor.baseLight[100],
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Stack(
          children:  [
            FractionallySizedBox(
              heightFactor: 0.35,
              child: FractionallySizedBox(
                widthFactor: 0.8,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children:const [
                    Spacer(flex: 3,),
                    Header(),
                    Spacer(flex: 1,),
                    SubHeader(),
                  ],
                ),
              ),
            ),
            const NextButton(),
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
    return  Text('Let’s setup your account!',style:TextStyle(
        color: AppColor.baseDark[50],
        fontFamily: 'Inter',
        fontWeight: FontWeight.w500,
        fontSize: 36),);
  }
}
class SubHeader extends StatelessWidget {
  const SubHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Text("Account can be your bank, credit card or your wallet.",style:TextStyle(
        color: AppColor.baseDark[50],
        fontFamily: 'Inter',
        fontWeight: FontWeight.w500,
        fontSize: 14),);
  }
}

class NextButton extends StatelessWidget {
  const NextButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          constraints: const BoxConstraints(maxHeight: 56),
          color: Colors.yellow,
        ),
       const  SizedBox(height: 30,),
      ],
    );
  }
}



