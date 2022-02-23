import 'package:equatable/equatable.dart';
import 'package:finance_tracker/app/model/models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'expenses_state.dart';

class ExpensesCubit extends Cubit<ExpensesState> {
  ExpensesCubit() : super(const ExpensesLoading());
}
