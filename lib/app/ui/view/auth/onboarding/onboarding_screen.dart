import 'dart:math' as math;

import 'package:finance_tracker/analytics/analytics_repository.dart';
import 'package:finance_tracker/app/ui/navigation/main_navigation.dart';
import 'package:finance_tracker/app/ui/shared/fill_button.dart';
import 'package:finance_tracker/app/ui/themes/app_theme.dart';
import 'package:finance_tracker/resources/resources.dart';
import 'package:flutter/material.dart';

const DURATION = Duration(milliseconds: 600);
const RADIUS = 18;
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
          Expanded(
            flex: 1,
            child: _CircleDotAnimation(controller: _controller),
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
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
class _CircleDotAnimation extends StatefulWidget {
  final PageController controller;

  const _CircleDotAnimation({Key? key, required this.controller})
      : super(key: key);

  @override
  _CircleDotAnimationState createState() => _CircleDotAnimationState();
}

class _CircleDotAnimationState extends State<_CircleDotAnimation>
    with TickerProviderStateMixin {
  late List<AnimationController> _controller;
  late List<Animation<double>> _animation = [];
  final ValueNotifier<int> _index = ValueNotifier(0);
  final ValueNotifier<int> _circleIndex = ValueNotifier(0);

  @override
  void initState() {
    _controller = List.generate(
        3,
        (index) => AnimationController(
              vsync: this,
              duration: DURATION,
            ));
    _animation = List.generate(
        3,
        (index) => Tween<double>(
              begin: index % 2 == 0 ? 180 : -180,
              end: 0,
            ).animate(_controller[index]));

    widget.controller.addListener(_listener);
    for(var controller in _controller){
      controller.addListener(_controllerListener);
    }
    super.initState();
  }

  void _controllerListener(){
    if(_controller[0].isAnimating){}
    if(_controller[0].isCompleted){
      _circleIndex.value = 1;
    }
    if(_controller[1].isCompleted){
      _circleIndex.value = 2;
    }
  }



  @override
  void dispose() {
    for (var controller in _controller) {
      controller.dispose();
    }
    super.dispose();
  }


  void _listener() {
    debugPrint(widget.controller.page.toString());
    if (widget.controller.page! > 0) {
      if (!_controller[0].isAnimating) {
        _controller[0].forward();
      }
      if (_controller[0].isCompleted) {
        _index.value = 1;
        debugPrint('complite');

      }
    }
    if (widget.controller.page! > 1.00) {
      if(_circleIndex.value !=1){
      }
      debugPrint(_controller[1].isAnimating.toString());
      if (!_controller[1].isAnimating) {
        _controller[1].forward();
      }
      if (_controller[1].isCompleted) {
        _index.value = 2;

      }
    }
    if (widget.controller.page! > 2.00) {
      _circleIndex.value = 2;
      if(_circleIndex.value !=2){
        // _circleIndex.value = 2;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: RADIUS*3*2,
      height: RADIUS*3*2,
      child: ValueListenableBuilder(valueListenable: _circleIndex,builder: (_,circleIndex,__){
        return Stack(
          alignment: Alignment.centerLeft,
          children: [
            Row(
              children: List.generate(
                  3,
                      (index) =>Expanded(
                    child:  _CircleDot(
                      color: AppColor.violet[20],
                    ),
                  )),
            ),

            /// FIXME: change to basic setState
            Row(
                children: List.generate(
                  3,
                      (index) => ValueListenableBuilder<int>(
                      valueListenable: _index,
                      builder: (_, value, __) {
                        return AnimatedBuilder(
                            animation: _animation[index],
                            builder: (_, __) {
                              final _angle = _animation[index].value.floor();
                              final _offset = Offset(
                                  RADIUS+18 * math.cos(_angle * (math.pi / 180)),
                                  RADIUS * math.sin(_angle * (math.pi / 180)));
                              return Expanded(
                                child: Transform.translate(
                                  offset: _offset,
                                  child: AnimatedOpacity(
                                    duration: const Duration(milliseconds: 0),
                                    opacity: circleIndex!= index?0:1,
                                    child: _CircleDot(
                                        animatedCircle: true,
                                        color: circleIndex== index? AppColor.violet[100]:AppColor.violet[20]
                                    ),
                                  ),
                                ),
                              );
                            });
                      }),
                )),
          ],
        );
      },),
    );
  }
}

class _CircleDot extends StatelessWidget {
  final Color? color;
  final bool animatedCircle;

  const _CircleDot({Key? key, this.animatedCircle = false,this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        color: color ?? Colors.black,
        shape: BoxShape.circle,
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
    final _orientation = MediaQuery.of(context).orientation;
    return
      _orientation == Orientation.landscape?
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              child: _OnBoardingImg(
                idx: idx,
              )),
          Expanded(
              child: _OnBoardingText(
                idx: idx,
              )),
        ],
      ):
      Column(
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
        mainAxisAlignment: MainAxisAlignment.center,
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
  final PageController controller;

  const _OnBoardingButtonsWrapper({Key? key, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _orientation = MediaQuery.of(context).orientation;
    return FractionallySizedBox(
      widthFactor: 0.95,
      alignment: Alignment.center,
      child:
      _orientation == Orientation.landscape?
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: _OnBoardingFillButton(
              controller: controller,
            ),
          ),
          const SizedBox(width: 20,),
          const  Expanded(child: _OnBoardingLoginButton()),
        ],
      ):
      Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _OnBoardingFillButton(
            controller: controller,
          ),
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
      textColor: AppColor.violet[100]!,
      color: AppColor.violet[20],
      routeName: AppRoutes.loginRoute,
      text: 'Log in',
      action: () {
        Navigator.pushNamed(context, AppRoutes.loginRoute);
      },
    );
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
              duration: DURATION, curve: Curves.decelerate);
        } else {
          Navigator.pushNamed(context, AppRoutes.signUpRoute);
        }
      },
    );
  }
}
