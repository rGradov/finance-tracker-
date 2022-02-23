import 'package:finance_tracker/app/model/expense_model.dart';

class CurrencyConverter {
  final CurrencyType type;
  String? value;
  CurrencyConverter(this.type){
   switch(type){

     case CurrencyType.dollars:
     value = "\$";
       break;
     case CurrencyType.rubles:
       value = "Rub";
       break;
     case CurrencyType.byn:
      value = "Byn";
       break;
     case CurrencyType.euro:
        value = "Eu";
       break;
   }
  }
}