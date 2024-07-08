import 'package:flutter/material.dart';

import 'package:mnrec/helpers/pdf_helper.dart';
import 'package:mnrec/helpers/pdf_invoice_helper.dart';
import 'package:mnrec/model/customer.dart';
import 'package:mnrec/model/invoice.dart';
import 'package:mnrec/model/suplier.dart';
import 'package:mnrec/widget/button_widget.dart';
import 'package:mnrec/widget/title_widget.dart';

class PdfPage extends StatefulWidget {

  static const String name = 'pdfa';

  const PdfPage({super.key});

  @override
  _PdfPageState createState() => _PdfPageState();
}

class _PdfPageState extends State<PdfPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: const Color.fromARGB(66, 196, 194, 194),
        appBar: AppBar(
          title: const Text('Generate Recibo'),
          centerTitle: true,
        ),
        body: Container(
          padding: const EdgeInsets.all(32),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const TitleWidget(
                  icon: Icons.picture_as_pdf,
                  text: 'Generate Invoice',
                ),
                const SizedBox(height: 48),
                ButtonWidget(
                  text: 'Get PDF',
                  onClicked: () async {
                    final date = DateTime.now();
                    final dueDate = date.add(
                      const Duration(days: 7),
                    );

                    final invoice = Invoice(
                      supplier: const Supplier(
                        name: 'MegaNet',
                        address: 'Caserio Nueva Jerusalem',
                        phone: '4596-9465',
                        email: 'Internetelcrucero@gmail.com'
                      ),
                      customer: const Customer(
                        client: 'Damaris de Paz',
                        address: 'Pozo Mecanico San Rafael Sac.',
                      ),
                      info: InvoiceInfo(
                        date: date,
                        dueDate: dueDate,
                        description: 'Comprobante de pago',
                        number: '${DateTime.now().year}-9999',
                        atention:'Mayerli Hernandez',
                        paymentTerms: 'Transferencia',
                      ),
                      items: [
                        InvoiceItem(
                          quantity: 2,
                          description: 'Pago de internet més de Enero',
                          purchasedPlan: 'Basic',
                          price: double.parse('100.00'),
                        ),
                        InvoiceItem(
                          quantity: 3,
                          description: 'Pago de internet més de Febrero',
                          purchasedPlan: 'Plus',
                          price: double.parse('150.00'),
                        ),
                        InvoiceItem(
                          quantity: 1,
                          description: 'Pago de internet més de Marzo',
                          purchasedPlan: 'Basic',
                          price: double.parse('100.00'),
                        ),
                        InvoiceItem(
                          quantity: 3,
                          description: 'Coffee',
                          purchasedPlan: 'Basic',
                          price: double.parse('100.00'),
                        ),
                        InvoiceItem(
                          quantity: 3,
                          description: 'Coffee',
                          purchasedPlan: 'Basic',
                          price: double.parse('100.00'),
                        ),
                        InvoiceItem(
                          quantity: 3,
                          description: 'Coffee',
                          purchasedPlan: 'Basic',
                          price: double.parse('100.00'),
                        ),
                        InvoiceItem(
                          quantity: 3,
                          description: 'Coffee',
                          purchasedPlan: 'Basic',
                          price: double.parse('100.00'),
                        ),
                      ],
                    );

                    final pdfFile = await PdfInvoicePdfHelper.generate(invoice);

                    
                      PdfHelper.openFile(pdfFile);
                    
                  },
                ),
              ],
            ),
          ),
        ),
      );
}
