import 'expression.dart';
import 'money.dart';

class Bank {
  
  Money reduce(Expression expression, String symbol) {
    return expression.reduce(symbol,this);
  }

  Map<String, double> _exchangeRates = Map();

  void addExchangeRate(String from, String to, double i) {
    _exchangeRates["$from-to-$to"] = i;
  }

  double getExchangeRate(String from, String to) {
    if(from==to) return 1;
    return _exchangeRates["$from-to-$to"];
  }

}
