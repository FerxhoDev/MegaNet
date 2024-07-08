

import 'package:go_router/go_router.dart';
import 'package:mnrec/pages/form_invoice_page.dart';
import 'package:mnrec/pages/pdf_page.dart';
import 'package:mnrec/presentation/screens/gen_recibo.dart';
import 'package:mnrec/presentation/screens/home_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: HomeScreen.name,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/pdfGenerate',
      name: PdfReceiptScreen.name,
      builder: (context, state) => const PdfReceiptScreen(),
    ),
    GoRoute(
      path: '/pdfa',
      name: PdfPage.name,
      builder: (context, state) => const PdfPage(),
    ),
    GoRoute(
      path: '/form_invoice',
      name: FormInvoice.name,
      builder: (context, state) => const FormInvoice(),
    ),
  ]
);
