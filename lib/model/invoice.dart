import 'package:mnrec/model/customer.dart';
import 'package:mnrec/model/suplier.dart';

class Invoice {
  final InvoiceInfo info;
  final Supplier supplier;
  final Customer customer;
  final List<InvoiceItem> items;

  const Invoice({
    required this.info,
    required this.supplier,
    required this.customer,
    required this.items,
  });
}

class InvoiceInfo {
  final String description;
  final String number;
  final DateTime date;
  final DateTime dueDate;
  final String atention;
  final String paymentTerms;

  const InvoiceInfo({
    required this.description,
    required this.number,
    required this.date,
    required this.dueDate,
    required this.atention,
    required this.paymentTerms,
  });
}

class InvoiceItem {
  final int quantity;
  final String description;
  final String purchasedPlan;
  final double price;

  const InvoiceItem({
    required this.quantity,
    required this.description,
    required this.purchasedPlan,
    required this.price,
  });
}
