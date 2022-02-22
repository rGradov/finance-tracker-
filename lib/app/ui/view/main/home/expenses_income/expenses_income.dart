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
  Widget build(BuildContext context) =>const _ExpensesIncomeWrapper();

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
           SizedBox(width: 20,),
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
      constraints: const BoxConstraints(maxHeight: 100,minHeight: 80),
      decoration: BoxDecoration(
        color: type == ExpensesIncomeType.expenses ? AppColor.red[100] : AppColor.green[100],
        borderRadius: const BorderRadius.all(
          Radius.circular(28),
        ),
      ),
      child: FractionallySizedBox(
        heightFactor: 0.8,
        widthFactor: 0.9,
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _IconWrapper(
              type: type,
            ),
            const SizedBox(
              width: 10,
            ),
            _TextWrapper(
              type: type,
            ),

            /// TODO: added text and value
          ],
        ),
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
        child: Image.asset(type ==ExpensesIncomeType.expenses?AppImages.expense: AppImages.income));
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
        _ValueWrapper(type: type,),
      ],
    );
  }
}

class _ValueWrapper extends StatelessWidget {
  final ExpensesIncomeType type;
  const _ValueWrapper({Key? key,required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const String _value ='BYN10';
    final _style = TextStyle(
        color: AppColor.baseLight[80],
        fontFamily: 'Inter',
        fontWeight: FontWeight.w700,
        fontSize: 22);
    return Text(_value,style: _style,);
  }
}
