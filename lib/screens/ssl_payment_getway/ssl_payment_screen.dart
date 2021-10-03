import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_sslcommerz/model/SSLCSdkType.dart';

import 'package:flutter_sslcommerz/model/SSLCTransactionInfoModel.dart';
import 'package:flutter_sslcommerz/model/SSLCommerzInitialization.dart';
import 'package:flutter_sslcommerz/model/SSLCurrencyType.dart';

import 'package:flutter_sslcommerz/sslcommerz.dart';



class SSLPaymentScreen extends StatefulWidget {
  @override
  _SSLPaymentScreenState createState() => _SSLPaymentScreenState();
}
// test
class _SSLPaymentScreenState extends State<SSLPaymentScreen> {
  var _key = GlobalKey<FormState>();
  dynamic formData = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Payment Method'),
        ),
        body: Form(
          key: _key,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      initialValue: "testbox",
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(8.0))),
                        hintText: "Store ID",
                      ),
                      validator: (value) {
                        if (value != null)
                          return "Please input store id";
                        else
                          return null;
                      },
                      onSaved: (value) {
                        formData['store_id'] = value;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      initialValue: "qwerty",
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(8.0))),
                        hintText: "Store password",
                      ),
                      validator: (value) {
                        if (value != null)
                          return "Please input store password";
                        else
                          return null;
                      },
                      onSaved: (value) {
                        formData['store_password'] = value;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(8.0))),
                        hintText: "Phone number",
                      ),
                      onSaved: (value) {
                        formData['phone'] = value;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      initialValue: "10",
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(8.0))),
                        hintText: "Payment amount",
                      ),
                      validator: (value) {
                        if (value != null)
                          return "Please input amount";
                        else
                          return null;
                      },
                      onSaved: (value) {
                        formData['amount'] = double.parse(value!);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(8.0))),
                        hintText: "Enter multi card",
                      ),
                      onSaved: (value) {
                        formData['multicard'] = value;
                      },
                    ),
                  ),
                  ElevatedButton(
                    child: Text("Pay now"),
                    onPressed: () {
                      if (_key.currentState != null) {
                        _key.currentState?.save();
                         sslCommerzGeneralCall();
                        //sslCommerzCustomizedCall();
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ),
   );
  }

  Future<void> sslCommerzGeneralCall() async {
    Sslcommerz sslcommerz = Sslcommerz(
        initializer: SSLCommerzInitialization(
          //Use the ipn if you have valid one, or it will fail the transaction.
           // ipn_url: "www.ipnurl.com",
           // multi_card_name: formData['multicard'],
            currency: SSLCurrencyType.BDT,
          //  product_category: "Food",
            sdkType: SSLCSdkType.TESTBOX,
            store_id: 'taxol5c7cf3257d623',
            //formData['store_id'],
            store_passwd: 'taxol5c7cf3257d623@ssl',
            //formData['store_password'],
            total_amount: formData['amount'],
            tran_id: "1231321321321312", product_category: ''));
    var result = await sslcommerz.payNow();
    print('-----------------------------------------------');
    print(' Result SSL Commerce : ' + result.toString());
    if (result is PlatformException) {
      print("the response is: " +
          result.message.toString() +
          " code: " +
          result.code);
    } else {
      SSLCTransactionInfoModel model = result;

   /*   Fluttertoast.showToast(
          msg: "Transaction successful: Amount ${model.amount} TK",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);*/
    }
  }


}