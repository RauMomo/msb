import 'package:flutter/material.dart';
import 'package:msb/HistoryTransactionDetailScreen.dart';
import 'package:msb/HomeScreen.dart';
import 'package:msb/api/transaction_api.dart';
import 'package:msb/notifier/TransactionNotifier.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:msb/model/TransactionModel.dart';

class HistoryTransactionScreen extends StatefulWidget {
  _HistoryTransactionState createState() => _HistoryTransactionState();
}

class _HistoryTransactionState extends State<HistoryTransactionScreen>
    with SingleTickerProviderStateMixin {
  TabController controller;
  @override
  void initState() {
    controller = new TabController(vsync: this, length: 2);
    TransactionNotifier transactionNotifier =
        Provider.of<TransactionNotifier>(context, listen: false);
    getPendingTransactionList(transactionNotifier);
    getSuccessTransactionList(transactionNotifier);
    super.initState();
  }

  void dispose() {
    super.dispose();
  }

  Widget build(BuildContext context) {
    TransactionNotifier transactionNotifier =
        Provider.of<TransactionNotifier>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Transaction History'),
        elevation: 0.0,
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: TabBar(
                controller: controller,
                labelColor: Colors.black,
                tabs: [
                  Tab(text: "Pending Transactions"),
                  Tab(text: "Verified Transactions"),
                ],
              ),
            ),
            Stack(
              children: <Widget>[
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: MediaQuery.of(context).size.height * 0.8,
                        width: MediaQuery.of(context).size.width,
                        child: TabBarView(
                          controller: controller,
                          children: [
                            Container(
                              child: ListView.builder(
                                physics: ScrollPhysics(),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 20),
                                itemCount: transactionNotifier
                                    .pendingTransactionList.length,
                                itemBuilder: (context, index) =>
                                    transactionNotifier.pendingTransactionList
                                                .length ==
                                            null
                                        ? Center(child: Text('No Data'))
                                        : Card(
                                            borderOnForeground: true,
                                            child: InkWell(
                                              splashColor: Colors.blue.shade300,
                                              onTap: () {
                                                transactionNotifier
                                                        .currentTransaction =
                                                    transactionNotifier
                                                            .pendingTransactionList[
                                                        index];
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(builder:
                                                      (BuildContext context) {
                                                    return HistoryTransactionDetailScreen();
                                                  }),
                                                );
                                              },
                                              child: Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    8,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: new ListTile(
                                                  title: transactionNotifier
                                                              .pendingTransactionList[
                                                                  index]
                                                              .totalProduct >
                                                          1
                                                      ? Text(transactionNotifier
                                                              .pendingTransactionList[
                                                                  index]
                                                              .totalProduct
                                                              .toString() +
                                                          ' Items')
                                                      : Text(transactionNotifier
                                                              .pendingTransactionList[
                                                                  index]
                                                              .totalProduct
                                                              .toString() +
                                                          ' Item'),
                                                  subtitle: Text(
                                                      'Delivered to : ' +
                                                          transactionNotifier
                                                              .pendingTransactionList[
                                                                  index]
                                                              .supplier,
                                                      textAlign:
                                                          TextAlign.center),
                                                ),
                                              ),
                                            ),
                                          ),
                              ),
                            ),
                            Container(
                              child: ListView.builder(
                                physics: ScrollPhysics(),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 20),
                                itemCount: transactionNotifier
                                    .successTransactionList.length,
                                itemBuilder: (BuildContext context,
                                        int index) =>
                                    transactionNotifier.successTransactionList
                                                .length !=
                                            null
                                        ? Card(
                                            borderOnForeground: true,
                                            child: InkWell(
                                              splashColor: Colors.blue.shade300,
                                              onTap: () {
                                                transactionNotifier
                                                        .currentTransaction =
                                                    transactionNotifier
                                                            .successTransactionList[
                                                        index];
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(builder:
                                                      (BuildContext context) {
                                                    return HistoryTransactionDetailScreen();
                                                  }),
                                                );
                                              },
                                              child: Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    8,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: new ListTile(
                                                  title: transactionNotifier
                                                              .successTransactionList[
                                                                  index]
                                                              .totalProduct >
                                                          1
                                                      ? Text(transactionNotifier
                                                              .successTransactionList[
                                                                  index]
                                                              .totalProduct
                                                              .toString() +
                                                          ' Items')
                                                      : Text(transactionNotifier
                                                              .successTransactionList[
                                                                  index]
                                                              .totalProduct
                                                              .toString() +
                                                          ' Item'),
                                                  subtitle: Text(
                                                      'Delivered to ' +
                                                          transactionNotifier
                                                              .successTransactionList[
                                                                  index]
                                                              .supplier,
                                                      textAlign:
                                                          TextAlign.center),
                                                ),
                                              ),
                                            ),
                                          )
                                        : Center(child: Text("No data")),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// class VerifiedTransaction extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ListView(
//       padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//       children: <Widget>[
//         Text(
//           '24 November 2020',
//           style: TextStyle(fontSize: 17, color: Colors.black),
//         ),
//         Card(
//           borderOnForeground: true,
//           child: InkWell(
//             splashColor: Colors.blue.shade300,
//             onTap: () {},
//             child: Container(
//               height: MediaQuery.of(context).size.height / 8,
//               width: MediaQuery.of(context).size.width,
//               child: new ListTile(
//                 title: Text(
//                   '3 Items',
//                   textAlign: TextAlign.center,
//                 ),
//                 subtitle: Text('Delivered to Apotik Keluarga',
//                     textAlign: TextAlign.center),
//               ),
//             ),
//           ),
//         ),
//         Card(
//           borderOnForeground: true,
//           child: InkWell(
//             splashColor: Colors.blue.shade300,
//             onTap: () {},
//             child: Container(
//               height: MediaQuery.of(context).size.height / 8,
//               width: MediaQuery.of(context).size.width,
//               child: new ListTile(
//                 title: Text(
//                   '4 Items',
//                   textAlign: TextAlign.center,
//                 ),
//                 subtitle: Text('Delivered to Apotik Keluarga',
//                     textAlign: TextAlign.center),
//               ),
//             ),
//           ),
//         ),
//         Text(
//           '23 November 2020',
//           style: TextStyle(fontSize: 17, color: Colors.black),
//         ),
//         Card(
//           borderOnForeground: true,
//           child: InkWell(
//             splashColor: Colors.blue.shade300,
//             onTap: () {},
//             child: Container(
//               height: MediaQuery.of(context).size.height / 8,
//               width: MediaQuery.of(context).size.width,
//               child: new ListTile(
//                 title: Text(
//                   '2 Items',
//                   textAlign: TextAlign.center,
//                 ),
//                 subtitle: Text('Delivered to Kimia Farma',
//                     textAlign: TextAlign.center),
//               ),
//             ),
//           ),
//         ),
//         Card(
//           borderOnForeground: true,
//           child: InkWell(
//             splashColor: Colors.blue.shade300,
//             onTap: () {},
//             child: Container(
//               height: MediaQuery.of(context).size.height / 8,
//               width: MediaQuery.of(context).size.width,
//               child: new ListTile(
//                 title: Text(
//                   '4 Items',
//                   textAlign: TextAlign.center,
//                 ),
//                 subtitle: Text('Delivered to Apotik Keluarga',
//                     textAlign: TextAlign.center),
//               ),
//             ),
//           ),
//         ),
//         Card(
//           borderOnForeground: true,
//           child: InkWell(
//             splashColor: Colors.blue.shade300,
//             onTap: () {},
//             child: Container(
//               height: MediaQuery.of(context).size.height / 8,
//               width: MediaQuery.of(context).size.width,
//               child: new ListTile(
//                 title: Text(
//                   '4 Items',
//                   textAlign: TextAlign.center,
//                 ),
//                 subtitle: Text('Delivered to Apotik Keluarga',
//                     textAlign: TextAlign.center),
//               ),
//             ),
//           ),
//         ),
//         Card(
//           borderOnForeground: true,
//           child: InkWell(
//             splashColor: Colors.blue.shade300,
//             onTap: () {},
//             child: Container(
//               height: MediaQuery.of(context).size.height / 8,
//               width: MediaQuery.of(context).size.width,
//               child: new ListTile(
//                 title: Text(
//                   '3 Items',
//                   textAlign: TextAlign.center,
//                 ),
//                 subtitle: Text('Delivered to Apotik ABC',
//                     textAlign: TextAlign.center),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

// class PendingTransaction extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return ListView(
//       padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//       children: <Widget>[
//         Text(
//           '24 November 2020',
//           style: TextStyle(fontSize: 17, color: Colors.black),
//         ),
//         Card(
//           borderOnForeground: true,
//           child: InkWell(
//             splashColor: Colors.blue.shade300,
//             onTap: () {},
//             child: Container(
//               height: MediaQuery.of(context).size.height / 8,
//               width: MediaQuery.of(context).size.width,
//               child: new ListTile(
//                 title: Text(
//                   '4 Items',
//                   textAlign: TextAlign.center,
//                 ),
//                 subtitle: Text('Delivered to Apotik Keluarga',
//                     textAlign: TextAlign.center),
//               ),
//             ),
//           ),
//         ),
//         Card(
//           borderOnForeground: true,
//           child: InkWell(
//             splashColor: Colors.blue.shade300,
//             onTap: () {},
//             child: Container(
//               height: MediaQuery.of(context).size.height / 8,
//               width: MediaQuery.of(context).size.width,
//               child: new ListTile(
//                 title: Text(
//                   '4 Items',
//                   textAlign: TextAlign.center,
//                 ),
//                 subtitle: Text('Delivered to Apotik Keluarga',
//                     textAlign: TextAlign.center),
//               ),
//             ),
//           ),
//         ),
//         Card(
//           borderOnForeground: true,
//           child: InkWell(
//             splashColor: Colors.blue.shade300,
//             onTap: () {},
//             child: Container(
//               height: MediaQuery.of(context).size.height / 8,
//               width: MediaQuery.of(context).size.width,
//               child: new ListTile(
//                 title: Text(
//                   '4 Items',
//                   textAlign: TextAlign.center,
//                 ),
//                 subtitle: Text('Delivered to Apotik Keluarga',
//                     textAlign: TextAlign.center),
//               ),
//             ),
//           ),
//         ),
//         Card(
//           borderOnForeground: true,
//           child: InkWell(
//             splashColor: Colors.blue.shade300,
//             onTap: () {},
//             child: Container(
//               height: MediaQuery.of(context).size.height / 8,
//               width: MediaQuery.of(context).size.width,
//               child: new ListTile(
//                 title: Text(
//                   '4 Items',
//                   textAlign: TextAlign.center,
//                 ),
//                 subtitle: Text('Delivered to Apotik Keluarga',
//                     textAlign: TextAlign.center),
//               ),
//             ),
//           ),
//         ),
//         Card(
//           borderOnForeground: true,
//           child: InkWell(
//             splashColor: Colors.blue.shade300,
//             onTap: () {},
//             child: Container(
//               height: MediaQuery.of(context).size.height / 8,
//               width: MediaQuery.of(context).size.width,
//               child: new ListTile(
//                 title: Text(
//                   '4 Items',
//                   textAlign: TextAlign.center,
//                 ),
//                 subtitle: Text('Delivered to Apotik Keluarga',
//                     textAlign: TextAlign.center),
//               ),
//             ),
//           ),
//         ),
//         Card(
//           borderOnForeground: true,
//           child: InkWell(
//             splashColor: Colors.blue.shade300,
//             onTap: () {},
//             child: Container(
//               height: MediaQuery.of(context).size.height / 8,
//               width: MediaQuery.of(context).size.width,
//               child: new ListTile(
//                 title: Text(
//                   '4 Items',
//                   textAlign: TextAlign.center,
//                 ),
//                 subtitle: Text('Delivered to Apotik Keluarga',
//                     textAlign: TextAlign.center),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
