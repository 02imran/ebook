

import 'package:ebook/screens/apps_informations/information_pdf_format.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sslcommerz/model/SSLCSdkType.dart';
import 'package:flutter_sslcommerz/model/SSLCTransactionInfoModel.dart';
import 'package:flutter_sslcommerz/model/SSLCommerzInitialization.dart';
import 'package:flutter_sslcommerz/model/SSLCurrencyType.dart';
import 'package:flutter_sslcommerz/sslcommerz.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ebook/authentication/firebase_login.dart';
import 'package:ebook/models/book_list_model.dart';
import 'package:ebook/screens/book_details_pdf.dart';
import 'dart:async';
import 'package:ebook/utils/file_format.dart';

class HomeScreen extends StatefulWidget {
  final User user;

  HomeScreen(this.user);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isSendingVerification = false;

  bool _isSigningOut = false;

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
                    child:   Image.asset('assets/logo.png'),
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
                          : widget.user.emailVerified?
                             Container():
                             Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              setState(() {
                                _isSendingVerification = true;
                              });
                              await widget.user.sendEmailVerification();
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
            onTap: () async{
              String aboutFile='assets/information_file/aboutus.pdf';
              final file = await FileFormat.loadAsset(aboutFile);

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => InformationPDFFormat(file: file),
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
            onTap: () async{
              String contactFile='assets/information_file/contactus.pdf';
              final file = await FileFormat.loadAsset(contactFile);

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => InformationPDFFormat(file: file),
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
            onTap: () async{
              String policyFile='assets/information_file/policy.pdf';
              final file = await FileFormat.loadAsset(policyFile);

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => InformationPDFFormat(file: file),
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
            onTap: () async{
              String termsFile='assets/information_file/termsandconditions.pdf';
              final file = await FileFormat.loadAsset(termsFile);

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => InformationPDFFormat(file: file),
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
            child: Text('Sign out',style: TextStyle(color: Colors.white),),
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
       onTap: (){
        /* Navigator.push(
           context,
           MaterialPageRoute(
             builder: (context) => SSLPaymentScreen(),
           ),
         );*/
         sslCommerzGeneralCall();
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
            tran_id: "1231321321321312", product_category: ''));
    var result = await sslcommerz.payNow();

    print(' Result SSL Commerce : ' + result.toString());
    if (result is PlatformException) {
      print("the response is: " +
          result.message.toString() +
          " code: " +
          result.code);
    } else {
      SSLCTransactionInfoModel model = result;

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
}
