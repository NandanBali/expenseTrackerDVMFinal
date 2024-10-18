import 'package:expense_tracker_dvm/models/app_models/payment.dart';
import 'package:logging/logging.dart';

class Account {
  // Variables
  late List<Payment> acctHistory;
  double balance = 0.0;
  double monthlyExpense = 0.0;
  double monthlyIncome = 0.0;
  List<String> categories = [
    "Shopping",
    "Money Transfer",
    "Food",
    "Travel",
    "Essentials",
    "Income"
  ];
  final Logger log = Logger("My logger");

  // constructor
  Account() {
    acctHistory = [];
  }

  // functions
  bool checkBalance() {
    if (balance >= 0) {
      return true;
    } else {
      return false;
    }
  }
}