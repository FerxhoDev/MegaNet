import 'dart:io';


import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pwfont;


class PdfReceiptScreen extends StatefulWidget {

    static const String name = 'pdfGenerate';

  const PdfReceiptScreen({super.key});

  @override
  State<PdfReceiptScreen> createState() => _PdfReceiptScreenState();
}

class _PdfReceiptScreenState extends State<PdfReceiptScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  generatePdf() async {
    final pdf = pw.Document();
    
    

    pdf.addPage(
      pw.Page(
        build: (context) => pw.Center(
          child: pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.center,
            children: [
              pw.Text('Recibo', style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 20),
              pw.Text('Name: ${_nameController.text}'),
              pw.Text('Amount: ${_amountController.text}'),
            ],
          ),
        ),
      )
    );

    final output = await getExternalStorageDirectory();
    final file = File('${output?.path}/example.pdf');
    await file.writeAsBytes(await pdf.save());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Generate Receipt'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
              ),
            ),
            const SizedBox(height: 20,),
            TextField(
              controller: _amountController,
              decoration: const InputDecoration(
                labelText: 'Amount',
              ),
            ),
            const SizedBox(height: 20,),
            ElevatedButton(
              onPressed: () {
                generatePdf();
              },
              child: const Text('Generate PDF'),
            ),
          ],
        ),
      ),
    );
  }
}
