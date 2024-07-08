import 'package:flutter/material.dart';
import 'package:mnrec/helpers/pdf_helper.dart';
import 'package:mnrec/helpers/pdf_invoice_helper.dart';
import 'package:mnrec/model/customer.dart';
import 'package:mnrec/model/invoice.dart';
import 'package:mnrec/model/suplier.dart';
import 'package:mnrec/providers/provider.dart';
import 'package:provider/provider.dart';


class FormInvoice extends StatefulWidget {
  const FormInvoice({Key? key}) : super(key: key);

  static const String name = 'form_invoice';

  @override
  State<FormInvoice> createState() => _FormInvoiceState();
}

class _FormInvoiceState extends State<FormInvoice> {
  TextEditingController clientecontroller = TextEditingController();
  TextEditingController mescontroller = TextEditingController();
  TextEditingController aniocontroller = TextEditingController();
  TextEditingController montcontroller = TextEditingController();
  String dropDownValue = '1';
  String dropdonwValue2 = '1';
  String dropdownValue3 = '1';

  List<InvoiceItem> itemsInv = [];
  String? selectedUser;
  String? selectedPlan;
  String? selectedFormatPay;

  String dropDownValuevist2 =
      '1';

  @override
  Widget build(BuildContext context) {
    final itemInvoiceProvider = context.watch<ItemInvoiceProvider>();

    return Scaffold(
      backgroundColor: const Color.fromRGBO(55, 65, 81, 1),
      appBar: AppBar(
        title: const Text('MegaNet',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'pdf',
        onPressed: () async {
          final String userAtention;
          final String paymentTerms;

          switch (selectedUser) {
            case '1':
              userAtention = 'Mayerli Hernández';
              break;
            case '2':
              userAtention = 'Ferdy Ramírez Cardona';
              break;
            case '3':
              userAtention = 'Edelmira Bravo';
              break;
            default:
              userAtention = 'Mayerli Hernández';
          }

          switch (selectedFormatPay) {
            case '1':
              paymentTerms = 'Efectivo';
              break;
            case '2':
              paymentTerms = 'Transferencia';
              break;
            default:
              paymentTerms = 'Efectivo';
          }

          final date = DateTime.now();
          final dueDate = date.add(
            const Duration(days: 7),
          );

          final invoice = Invoice(
            supplier: const Supplier(
                name: 'MegaNet',
                address: 'Caserio Nueva Jerusalem',
                phone: '5558-2154',
                email: 'internetelcrucero@gmail.com'),
            customer: Customer(
              client: clientecontroller.text,
              address: 'Ciudad',
            ),
            info: InvoiceInfo(
              date: date,
              dueDate: dueDate,
              description: 'MegaNet conectando familias',
              number: '${DateTime.now().year}-9999',
              atention: userAtention,
              paymentTerms: paymentTerms,
            ),
            items: itemInvoiceProvider.itemsInvoiceList,
          );

          final pdfFile = await PdfInvoicePdfHelper.generate(invoice);

          PdfHelper.openFile(pdfFile);
        },
        // ignore: prefer_const_constructors
        child: Icon(
          Icons.picture_as_pdf_rounded,
        ),
      ),
      body: Column(
        children: [
          UserSelect(
            dropDownValue: dropDownValue,
            onValueChanged: (newValue) {
              setState(() {
                selectedUser = newValue;
              });
            },
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: ClientName(
                        clientecontroller: clientecontroller,
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: 
                          DropdownButtonFormField(
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.only(left: 15, right: 10),
                border: InputBorder.none,
              ),
              focusColor: Colors.white,
              isExpanded: false,
              value: dropdownValue3,
              icon: const Icon(
                Icons.arrow_drop_down,
                color: Colors.white,
              ),
              style: const TextStyle(color: Colors.white),
              dropdownColor: const Color.fromRGBO(31, 41, 55, 1),
              onChanged: (String? newValue) {
                setState(() {
                  dropDownValuevist2 = newValue!;
                });
                // Llamando a la función externa con el nuevo valor
                selectedFormatPay = dropDownValuevist2;
              },
              items: const [
                DropdownMenuItem(
                  value: '1',
                  child: Text('Efectivo'),
                ),
                DropdownMenuItem(
                  value: '2',
                  child: Text('Transferencia'),
                ),
              ],
            ),
                      
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 6,
                      child: Month(
                        mescontroller: mescontroller,
                      ),
                    ),
                    const SizedBox(
                        width: 10), // Espacio entre los campos de texto
                    Expanded(
                      flex: 4,
                      child: Year(
                        aniocontroller: aniocontroller,
                      ),
                    ),
                    
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 6,
                      child: PlanSelect(
                        dropDownValue2: dropdonwValue2,
                        onValueChanged: (newValue) {
                          setState(() {
                            selectedPlan = newValue;
                          });
                        },
                      ),
                    ),
                    const SizedBox(
                        width: 10), // Espacio entre los campos de texto
                    Expanded(
                      flex: 4,
                      child: Price(montcontroller: montcontroller),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    FloatingActionButton(
                        heroTag: 'add',
                        backgroundColor: const Color.fromARGB(255, 16, 37, 66),
                        onPressed: () {
                          //TODO: Agregar la funcionalidad para guardar los datos.

                          String purchasePlan;
                          switch (selectedPlan) {
                            case '1':
                              purchasePlan = 'Basico';
                              break;
                            case '2':
                              purchasePlan = 'Fast';
                              break;
                            case '3':
                              purchasePlan = 'Super Fast';
                              break;
                            case '4':
                              purchasePlan = 'plus 225';
                              break;
                            case '5':
                              purchasePlan = 'plus 250';
                              break;
                            default:
                              purchasePlan = 'Basico';
                          }

                          itemInvoiceProvider.addItem(InvoiceItem(
                              quantity: 1,
                              description:
                                  'Pago de internet resid de ${mescontroller.text} de ${aniocontroller.text}',
                              purchasedPlan: purchasePlan,
                              price: double.parse(montcontroller.text)));
                          mescontroller.clear();
                          aniocontroller.clear();
                        },
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 30,
                        ))
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          Expanded(
            // Use Expanded para que el Container ocupe el espacio restante
            child: Container(
              decoration: const BoxDecoration(
                  color: Color.fromRGBO(31, 41, 55, 1),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: itemInvoiceProvider.itemsInvoiceList.length,
                  itemBuilder: (context, index) {
                    final InvoiceItem =
                        itemInvoiceProvider.itemsInvoiceList[index];
                    return ListTile(
                      leading: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.white,
                      ),
                      title: Text(
                        InvoiceItem.description,
                        style: const TextStyle(color: Colors.white),
                      ),
                      subtitle: Text(
                        InvoiceItem.purchasedPlan,
                        style: const TextStyle(color: Colors.white),
                      ),
                      trailing: Text(
                        InvoiceItem.price.toString(),
                        style: const TextStyle(color: Colors.white),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ClientName extends StatelessWidget {
  final TextEditingController clientecontroller;

  const ClientName({Key? key, required this.clientecontroller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: clientecontroller,
      textCapitalization: TextCapitalization.words,
      style: const TextStyle(color: Color.fromRGBO(255, 255, 230, 0.6)),
      decoration: const InputDecoration(
        prefixIcon: Icon(
          Icons.person,
          color: Color.fromRGBO(255, 255, 230, 0.6),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.all(Radius.circular(5.5)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.all(Radius.circular(5.5)),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        isDense: true,
        hintText: 'Cliente',
        hintStyle: TextStyle(
            color: Color.fromRGBO(255, 255, 230, 0.6),
            fontSize: 16.0,
            fontWeight: FontWeight.bold),
        filled: true,
        fillColor: Color.fromRGBO(31, 41, 55, 1),
      ),
    );
  }
}

class Month extends StatelessWidget {
  final TextEditingController mescontroller;
  const Month({Key? key, required this.mescontroller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: mescontroller,
      textCapitalization: TextCapitalization.words,
      style: const TextStyle(color: Color.fromRGBO(255, 255, 230, 0.6)),
      decoration: const InputDecoration(
        prefixIcon: Icon(
          Icons.calendar_month,
          color: Color.fromRGBO(255, 255, 230, 0.6),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.all(Radius.circular(5.5)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.all(Radius.circular(5.5)),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        isDense: true,
        hintText: 'Mes',
        hintStyle: TextStyle(
            color: Color.fromRGBO(255, 255, 230, 0.6),
            fontSize: 16.0,
            fontWeight: FontWeight.bold),
        filled: true,
        fillColor: Color.fromRGBO(31, 41, 55, 1),
      ),
    );
  }
}

class Year extends StatelessWidget {
  final TextEditingController aniocontroller;

  const Year({Key? key, required this.aniocontroller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: aniocontroller,
      keyboardType: TextInputType.number,
      textCapitalization: TextCapitalization.words,
      style: const TextStyle(color: Color.fromRGBO(255, 255, 230, 0.6)),
      decoration: const InputDecoration(
        prefixIcon: Icon(
          Icons.edit_calendar_rounded,
          color: Color.fromRGBO(255, 255, 230, 0.6),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.all(Radius.circular(5.5)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.all(Radius.circular(5.5)),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        isDense: true,
        hintText: 'Año',
        hintStyle: TextStyle(
            color: Color.fromRGBO(255, 255, 230, 0.6),
            fontSize: 16.0,
            fontWeight: FontWeight.bold),
        filled: true,
        fillColor: Color.fromRGBO(31, 41, 55, 1),
      ),
    );
  }
}

class UserSelect extends StatefulWidget {
  final String dropDownValue;
  final Function(String)
      onValueChanged; // Este es el callback para la función externa

  const UserSelect(
      {Key? key, required this.dropDownValue, required this.onValueChanged})
      : super(key: key);

  @override
  State<UserSelect> createState() => _UserSelectState();
}

class _UserSelectState extends State<UserSelect> {
  String dropDownValuevist =
      '1'; // No necesitas esto si usas widget.dropDownValue

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Container(
      width: mediaQuery.size.width * 0.8,
      height: mediaQuery.size.height * 0.16,
      decoration: const BoxDecoration(
        color: Color.fromRGBO(31, 41, 55, 1),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          const Text(
            'Usuario',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          Center(
            child: DropdownButtonFormField(
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.only(left: 15, right: 10),
                border: InputBorder.none,
              ),
              focusColor: Colors.white,
              isExpanded: false,
              value: widget.dropDownValue,
              icon: const Icon(
                Icons.arrow_drop_down,
                color: Colors.white,
              ),
              style: const TextStyle(color: Colors.white),
              dropdownColor: const Color.fromRGBO(31, 41, 55, 1),
              onChanged: (String? newValue) {
                setState(() {
                  dropDownValuevist = newValue!;
                });
                // Llamando a la función externa con el nuevo valor
                widget.onValueChanged(dropDownValuevist);
              },
              items: const [
                DropdownMenuItem(
                  value: '1',
                  child: Text('Mayerli Hernández'),
                ),
                DropdownMenuItem(
                  value: '2',
                  child: Text('Ferdy Ramírez Cardona'),
                ),
                DropdownMenuItem(
                  value: '3',
                  child: Text('Edelmira Bravo'),
                ),
              ],
            ),
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(
                Icons.admin_panel_settings,
                color: Color.fromRGBO(45, 212, 191, 1),
              ),
              Text(
                'Los datos cargados no son guardados',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class PlanSelect extends StatefulWidget {
  final String dropDownValue2;
  final Function(String) onValueChanged;

  const PlanSelect(
      {Key? key, required this.dropDownValue2, required this.onValueChanged})
      : super(key: key);

  @override
  State<PlanSelect> createState() => _PlanSelect();
}

class _PlanSelect extends State<PlanSelect> {
  String dropDownValuevist2 = '1';
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    String dropDownValue = '1';
    return Container(
      width: mediaQuery.size.width * 0.5,
      height: mediaQuery.size.height * 0.08,
      decoration: const BoxDecoration(
        color: Color.fromRGBO(31, 41, 55, 1),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 5,
          ),
          Center(
            child: DropdownButtonFormField(
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.only(left: 15, right: 10),
                    border: InputBorder.none),
                focusColor: Colors.white,
                isExpanded: false,
                value: dropDownValue,
                icon: const Icon(
                  Icons.arrow_drop_down,
                  color: Color.fromRGBO(255, 255, 230, 0.6),
                ),
                style:
                    const TextStyle(color: Color.fromRGBO(255, 255, 230, 0.6)),
                dropdownColor: const Color.fromRGBO(31, 41, 55, 1),
                onChanged: (String? newValue) {
                  setState(() {
                    dropDownValuevist2 = newValue!;
                  });
                  // Llamando a la función externa con el nuevo valor
                  widget.onValueChanged(dropDownValuevist2);
                },
                items: const [
                  DropdownMenuItem(
                    value: '1',
                    child: Text('Basico'),
                  ),
                  DropdownMenuItem(
                    value: '2',
                    child: Text('Fast'),
                  ),
                  DropdownMenuItem(
                    value: '3',
                    child: Text('Super Fast'),
                  ),
                  DropdownMenuItem(
                    value: '4',
                    child: Text('plus 225'),
                  ),
                  DropdownMenuItem(
                    value: '5',
                    child: Text('plus 250'),
                  )
                ]),
          ),
        ],
      ),
    );
  }
}

class Price extends StatelessWidget {
  final TextEditingController montcontroller;

  const Price({Key? key, required this.montcontroller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: montcontroller,
      keyboardType: TextInputType.number,
      textCapitalization: TextCapitalization.words,
      style: const TextStyle(color: Color.fromRGBO(255, 255, 230, 0.6)),
      decoration: const InputDecoration(
        prefixIcon: Icon(
          Icons.account_balance_wallet,
          color: Color.fromRGBO(255, 255, 230, 0.6),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.all(Radius.circular(5.5)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.all(Radius.circular(5.5)),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        isDense: true,
        hintText: 'Monto',
        hintStyle: TextStyle(
            color: Color.fromRGBO(255, 255, 230, 0.6),
            fontSize: 16.0,
            fontWeight: FontWeight.bold),
        filled: true,
        fillColor: Color.fromRGBO(31, 41, 55, 1),
      ),
    );
  }
}
