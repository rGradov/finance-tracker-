import 'package:finance_tracker/app/repository/local_auth_repository.dart';
import 'package:finance_tracker/app/repository/user_code_repo.dart';
import 'package:finance_tracker/app/ui/navigation/main_navigation.dart';
import 'package:finance_tracker/app/ui/themes/app_theme.dart';
import 'package:finance_tracker/app/utils/app_screen_size.dart';
import 'package:finance_tracker/bloc/auth/local_auth_bloc.dart';
import 'package:finance_tracker/bloc/user/user_pin.dart';
import 'package:finance_tracker/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PinScreen extends StatelessWidget {
  const PinScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LocalAuthRepository _repository = LocalAuthRepository();
    final double _screenHeight = ScreenSize().screenHeight;
    return MultiBlocProvider(
      providers: [
        BlocProvider<LocalAuthCubit>(
          create: (_) => LocalAuthCubit(_repository)..checkAuth(),
          lazy: false,
        ),
      ],
      child: Scaffold(
        backgroundColor: AppColor.violet[100],
        body: const SafeArea(
          child: _BodyWrapper(),
        ),
      ),
    );
  }
}

class _BodyWrapper extends StatelessWidget {
  const _BodyWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final int _flex = ScreenSize().screenHeight < 700 ? 1 : 2;
    return  BlocProvider<UserPinCubit>(
      create: (_) => UserPinCubit(
        repository: UserRepo(),
        localAuthCubit:BlocProvider.of<LocalAuthCubit>(context),
      ),
      child: Column(
        children: [
          const Expanded(flex: 1, child: _Header()),
          const Expanded(flex: 3, child: _PinCircles()),
          Spacer(
            flex: _flex,
          ),
          const Expanded(flex: 5, child: CustomNumberKeyboard()),
        ],
      ),
    );
  }
}


/// this circles used for inputting pin code: in nutshell it work like this
/// we click on one number button  => see fill circle if click on [ X ] remove
/// button see circle with opacity
class _PinCircles extends StatelessWidget {
  const _PinCircles({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (_, idx) {
          return CircleHidingNumber(idx: idx);
        },
        separatorBuilder: (_, idx) {
          if (orientation == Orientation.portrait) {
            return const SizedBox(
              width: 16,
              height: 16,
            );
          } else {
            return const SizedBox(
              width: 64,
              height: 64,
            );
          }
        },
        scrollDirection: Axis.horizontal,
        itemCount: 4);
  }
}

class CircleHidingNumber extends StatefulWidget {
  final int idx;

  const CircleHidingNumber({Key? key, required this.idx}) : super(key: key);

  @override
  _CircleHidingNumberState createState() => _CircleHidingNumberState();
}

class _CircleHidingNumberState extends State<CircleHidingNumber> {
  int _displayedCircle = 0;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserPinCubit, UserPinState>(
      listener: (_, state) {
        if (state is UserPinChanged) {
          _displayedCircle = state.displayedCircles;
        }
        if (state is UserPinEmpty) {
          _displayedCircle = 0;
        }
      },
      builder: (_, state) {
        return AnimatedContainer(
          curve: Curves.decelerate,
          duration: const Duration(milliseconds: 300),
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _displayedCircle <= widget.idx
                ? Colors.white.withOpacity(0.4)
                : AppColor.baseLight[80],
          ),
        );
      },
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 100),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Text(
            /// TODO: translate me
            "Let’s  setup your PIN",

            /// TODO: extract me
            style: TextStyle(
                color: AppColor.baseLight[80],
                fontFamily: 'Inter',

                /// don't forget about me too
                fontWeight: FontWeight.w600,
                fontSize: 18),
          ),
        ),
      ),
    );
  }
}

/// how it works? we listen the value in ViewModel
/// and then if the pin length =4 we displayed this button
/// this button remove last number from pin
class RemoveButton extends StatefulWidget {
  const RemoveButton({Key? key}) : super(key: key);

  @override
  _RemoveButtonState createState() => _RemoveButtonState();
}

class _RemoveButtonState extends State<RemoveButton> {
  bool _canInteract = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserPinCubit, UserPinState>(
      listener: (_, state) {
        if (state is UserPinChanged) {
          _canInteract = true;
          setState(() {});
        }
        if (state is UserPinEmpty) {
          _canInteract = false;
          setState(() {});
        }
      },
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 300),
        opacity: _canInteract ? 1 : 0.3,
        child: const _RemoveButton(),
      ),
    );
  }
}

class _RemoveButton extends StatelessWidget {
  const _RemoveButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userPinCubit = BlocProvider.of<UserPinCubit>(context);
    return InkWell(
      onTap: () => userPinCubit.onUserPinDecrement(),
      child: Transform.scale(
        scale: 0.8,
        child: SvgPicture.asset(
          AppIcons.close,
          color: AppColor.baseLight[80],
        ),
      ),
    );
  }
}

class NextButton extends StatelessWidget {
  const NextButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserPinCubit, UserPinState>(builder: (_, state) {
      return AnimatedOpacity(
        duration: const Duration(milliseconds: 300),
        opacity: state is UserPinCorrect ? 1 : 0.3,
        child: const _NextButton(),
      );
    });
  }
}

class _NextButton extends StatefulWidget {
  const _NextButton({Key? key}) : super(key: key);

  @override
  __NextButtonState createState() => __NextButtonState();
}

class __NextButtonState extends State<_NextButton> {
  bool _canNavigate = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserPinCubit, UserPinState>(
      listener: (_, state) {
        if (state is UserPinCorrect) {
          _canNavigate = true;
        }
        if (state is UserPinChanged) {
          _canNavigate = false;
        }
      },
      child: InkWell(
        onTap: () {
          if (_canNavigate) {
            Navigator.pushNamed(context, AppRoutes.setupAccountRoute);
          }
        },
        child: Transform.scale(
          scale: 0.4,
          child: SvgPicture.asset(AppIcons.arrowRight),
        ),
      ),
    );
  }
}

/// remove button and next button very similar (by code and logic) but i doesn't
/// wont to merge them into one Widget

/// FIXME: change name
class CustomNumberKeyboard extends StatelessWidget {
  const CustomNumberKeyboard({Key? key}) : super(key: key);

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
                return const NextButton();
              } else {
                return NumberButton(number: idx == 10 ? 0 : idx + 1);
              }
            } else {
              if (idx == 10) {
                return const NumberButton(number: 0);
              } else if (idx == 11) {
                return const NextButton();
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
    final userPinCubit = BlocProvider.of<UserPinCubit>(context);
    return InkWell(
      onTap: () => userPinCubit.onUserPinCodeIncrement(number),
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
  }
}
