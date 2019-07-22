import 'package:flutter_tdd/money/bank.dart';
import 'package:flutter_tdd/money/expression.dart';
import 'package:flutter_tdd/money/money.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Currency Test", () {
    test("test money multiplication", () {
      Money fiveDollar = Money(5, "USD");
      Money tenDollar = Money(10, "USD");
      expect(tenDollar, fiveDollar.times(2));
    });

    test("Test money equility", () {
      Money fiveDollar = Money(5, "USD");
      Money fiveFranc = Money(5, "CHF");

      expect(fiveDollar == Money(5, "USD"), true);
      expect(fiveDollar == Money(6, "USD"), false);
      expect(fiveDollar == fiveFranc, false);
    });

    test("test reduce sum", () {
      Expression sum = Sum(Money(5, "USD"), Money(4, "USD"));
      Bank bank = Bank();
      Money result = bank.reduce(sum, "USD");
      expect(Money(9, "USD"), result);
    });

    test("test reduce substraction", () {
      Expression difference = Substraction(Money(5, "USD"), Money(4, "USD"));
      Bank bank = Bank();
      Money result = bank.reduce(difference, "USD");
      expect(Money(1, "USD"), result);
    });
  });

  group("conversion test", () {
    test("Conversion for ratio USD:CHF = 2:1 works", () {
      Money fiveDollar = Money(5, "USD");
      Money tenFranc = Money(10, "CHF");
      Bank bank = Bank();
      Money result = bank.reduce(tenFranc, "USD");
      expect(fiveDollar, result);
    });
    
    test("Conversion for ratio CHF:USD = 1:2 works", () {
      Money fiveDollar = Money(5, "USD");
      Money tenFranc = Money(10, "CHF");
      Bank bank = Bank();
      bank.addExchangeRate("USD", "CHF", 2);
      Money result = bank.reduce(fiveDollar, "CHF");
      expect(tenFranc, result);
    });

    test("Adding dollar and CHF works", () {
      Money fiveDollar = Money(5, "USD");
      Money tenFranc = Money(10, "CHF");
      Bank bank = Bank();
      Sum sum = fiveDollar.plus(tenFranc);
      bank.addExchangeRate("USD", "CHF", 2);
      Money result = bank.reduce(sum, "USD");
      expect(Money(10, "USD"), result);
    });

    test("bank knows to store the exchange rates", () {
      Bank bank = Bank();
      bank.addExchangeRate("USD", "CHF", 2);
      bank.addExchangeRate("CHF", "USD", 1/2);
      expect(bank.getExchangeRate("USD", "CHF"),2);
      expect(bank.getExchangeRate("CHF", "USD"),1/2);
    });

  });
}
