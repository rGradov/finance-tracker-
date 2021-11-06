import 'package:finance_tracker/app/provider/pin_code_provider.dart';
import 'package:finance_tracker/app/ui/themes/app_theme.dart';
import 'package:finance_tracker/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class PinScreen extends StatelessWidget {
  const PinScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PinCodeProvider(),
      child: Scaffold(
        backgroundColor: AppColor.violet[100],
        body: SafeArea(
          child: Column(
            /// DON'T CHANGE THIS FLEX VALUES
            children: const [
              Expanded(flex: 1, child: Header()),
              Expanded(flex: 3, child: Circles()),
              Spacer(flex: 2,),
              Expanded(flex: 5, child: ButtonView()),
            ],
          ),
        ),
      ),
    );
  }
}

class Circles extends StatelessWidget {
  const Circles({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<PinCodeProvider>(builder: (_, provider, __) {
      return ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),

          itemBuilder: (_, idx) {
            return CircleHidingNumber(idx: idx);
          },
          separatorBuilder: (_, idx) {
            return const SizedBox(
              width: 16,
              height: 16,
            );
          },
          scrollDirection: Axis.horizontal,
          itemCount: 4);
    });
  }
}

/// how it works?
class CircleHidingNumber extends StatelessWidget {
  final int idx;
  const CircleHidingNumber({Key? key, required this.idx}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<PinCodeProvider>(builder: (_, provider, __) {
      return AnimatedContainer(
        curve: Curves.decelerate,
        duration: const Duration(milliseconds: 300),
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: provider.pin.length <= idx
              ? Colors.white.withOpacity(0.4)
              : AppColor.baseLight[80],
        ),
      );
    });
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

          child: Text(
            "Let’s  setup your PIN",
            /// TODO: extract me
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

/// how it works? we listen the value in provider
/// and then if the pin length =4 we displayed this button
/// this button remove last number from pin
class RemoveButton extends StatelessWidget {
  const RemoveButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<PinCodeProvider>(builder: (_, provider, __) {
      return AnimatedOpacity(
        duration: const Duration(milliseconds: 300),
        opacity: provider.getPin.isNotEmpty ? 1 : 0.3,
        child: InkWell(
            onTap: provider.removeValue,
            child: Transform.scale(
                scale: 0.8,
                child: SvgPicture.asset(
                  AppIcons.close,
                  color: AppColor.baseLight[80],
                ))),
      );
    });
  }
}

class Arrow extends StatelessWidget {
  const Arrow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<PinCodeProvider>(
      builder: (_, provider, __) {
        return AnimatedOpacity(
          duration: const Duration(milliseconds: 300),
          opacity: provider.isValid ? 1 : 0.3,
          child: InkWell(
            onTap: () {
              if (provider.isValid) {}
            },
            child: Transform.scale(
              scale: 0.4,
              child: SvgPicture.asset(AppIcons.arrowRight),
            ),
          ),
        );
      },
    );
  }
}

/// FIXME: change name
class ButtonView extends StatelessWidget {
  const ButtonView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return SizedBox.expand(
      child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: orientation == Orientation.portrait ? 3 : 6,
            childAspectRatio: (125 / 90),
            crossAxisSpacing: 30.0,
            mainAxisSpacing: 4.0,
          ),
          itemCount: 12,
          itemBuilder: (_, idx) {
            ///FIXME: help!!! refactor me
            if (orientation == Orientation.portrait) {
              if (idx == 9) {
                return const RemoveButton();
              } else if (idx == 11) {
                return const Arrow();
              } else {
                return NumberButton(number: idx == 10 ? 0 : idx + 1);
              }
            } else {
              if (idx == 10) {
                return const NumberButton(number: 0);
              } else if (idx == 11) {
                return const Arrow();
              } else if (idx == 6) {
                return const RemoveButton();
              } else {
                return NumberButton(number: idx <= 6 ? idx + 1 : idx);
              }
            }
          }),
    );
  }
}

class NumberButton extends StatelessWidget {
  final int number;
  const NumberButton({Key? key, required this.number}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<PinCodeProvider>(
      builder: (_, provider, __) {
        return InkWell(
          onTap: () {
            provider.setValue(number);
          },
          child: ColoredBox(
            color: Colors.transparent,
            child: Center(
              child: Text(
                number.toString(),
                style: TextStyle(
                    color: AppColor.baseLight[80],
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                    fontSize: 48),
              ),
            ),
          ),
        );
      },
    );
  }
}
