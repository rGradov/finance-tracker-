import 'package:equatable/equatable.dart';
import 'package:finance_tracker/app/model/models.dart';
import 'package:finance_tracker/app/utils/currency_converter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'expenses_state.dart';

class ExpensesCubit extends Cubit<ExpensesState> {
  ExpensesCubit() : super(const ExpensesLoading()) {
    _loadData();
  }

  Future<void> _loadData() async {
    Future<void>.delayed(const Duration(seconds: 3)).then((value) =>
        emit(const ExpensesLoaded(currency: CurrencyType.dollars, value: 10)));
  }
}
