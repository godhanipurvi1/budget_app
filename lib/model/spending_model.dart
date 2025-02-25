class SpendingModel {
  int id;
  String description;
  double amount;
  String paymentMode;
  String date;
  int categoryId;

  SpendingModel({
    required this.id,
    required this.description,
    required this.amount,
    required this.paymentMode,
    required this.date,
    required this.categoryId,
  });
  factory SpendingModel.formMap({required Map<String, dynamic> data}) {
    return SpendingModel(
      id: data['spending_id'],
      description: data['spending_desc'],
      amount: data['spending_amount'],
      paymentMode: data['spending_mode'],
      date: data['spending_date'],
      categoryId: data['spending_category_id'],
    );
  }
}
