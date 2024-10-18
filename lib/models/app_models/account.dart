import 'package:expense_tracker_dvm/models/app_models/payment.dart';
import 'package:sqflite/sqflite.dart';
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

  Future<void> insertPayment(Payment p, Future<Database> database) async {
    print('Inserting payment ${p.toString()}');
    final db = await database;
    await db.insert('payments', p.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Payment>> readIntoList(Future<Database> database) async {
    log.info('Reading payments');
    final db = await database;
    final List<Map<String, Object?>> paymentMaps = await db.query('payments');
    return [
      for(final {
        'id': id as int,
        'amount': amount as double,
        'category': category as String,
        'description': description as String,
        'time': time as String,
      } in paymentMaps)
        Payment(id: id, amount: amount, description: description, category: category, payment_time: DateTime.parse(time)),
    ];
  }

  void readToAcctHistory(Future<Database> database) async {
    acctHistory = await readIntoList(database);
  }
}