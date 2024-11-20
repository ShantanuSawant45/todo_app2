import 'package:flutter/foundation.dart';
import '../models/transaction.dart';

class TransactionProvider with ChangeNotifier {
  double _balance = 2459.50;
  final List<Transaction> _transactions = [];

  double get balance => _balance;
  List<Transaction> get transactions => _transactions;

  double get totalExpenses {
    return _transactions
        .where((t) => t.type == TransactionType.expense)
        .fold(0, (sum, t) => sum + t.amount);
  }

  double get monthlyIncome {
    final now = DateTime.now();
    return _transactions
        .where((t) =>
            t.type == TransactionType.income &&
            t.date.month == now.month &&
            t.date.year == now.year)
        .fold(0, (sum, t) => sum + t.amount);
  }

  double get monthlyExpenses {
    final now = DateTime.now();
    return _transactions
        .where((t) =>
            t.type == TransactionType.expense &&
            t.date.month == now.month &&
            t.date.year == now.year)
        .fold(0, (sum, t) => sum + t.amount);
  }

  List<Transaction> getTransactionsByType(TransactionType type) {
    return _transactions.where((t) => t.type == type).toList();
  }

  Map<String, double> getCategoryTotals() {
    final totals = <String, double>{};
    for (var transaction
        in _transactions.where((t) => t.type == TransactionType.expense)) {
      totals[transaction.category] =
          (totals[transaction.category] ?? 0) + transaction.amount;
    }
    return totals;
  }

  void addTransaction(Transaction transaction) {
    _transactions.insert(0, transaction);

    if (transaction.type == TransactionType.income) {
      _balance += transaction.amount;
    } else if (transaction.type == TransactionType.expense) {
      _balance -= transaction.amount;
    }

    notifyListeners();
  }

  void deleteTransaction(String id) {
    final transaction = _transactions.firstWhere((t) => t.id == id);
    if (transaction.type == TransactionType.income) {
      _balance -= transaction.amount;
    } else if (transaction.type == TransactionType.expense) {
      _balance += transaction.amount;
    }

    _transactions.removeWhere((t) => t.id == id);
    notifyListeners();
  }
}
