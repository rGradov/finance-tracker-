import 'package:finance_tracker/analytics/analytics_repository.dart';
import 'package:finance_tracker/app/ui/navigation/main_navigation.dart';
import 'package:finance_tracker/app/ui/shared/fill_button.dart';
import 'package:finance_tracker/app/ui/themes/app_theme.dart';
import 'package:finance_tracker/resources/resources.dart';
import 'package:flutter/material.dart';

const List<String> HEADERS = [
  'Gain total control of your money',
  'Know where your money goes',
  'Planning ahead'
];
const List<String> IMAGES = [
  AppImages.onboardingTakeMoney,
  AppImages.onboardinListMoney,
  AppImages.onBoardingPlan,
];
const List<String> SUBHEADERS = [
  'Track your transaction easily,with categories and financial report',
  'Track your transaction easily,with categories and financial report ',
  'Setup your budget for each category so you in control'
];

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: _OnBoardingBodyWrapper(),
    );
  }
}

class _OnBoardingBodyWrapper extends StatefulWidget {
  const _OnBoardingBodyWrapper({Key? key}) : super(key: key);

  @override
  __OnBoardingBodyWrapperState createState() => __OnBoardingBodyWrapperState();
}

class __OnBoardingBodyWrapperState extends State<_OnBoardingBodyWrapper> {
  late final PageController _controller;
  late final AppAnalyticsRepository _analyticsRepository;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    _controller.addListener(_listener);
    _analyticsRepository = AppAnalyticsRepository();
    _analyticsRepository.logOnBoarding();
    super.initState();
  }

  void _listener() async {
    if (_controller.page == 2) {
      debugPrint('last');
      _analyticsRepository.onBoardingIsDone();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Column(
        children: [
          const Spacer(
            flex: 1,
          ),
          Expanded(
            flex: 4,
            child: PageView.builder(
              controller: _controller,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (_, idx) {
                return _OnBoardingElement(
                  idx: idx,
                );
              },
              itemCount: 3,
            ),
          ),
          const Spacer(
            flex: 1,
          ),
          Expanded(
              flex: 2,
              child: _OnBoardingButtonsWrapper(
                controller: _controller,
              )),

        ],
      ),
    );
  }
}

////////////////////////////////////////////////////////////////////////////////
////////////////<== OnBoarding Elements ==>/////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

class _OnBoardingElement extends StatelessWidget {
  final int idx;

  const _OnBoardingElement({Key? key, required this.idx}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 2,
            child: _OnBoardingImg(
          idx: idx,
        )),
        Expanded(
            child: _OnBoardingText(
          idx: idx,
        )),
      ],
    );
  }
}

class _OnBoardingImg extends StatelessWidget {
  final int idx;

  const _OnBoardingImg({Key? key, required this.idx}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(IMAGES[idx]);
  }
}

class _OnBoardingText extends StatelessWidget {
  final int idx;

  const _OnBoardingText({Key? key, required this.idx}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.7,
      alignment: Alignment.center,
      child: Column(
        children: [
          _OnBoardingHeader(
            text: HEADERS[idx],
          ),
          const SizedBox(
            height: 20,
          ),
          _OnBoardingSubHeader(
            text: SUBHEADERS[idx],
          ),
        ],
      ),
    );
  }
}

class _OnBoardingHeader extends StatelessWidget {
  final String text;

  const _OnBoardingHeader({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _style = TextStyle(
      color: AppColor.baseDark[50],
      fontSize: 32,
      fontWeight: FontWeight.w800,
      fontFamily: 'Inter',
    );
    return Text(
      text,
      style: _style,
      textAlign: TextAlign.center,
    );
  }
}

class _OnBoardingSubHeader extends StatelessWidget {
  final String text;

  const _OnBoardingSubHeader({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _style = TextStyle(
      color: AppColor.baseLight[20],
      fontSize: 16,
      fontWeight: FontWeight.w500,
      fontFamily: 'Inter',
    );
    return Text(
      text,
      style: _style,
      textAlign: TextAlign.center,
    );
  }
}

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
enum FillButtonStatus {
  next,
  signUp,
}

class _OnBoardingButtonsWrapper extends StatelessWidget {
  final PageController  controller;
  const _OnBoardingButtonsWrapper({Key? key,required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.95,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _OnBoardingFillButton(controller: controller,),
          const _OnBoardingLoginButton(),

        ],
      ),
    );
  }
}

class _OnBoardingLoginButton extends StatelessWidget {
  const _OnBoardingLoginButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FillButton(
      textColor:AppColor.violet[100]!,
        color: AppColor.violet[20],
        routeName: AppRoutes.loginRoute,
        text: 'Log in', action: (){
        Navigator.pushNamed(context, AppRoutes.loginRoute);
    },);
  }
}

class _OnBoardingFillButton extends StatefulWidget {
  final PageController controller;

  const _OnBoardingFillButton({Key? key, required this.controller})
      : super(key: key);

  @override
  __OnBoardingFillButtonState createState() => __OnBoardingFillButtonState();
}

class __OnBoardingFillButtonState extends State<_OnBoardingFillButton> {
  FillButtonStatus _status = FillButtonStatus.next;

  @override
  void initState() {
    widget.controller.addListener(_listener);
    super.initState();
  }

  void _listener() {
    if (widget.controller.page?.floor() == 2) {
      _status = FillButtonStatus.signUp;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return FillButton(
      text: _status == FillButtonStatus.next ? 'next' : 'Sign Up',
      routeName: AppRoutes.addedNewAccount,
      action: () {
        if (_status == FillButtonStatus.next) {
          widget.controller.animateToPage(widget.controller.page!.floor() + 1,
              duration: const Duration(milliseconds: 250),
              curve: Curves.decelerate);
        } else {
          Navigator.pushNamed(context, AppRoutes.signUpRoute);
        }
      },
    );
  }

  void _action() {}
}
