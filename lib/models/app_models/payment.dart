class Payment {
  final int id;
  final double amount;
  final String description;
  final String category;
  final DateTime payment_time;

  const Payment({
      required this.id,
      required this.amount,
      required this.description,
      required this.category,
      required this.payment_time
      });

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'amount': amount,
      'description': description,
      'category': category,
      'time': payment_time.toString()
    };
  }

  @override
  String toString() {
    return 'Payment{id: ${id.toString()}, amount: ${amount.toString()}, category: $category}';
  }

}
