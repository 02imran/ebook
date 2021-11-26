import 'package:aamarpay/aamarpay.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyPay extends StatefulWidget {
  final User user;

  MyPay(this.user);

  @override
  _MyPayState createState() => _MyPayState();
}

class _MyPayState extends State<MyPay> {
  bool isLoading = false;
  String name = '';
  String mail = '';
  @override
  Widget build(BuildContext context) {
    print('userName :' + widget.user.displayName.toString());
    name = widget.user.displayName.toString();
    mail = widget.user.displayName.toString();
    print('userMail :' + widget.user.email.toString());
    print('userMail :' + widget.user.email.toString());
    return Scaffold(
      backgroundColor: Colors.white,
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
          //storeID: "aamarpaytest",
          transactionAmount: "100",
          transactionID: "daktarkhanabd",
          description: "test",
          url: "https://secure.aamarpay.com",
          child: isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/payment.jpg'),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: EdgeInsets.all(50),
                      padding: EdgeInsets.all(10),
                      height: 100,
                      color: Colors.green,
                      child: Center(
                          child: Text(
                        "Online Payment ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 20),
                      )),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
