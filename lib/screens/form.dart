import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainForm extends StatefulWidget {
  MainForm({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MainFormState createState() => _MainFormState();
}

class _MainFormState extends State<MainForm> {
  String urlValue =
      "https://secure.micuentaweb.pe/vads-payment/entry.silentInit.a";
  String currencyValue = "PEN";
  String languageValue = "ES";

  late String? _dataModel;

  final formGlobalKey = GlobalKey<FormState>();
  String paymentModeValue = "TEST";
  TextEditingController amountController = TextEditingController();
  TextEditingController orderIdController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  Future<String?> _submitForm(String language, String amount, String email,
      String orderId, String paymentMode, String currency) async {
    try {
      var response = await http.post(
        Uri.parse("https://citas.ramsesconsulting.com/link.php"),
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'email': email,
          'amount': amount,
        },
      );
      if (response.statusCode != 200) return null;
      var data = jsonDecode(response.body);
      String responseString = data['redirect_url'].toString();
      return responseString;
    } on Exception catch (_) {
      print("");
      return null;
    }
  }

  _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      urlValue = (prefs.getString("url") ?? "");
      currencyValue = (prefs.getString("currency") ?? "");
      languageValue = (prefs.getString("language") ?? "");
    });
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(widget.title),
              new IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/configuration');
                  },
                  icon: new Icon(Icons.settings_rounded))
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: formGlobalKey,
            child: Wrap(
              spacing: 10,
              children: [
                // Amount
                const SizedBox(height: 50),
                TextFormField(
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                  ],
                  decoration:
                      InputDecoration(labelText: "Amount", hintText: "0"),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter an amount";
                    }
                  },
                ),
                // Email
                const SizedBox(height: 15),
                TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        labelText: "Email", hintText: "example@email.com"),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter your email";
                      }
                    }),
                // Order ID
                const SizedBox(height: 15),
                TextFormField(
                  controller: orderIdController,
                  keyboardType: TextInputType.text,
                  decoration:
                      InputDecoration(labelText: "Order ID", hintText: ""),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter an order ID";
                    }
                  },
                ),
                const SizedBox(height: 60),

                ElevatedButton(
                    onPressed: () async {
                      String language = languageValue;
                      String amount = amountController.text;
                      String email = emailController.text;
                      String orderId = orderIdController.text;
                      String paymentMode = paymentModeValue;
                      String currency = currencyValue;
                      if (formGlobalKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Redirecting')),
                        );
                        String? data = await _submitForm(language, amount,
                            email, orderId, paymentMode, currency);
                        setState(() {
                          _dataModel = data;
                        });
                        Navigator.pushNamed(context, '/webview',
                            arguments: {'response': data});
                      }
                    },
                    child: Text("Realizar el pago"))
              ],
            ),
          ),
        ));
  }
}
