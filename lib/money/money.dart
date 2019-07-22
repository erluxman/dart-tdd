import 'bank.dart';
import 'expression.dart';

class Money extends Expression {
  double _amount = 0;
  String _symbol = "USD";

  //Money(this.amount);
  Money(this._amount, this._symbol);

  Money setAmout(double amount) {
    this._amount = amount;
    return this;
  }

  double get amount => _amount;

  String get symbol => _symbol;

  Money setSymbol(String symbol) {
    this._symbol = symbol;
    return this;
  }

  Money times(int times) {
    return Money(_amount * times, _symbol);
  }

  Expression plus(Money money) {
    return Sum(this, money);
  }

  @override
  bool operator ==(Object other) {
    Type thisType = this.runtimeType;
    Type otherType = other.runtimeType;

    return identical(this, other) ||
        (other is Money &&
            otherType == thisType &&
            other._symbol == this._symbol &&
            other._amount == this._amount);
  }

  @override
  Money reduce(String symbol, Bank bank) {
    return Money(
        this.amount * bank.getExchangeRate(this.symbol, symbol), symbol);
  }
}
