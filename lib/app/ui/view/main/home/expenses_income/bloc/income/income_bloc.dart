import 'package:equatable/equatable.dart';
import 'package:finance_tracker/app/model/models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'income_state.dart';
class IncomeCubit extends Cubit<IncomeState> {
  IncomeCubit() : super(const IncomeLoading());
}
