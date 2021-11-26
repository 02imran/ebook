import 'package:aamarpay/aamarpay.dart';
import 'package:flutter/material.dart';

class MyPay extends StatefulWidget {
  @override
  _MyPayState createState() => _MyPayState();
}

class _MyPayState extends State<MyPay> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AamarpayData(
          returnUrl: (url) {
            print(url);
          },
          isLoading: (v) {
            setState(() {
              isLoading = v;
            });
          },
          paymentStatus: (status) {
            print(status);
          },
          cancelUrl: "example.com/payment/cancel",
          successUrl: "example.com/payment/confirm",
          failUrl: "example.com/payment/fail",
          customerEmail: "masumbillahsanjid@gmail.com",
          customerMobile: "01834760591",
          customerName: "Masum Billah Sanjid",
          signature: "dbb74894e82415a2f7ff0ec3a97e4183",
          storeID: "aamarpaytest",
          transactionAmount: "100",
          transactionID: "daktarkhanabd",
          description: "test",
          url: "https://secure.aamarpay.com",
          child: isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Container(
                  color: Colors.lightBlue,
                  height: 70,
                  width: 200,
                  child: Center(
                      child: Text(
                    "Payment Method",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20),
                  )),
                ),
        ),
      ),
    );
  }
}