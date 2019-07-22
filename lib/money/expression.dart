import 'bank.dart';
import 'money.dart';

abstract class Expression {
  Money reduce(String symbol, Bank bank);
}

class Sum implements Expression {
  Money auged;
  Money added;
  Sum(this.auged, this.added);

  @override
  Money reduce(String symbol, Bank bank) {
    double augedConvertedValue =
        auged.amount * bank.getExchangeRate(auged.symbol, symbol);
    double addedConvertedValue =
        added.amount * bank.getExchangeRate(added.symbol, symbol);
        
    return Money(augedConvertedValue + addedConvertedValue, "USD");
  }
}

class Substraction implements Expression {
  //Origin value
  Money minuend;

  //Value to be reduced
  Money subtrahend;
  Substraction(this.minuend, this.subtrahend);

  @override
  Money reduce(String symbol, Bank bank) {
    return Money(minuend.amount - subtrahend.amount, "USD");
  }
}
