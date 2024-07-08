import 'package:flutter/material.dart';
import 'package:mnrec/model/invoice.dart';

class ItemInvoiceProvider extends  ChangeNotifier{
  List<InvoiceItem> itemsInvoiceList = [
    /*const InvoiceItem(quantity: 2,
    description: 'Pago de internet més de Enero',	
    purchasedPlan: 'Basic',
    price: 150.00
    ),
    const InvoiceItem(quantity: 2,
    description: 'Pago de internet més de Febrero',	
    purchasedPlan: 'Basic',
    price: 175.00
    )*/
  ];

  Future<void> addItem(InvoiceItem item) async {
    itemsInvoiceList.add(item);
    notifyListeners();
  }

}