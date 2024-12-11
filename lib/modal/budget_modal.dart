class Budget {
  int? id,isIncome;
  double? amount;
  String? date,category;

  Budget({
    required this.id,
    required this.date,
    required this.category,
    required this.amount,
    required this.isIncome,
  });

  factory Budget.fromMap(Map m1) {
    return Budget(
        id: m1['id'],
        date: m1['date'],
        category: m1['category'],
        amount: m1['amount'],
        isIncome: m1['isIncome']);
  }
}
