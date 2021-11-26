import 'dart:async';
import 'dart:convert';

import 'package:aamarpay/aamarpay.dart';
import 'package:ebook/authentication/firebase_login.dart';
import 'package:ebook/models/book_list_model.dart';
import 'package:ebook/screens/apps_informations/information_pdf_format.dart';
import 'package:ebook/screens/book_details_pdf.dart';
import 'package:ebook/utils/file_format.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sslcommerz/model/SSLCSdkType.dart';
import 'package:flutter_sslcommerz/model/SSLCTransactionInfoModel.dart';
import 'package:flutter_sslcommerz/model/SSLCommerzInitialization.dart';
import 'package:flutter_sslcommerz/model/SSLCurrencyType.dart';
import 'package:flutter_sslcommerz/sslcommerz.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../amar_pay_getway.dart';

class HomeScreen extends StatefulWidget {
  final User user;

  HomeScreen(this.user);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isSendingVerification = false;

  bool _isSigningOut = false;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: Drawer(
          child: _buildDrawer(context),
        ),
        appBar: AppBar(
          title: Text('Home'),
        ),
        body: _buildHomeBody(),
      ),
    );
  }

  Widget _buildDrawer(context) {
    return Container(
      color: Colors.cyan,
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            child: Stack(
              children: [
                Positioned(
                  top: 20.0,
                  left: 20.0,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.teal,
                    child: Image.asset('assets/logo.png'),
                  ),
                ),
                Positioned(
                  child: Text(widget.user.email!),
                  top: 180,
                  left: 20,
                ),
                Positioned(
                  child: Text(widget.user.displayName!),
                  top: 150,
                  left: 20,
                ),
                Positioned(
                  bottom: 20,
                  left: 20,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      widget.user.emailVerified
                          ? Text(
                              'Email verified',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(color: Colors.green),
                            )
                          : Text(
                              'Email not verified',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(color: Colors.red),
                            ),
                      SizedBox(width: 6.0),
                      _isSendingVerification
                          ? CircularProgressIndicator()
                          : widget.user.emailVerified
                              ? Container()
                              : Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () async {
                                        setState(() {
                                          _isSendingVerification = true;
                                        });
                                        await widget.user
                                            .sendEmailVerification();
                                        setState(() {
                                          _isSendingVerification = false;
                                        });
                                      },
                                      child: Text('Verify email'),
                                    ),
                                  ],
                                ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          /// About Us
          InkWell(
            onTap: () async {
              String aboutFile = 'assets/information_file/aboutus.pdf';
              final file = await FileFormat.loadAsset(aboutFile);

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      InformationPDFFormat(file: file, titleName: 'About Us '),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Icon(
                    Icons.account_box_outlined,
                    color: Colors.white,
                    size: 30,
                  ),
                  Text(
                    ' About Us  ',
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            ),
          ),

          /// Contact Us
          InkWell(
            onTap: () async {
              String contactFile = 'assets/information_file/contactus.pdf';
              final file = await FileFormat.loadAsset(contactFile);

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => InformationPDFFormat(
                      file: file, titleName: 'Contact Us '),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Icon(
                    Icons.contact_phone_outlined,
                    color: Colors.white,
                    size: 30,
                  ),
                  Text(
                    ' Contact Us  ',
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            ),
          ),

          /// Policy
          InkWell(
            onTap: () async {
              String policyFile = 'assets/information_file/policy.pdf';
              final file = await FileFormat.loadAsset(policyFile);

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      InformationPDFFormat(file: file, titleName: 'Policy '),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Icon(
                    Icons.policy,
                    color: Colors.white,
                    size: 30,
                  ),
                  Text(
                    ' Policy ',
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            ),
          ),

          /// Terms And Conditions
          InkWell(
            onTap: () async {
              String termsFile =
                  'assets/information_file/termsandconditions.pdf';
              final file = await FileFormat.loadAsset(termsFile);

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => InformationPDFFormat(
                      file: file, titleName: 'Terms And Conditions '),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Icon(
                    Icons.policy,
                    color: Colors.white,
                    size: 30,
                  ),
                  Text(
                    ' Terms And Conditions ',
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            ),
          ),

          Divider(
            color: Colors.white,
          ),
          _isSigningOut
              ? CircularProgressIndicator()
              : ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      _isSigningOut = true;
                    });
                    await FirebaseAuth.instance.signOut();
                    setState(() {
                      _isSigningOut = false;
                    });
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => LoginPage(),
                      ),
                    );
                  },
                  child: Text(
                    'Sign out',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  Widget _buildHomeBody() {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: bookListCollection.length,
        itemBuilder: (BuildContext ctx, index) {
          BookListModel _bookInfo = bookListCollection[index];
          return buildListViewUI(_bookInfo, ctx);
        });
  }

  Widget buildListViewUI(BookListModel eBook, BuildContext context) {
    return InkWell(
      onTap: () async {
        print(' Pay Now .....');
        final file = await FileFormat.loadAsset(eBook.bPdf!);

        ///if(payment.status ==ture){
        //goto the viewPDF file
        //}else {goto  the ssl payment}
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BookDetailsPDF(file: file),
          ),
        );

        // sslCommerzGeneralCall();
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 2, horizontal: 2),
        padding: EdgeInsets.symmetric(vertical: 2, horizontal: 2),
        height: 120,
        color: Colors.grey.shade300,
        child: Card(
          elevation: 1,
          color: Colors.white,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                flex: 2,
                child: CircleAvatar(
                  child: Image.asset('assets/logo.png'),
                ),
              ),
              Expanded(
                flex: 5,
                child: Text(
                  '' + eBook.bName.toString(),
                  style: TextStyle(
                      color: Colors.teal,
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                  maxLines: 3,
                  overflow: TextOverflow.clip,
                ),
              ),
              Expanded(
                flex: 2,
                child: GestureDetector(
                  onTap: () async {
                    print(' Online payment : ');

                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => MyPay(),
                      ),
                    );
                  },
                  child: Icon(
                    Icons.lock,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// ssl commerce payment method
  Future<void> sslCommerzGeneralCall() async {
    Sslcommerz sslcommerz = Sslcommerz(
      initializer: SSLCommerzInitialization(
          //Use the ipn if you have valid one, or it will fail the transaction.
          // ipn_url: "www.ipnurl.com",
          // multi_card_name: formData['multicard'],
          currency: SSLCurrencyType.BDT,
          sdkType: SSLCSdkType.TESTBOX,
          store_id: 'taxol5c7cf3257d623',
          //formData['store_id'],
          store_passwd: 'taxol5c7cf3257d623@ssl',
          //formData['store_password'],
          total_amount: 100,
          tran_id: "1231321321321312",
          product_category: ''),
    );
    var result = await sslcommerz.payNow();

    print(' Result SSL Commerce : ' + result.toString());
    if (result is PlatformException) {
      print("the response is: " +
          result.message.toString() +
          " code: " +
          result.code);
    } else {
      SSLCTransactionInfoModel model = result;
      print('***********************************');
      print('Information :' + jsonEncode(model.toString()));
      Fluttertoast.showToast(
          msg: "Transaction successful: Amount ${model.amount} TK",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  amarPayPayment() {
    return AamarpayData(
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
        url: "https://sandbox.aamarpay.com",
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                color: Colors.orange,
                height: 50,
                child: Center(
                    child: Text(
                  "Payment",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                )),
              ));
  }
}
