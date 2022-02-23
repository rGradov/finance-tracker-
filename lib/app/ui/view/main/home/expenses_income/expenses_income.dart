import 'package:finance_tracker/app/ui/themes/app_theme.dart';
import 'package:finance_tracker/resources/resources.dart';
import 'package:flutter/material.dart';

enum ExpensesIncomeType {
  expenses,
  income,
}

class ExpensesIncome extends StatelessWidget {
  const ExpensesIncome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const _ExpensesIncomeWrapper();
}

class _ExpensesIncomeWrapper extends StatelessWidget {
  const _ExpensesIncomeWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.9,
      alignment: Alignment.center,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Expanded(
            child: _ExpensesIncomeBodyWrapper(
              type: ExpensesIncomeType.income,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: _ExpensesIncomeBodyWrapper(
              type: ExpensesIncomeType.expenses,
            ),
          ),
        ],
      ),
    );
  }
}

class _ExpensesIncomeBodyWrapper extends StatelessWidget {
  final ExpensesIncomeType type;

  const _ExpensesIncomeBodyWrapper({Key? key, required this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxHeight: 100, minHeight: 80),
      decoration: BoxDecoration(
        color: type == ExpensesIncomeType.expenses
            ? AppColor.red[100]
            : AppColor.green[100],
        borderRadius: const BorderRadius.all(
          Radius.circular(28),
        ),
      ),
      child: _ExpensesIncomesAnimationBody(
        type: type,
      ),
    );
  }
}

class _ExpensesIncomesAnimationBody extends StatefulWidget {
  final ExpensesIncomeType type;

  const _ExpensesIncomesAnimationBody({Key? key, required this.type})
      : super(key: key);

  @override
  _ExpensesIncomesAnimationBodyState createState() =>
      _ExpensesIncomesAnimationBodyState();
}

class _ExpensesIncomesAnimationBodyState
    extends State<_ExpensesIncomesAnimationBody> {
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.8,
      widthFactor: 0.9,
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _IconWrapper(
            type: widget.type,
          ),
          const SizedBox(
            width: 10,
          ),
          _TextWrapper(
            type: widget.type,
          ),

          /// TODO: added text and value
        ],
      ),
    );
  }
}

class _IconWrapper extends StatelessWidget {
  final ExpensesIncomeType type;

  const _IconWrapper({Key? key, required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(16),
          ),
        ),

        /// TODO: implement another type os assets
        child: Image.asset(type == ExpensesIncomeType.expenses
            ? AppImages.expense
            : AppImages.income));
  }
}

/// use type just for displayed text [Income] or [Expenses]
class _TextWrapper extends StatelessWidget {
  final ExpensesIncomeType type;

  const _TextWrapper({Key? key, required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _style = TextStyle(
        color: AppColor.baseLight[80],
        fontFamily: 'Inter',
        fontWeight: FontWeight.w400,
        fontSize: 18);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        type == ExpensesIncomeType.expenses
            ? Text(
                'Expenses',
                style: _style,
              )
            : Text(
                'Income',
                style: _style,
              ),
        _ValueWrapper(
          type: type,
          value: 'BYN10',
        ),
      ],
    );
  }
}

class _ValueWrapper extends StatefulWidget {
  final ExpensesIncomeType type;
  final String value;

  const _ValueWrapper({Key? key, required this.type, required this.value})
      : super(key: key);

  @override
  State<_ValueWrapper> createState() => _ValueWrapperState();
}

class _ValueWrapperState extends State<_ValueWrapper>
    with TickerProviderStateMixin {
  final List<AnimationController> _animationControllers = [];
  final List<Animation<double>> _animations = [];

  @override
  void initState() {
    widget.value.split('').forEach((char) {
      _animationControllers.add(
          AnimationController(vsync: this, duration: const Duration(seconds: 1))
            ..addListener(_animationListener));
    });
    for (var controller in _animationControllers) {
      _animations.add(Tween<double>(begin: 0, end: 1).animate(controller));
    }
    _animationControllers.first.forward();
    super.initState();
  }

  void _animationListener() {
    for (var i = 0; i < _animationControllers.length; i++) {
      if (_animationControllers[i].isCompleted) {
        if (i == _animationControllers.length - 1) {
        } else {
          _animationControllers[i + 1].forward();
        }
      }
    }
  }

  @override
  void dispose() {
    for (var controllers in _animationControllers) {
      controllers.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _style = TextStyle(
        color: AppColor.baseLight[80],
        fontFamily: 'Inter',
        fontWeight: FontWeight.w700,
        fontSize: 22);
    return Row(
        children: widget.value
            .split('')
            .asMap()
            .map<int, Widget>((idx, v) {
              return MapEntry(
                  idx,
                  AnimatedBuilder(
                    animation: _animations[idx],
                    builder: (BuildContext context, Widget? child) {
                      return Opacity(
                          opacity: _animations[idx].value,
                          child: Text(widget.value[idx].toString(),style: _style,));
                    },
                  ));
            })
            .values
            .toList());
  }
}
