import 'package:finance_tracker/app/ui/themes/app_theme.dart';
import 'package:flutter/material.dart';

class PinScreen extends StatelessWidget {
  const PinScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.violet[100],
      body: SafeArea(
        child: Column(
          children: const [
            Expanded(flex: 2, child: Header()),
            Expanded(
              flex: 5,
              child: Circles(),
            ),
            Expanded(flex: 12, child: ButtonView()),
          ],
        ),
      ),
    );
  }
}

class Circles extends StatelessWidget {
  const Circles({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          CircleAvatar(
            radius: 16,
            backgroundColor: Colors.blue,
          ),
          CircleAvatar(
            radius: 16,
            backgroundColor: Colors.blue,
          ),
          CircleAvatar(
            radius: 16,
            backgroundColor: Colors.blue,
          ),
          CircleAvatar(
            radius: 16,
            backgroundColor: Colors.blue,
          ),
        ],
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 100),
        child: Align(
          alignment: Alignment.bottomCenter,

          /// TODO: extract me
          child: Text(
            "Let’s  setup your PIN",
            style: TextStyle(
                color: AppColor.baseLight[80],
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                fontSize: 18),
          ),
        ),
      ),
    );
  }
}

class ButtonView extends StatelessWidget {
  const ButtonView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 30.0,
            mainAxisSpacing: 4.0,
          ),
          itemCount: 12,
          itemBuilder: (_, idx) {
           if(idx ==9){
             return const SizedBox();
           } else if (idx ==11) {
             return const Arrow();
           } else {
             return NumberButton(number: idx+1,);
           }
          }),
    );
  }
}
class Arrow extends StatelessWidget {
  const Arrow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  InkWell(
        onTap: (){
          print('arrow');
        },
        /// FIXME: change icon to arrow
        child:  const Icon(Icons.forward,));
  }
}


class NumberButton extends StatelessWidget {
  final int number;
  const NumberButton({Key? key, required this.number}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print(number.toString());
      },
      child: ColoredBox(
        color: Colors.transparent,
        child: Center(
          child: Text(
            number.toString(),
            style: TextStyle(
                color: AppColor.baseLight[80],
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                fontSize: 48),
          ),
        ),
      ),
    );
  }
}
