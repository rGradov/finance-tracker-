import 'package:finance_tracker/analytics/analytics_repository.dart';
import 'package:finance_tracker/app/ui/themes/app_theme.dart';
import 'package:finance_tracker/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


const List<String> HEADERS = [
  'Gain total control of your money',
  'Know where your money goes',
  'Planning ahead'
];
const  List<String> IMAGES = [
  AppImages.onboardingTakeMoney,
  AppImages.onboardinListMoney,
  AppImages.onBoardingPlan,
];
const List<String> SUBHEADERS =[
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

  void _listener()async{
    if(_controller.page ==2){
      debugPrint('last');
      _analyticsRepository.onBoardingIsDone();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: PageView.builder(
        controller: _controller,
        itemBuilder: (_, idx) {
          return _OnBoardingElement(idx: idx,);
        },
        itemCount: 3,
      ),
    );
  }
}

class _OnBoardingElement extends StatelessWidget {
  final int idx;
  const _OnBoardingElement({Key? key,required this.idx}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: _OnBoardingImg(idx: idx,)),
         Expanded(child: _OnBoardingText(idx: idx,)),
      ],
    );
  }
}

class _OnBoardingImg extends StatelessWidget {
  final int idx;
  const _OnBoardingImg({Key? key,required this.idx}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(IMAGES[idx]);
  }
}

class _OnBoardingText extends StatelessWidget {
  final int idx;
  const _OnBoardingText({Key? key,required this.idx}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.7,
      alignment: Alignment.center,
      child: Column(
        children: [
          _OnBoardingHeader(text: HEADERS[idx],),
          const SizedBox(height: 20,),
          _OnBoardingSubHeader(text: SUBHEADERS[idx],),
        ],
      ),
    );
  }
}

class _OnBoardingHeader extends StatelessWidget {
  final String text;
  const _OnBoardingHeader({Key? key,required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _style = TextStyle(
      color: AppColor.baseDark[50],
      fontSize: 32,
      fontWeight: FontWeight.w800,
      fontFamily: 'Inter',
    );
    return Text(text, style: _style,
      textAlign: TextAlign.center,);
  }
}

class _OnBoardingSubHeader extends StatelessWidget {
  final String text;
  const _OnBoardingSubHeader({Key? key,required this.text}) : super(key: key);

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
      style: _style, textAlign: TextAlign.center,);
  }
}
