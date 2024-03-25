import 'package:budy/paypal_constants.dart';
import 'package:budy/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paypal/flutter_paypal.dart';

class PayPal extends StatefulWidget {
  const PayPal({Key? key}) : super(key: key);

  @override
  State<PayPal> createState() => _PayPalState();
}

class _PayPalState extends State<PayPal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Replace these values with your PayPal sandbox credentials
            const String clientId =
                Constants.clientId;
            const String secretKey =
                Constants.secret;

            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) => UsePaypal(
                  sandboxMode: true,
                  clientId: clientId,
                  secretKey: secretKey,
                  returnURL: Constants.returnURL,
                  cancelURL: Constants.cancelURL,
                  transactions: const [
                    {
                      "amount": {
                        "total": '10.12',
                        "currency": "USD",
                        "details": {
                          "subtotal": '10.12',
                          "shipping": '0',
                          "shipping_discount": 0
                        }
                      },
                      "description": "The payment transaction description.",
                      // "payment_options": {
                      //   "allowed_payment_method":
                      //       "INSTANT_FUNDING_SOURCE"
                      // },
                      "item_list": {
                        "items": [
                          {
                            "name": "A demo product",
                            "quantity": 1,
                            "price": '10.12',
                            "currency": "USD"
                          }
                        ],
                        // shipping address is not required though
                        "shipping_address": {
                          "recipient_name": "Jane Foster",
                          "line1": "Travis County",
                          "line2": "",
                          "city": "Austin",
                          "country_code": "US",
                          "postal_code": "73301",
                          "phone": "+00000000",
                          "state": "Texas"
                        },
                      }
                    }
                  ],
                  note: "Contact us for any questions on your order.",
                  onSuccess: (Map params) async {
                    print("onSuccess: $params");
                    UIHelper.showAlertDialogue(
                        context, 'Success', 'Payment successful');

                    // Handle success callback
                  },
                  onError: (error) {
                    print("onError: $error");
                    UIHelper.showAlertDialogue(
                        context, 'Error', 'Payment failed');
                    // Handle error callback
                  },
                  onCancel: (params) {
                    print('cancelled: $params');
                    UIHelper.showAlertDialogue(
                        context, 'Cancelled', 'Payment cancelled');
                    // Handle cancel callback
                  },
                ),
              ),
            );
          },
          child: const Text("Pay with PayPal"),
        ),
      ),
    );
  }
}
