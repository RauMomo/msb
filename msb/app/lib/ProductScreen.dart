import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:msb/ProductDetailScreen.dart';
import 'package:msb/api/product_api.dart';
import 'package:msb/notifier/ProductNotifier.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatefulWidget {
  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  TabController controller;
  ProductNotifier productNotifier;
  @override
  void initState() {
    controller = new TabController(vsync: this, length: 3);
    productNotifier = ProductNotifier();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<Null> _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
  }

  Widget build(BuildContext context) {
    super.build(context);
    ProductNotifier productNotifier = Provider.of<ProductNotifier>(context);
    final widget = List.generate(
      productNotifier.productList.length,
      (index) => new Card(
        borderOnForeground: true,
        child: InkWell(
          splashColor: Colors.blue.shade300,
          onTap: () {
            productNotifier.currentProduct = productNotifier.productList[index];
            Navigator.of(context).push(
              MaterialPageRoute(builder: (BuildContext context) {
                return ProductDetailScreen();
              }),
            );
          },
          child: Container(
            height: MediaQuery.of(context).size.height / 8,
            width: MediaQuery.of(context).size.width,
            child: new ListTile(
              title: Text(
                productNotifier.productList[index].name,
                textAlign: TextAlign.center,
              ),
              subtitle: Text(
                  'Stock: ' +
                      productNotifier.productList[index].stock.toString(),
                  textAlign: TextAlign.center),
            ),
          ),
        ),
      ),
    );
    return Scaffold(
      resizeToAvoidBottomInset: false,
      primary: true,
      appBar: AppBar(
        title: Text('Product'),
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
                  Tab(text: "New Items"),
                  Tab(text: "Popular Items"),
                  Tab(text: "All Items")
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: TextField(
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    prefixIcon: new Icon(Icons.search, color: Colors.black),
                    focusColor: Colors.blue,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      var searchKey = value;
                      if (searchKey.length > 3) {
                        productNotifier.productList =
                            productNotifier.searchResult;
                        searchQuery(searchKey, productNotifier);
                      } else {
                        getProducts(productNotifier);
                      }
                    });
                  }),
            ),
            Stack(
              children: <Widget>[
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: MediaQuery.of(context).size.height * 0.56,
                        width: MediaQuery.of(context).size.width,
                        child: TabBarView(
                          controller: controller,
                          children: <Widget>[
                            NewItems(),
                            PopularItems(),
                            Container(
                              // child: StreamBuilder(
                              //   stream: FirebaseFirestore.instance
                              //       .collection('products')
                              //       .snapshots(),
                              //   builder: (context, snapshot) {
                              // if (!snapshot.hasData) {
                              //   return Center(
                              //     child: CircularProgressIndicator(),
                              //   );
                              // } else
                              //   return Column(children: <Widget>[
                              child: RefreshIndicator(
                                onRefresh: _onRefresh,
                                child: ListView(
                                  controller: ScrollController(),
                                  itemExtent: 200,
                                  children: widget,
                                ),
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

  @override
  bool get wantKeepAlive => true;
}

_onRefresh() {}

class AllItems extends State<ProductScreen>
    with AutomaticKeepAliveClientMixin<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      child: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('products').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text('Loading...', style: TextStyle(fontSize: 20)),
            );
          } else
            return ListView.builder(
              itemCount: 20,
              itemBuilder: (BuildContext context, int index) => new Card(
                borderOnForeground: true,
                child: InkWell(
                  splashColor: Colors.blue.shade300,
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => ProductDetailScreen(),
                    //   ),
                    // );
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height / 8,
                    width: MediaQuery.of(context).size.width,
                    child: new ListTile(
                      title: Text(
                        snapshot.data.documents[index]['product_name'],
                        textAlign: TextAlign.center,
                      ),
                      subtitle: Text(
                          'Stock: ' +
                              snapshot.data.documents[index]['product_stock']
                                  .toString(),
                          textAlign: TextAlign.center),
                    ),
                  ),
                ),
              ),
            );
        },
      ),
    );
  }

  Widget _buildAllItems(BuildContext context, DocumentSnapshot document) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Card(
          borderOnForeground: true,
          child: InkWell(
            splashColor: Colors.blue.shade300,
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => ProductDetailScreen(),
              //   ),
              // );
            },
            child: Container(
              height: MediaQuery.of(context).size.height / 8,
              width: MediaQuery.of(context).size.width,
              child: new ListTile(
                title: Text(
                  document['product_name'],
                  textAlign: TextAlign.center,
                ),
                subtitle: Text('Stock: ' + document['product_stock'].toString(),
                    textAlign: TextAlign.center),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class PopularItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      children: <Widget>[
        Card(
          borderOnForeground: true,
          child: InkWell(
            splashColor: Colors.blue.shade300,
            onTap: () {
              print('True');
            },
            child: Container(
              height: MediaQuery.of(context).size.height / 8,
              width: MediaQuery.of(context).size.width,
              child: new ListTile(
                title: Text(
                  'ADAPTOR (POWER SUPPLY) BM 28',
                  textAlign: TextAlign.center,
                ),
                subtitle: Text('Stock: 5', textAlign: TextAlign.center),
              ),
            ),
          ),
        ),
        Card(
          borderOnForeground: true,
          child: InkWell(
            splashColor: Colors.blue.shade300,
            onTap: () {
              print('True');
            },
            child: Container(
              height: MediaQuery.of(context).size.height / 8,
              width: MediaQuery.of(context).size.width,
              child: new ListTile(
                title: Text(
                  'ADAPTOR (POWER SUPPLY) BM 28',
                  textAlign: TextAlign.center,
                ),
                subtitle: Text('Stock: 5', textAlign: TextAlign.center),
              ),
            ),
          ),
        ),
        Card(
          borderOnForeground: true,
          child: InkWell(
            splashColor: Colors.blue.shade300,
            onTap: () {
              print('True');
            },
            child: Container(
              height: MediaQuery.of(context).size.height / 8,
              width: MediaQuery.of(context).size.width,
              child: new ListTile(
                title: Text(
                  'ADAPTOR (POWER SUPPLY) BM 28',
                  textAlign: TextAlign.center,
                ),
                subtitle: Text('Stock: 5', textAlign: TextAlign.center),
              ),
            ),
          ),
        ),
        Card(
          borderOnForeground: true,
          child: InkWell(
            splashColor: Colors.blue.shade300,
            onTap: () {
              print('True');
            },
            child: Container(
              height: MediaQuery.of(context).size.height / 8,
              width: MediaQuery.of(context).size.width,
              child: new ListTile(
                title: Text(
                  'ADAPTOR (POWER SUPPLY) BM 28',
                  textAlign: TextAlign.center,
                ),
                subtitle: Text('Stock: 5', textAlign: TextAlign.center),
              ),
            ),
          ),
        ),
        Card(
          borderOnForeground: true,
          child: InkWell(
            splashColor: Colors.blue.shade300,
            onTap: () {
              print('True');
            },
            child: Container(
              height: MediaQuery.of(context).size.height / 8,
              width: MediaQuery.of(context).size.width,
              child: new ListTile(
                title: Text(
                  'ADAPTOR (POWER SUPPLY) BM 28',
                  textAlign: TextAlign.center,
                ),
                subtitle: Text('Stock: 5', textAlign: TextAlign.center),
              ),
            ),
          ),
        ),
        Card(
          borderOnForeground: true,
          child: InkWell(
            splashColor: Colors.blue.shade300,
            onTap: () {
              print('True');
            },
            child: Container(
              height: MediaQuery.of(context).size.height / 8,
              width: MediaQuery.of(context).size.width,
              child: new ListTile(
                title: Text(
                  'ADAPTOR (POWER SUPPLY) BM 28',
                  textAlign: TextAlign.center,
                ),
                subtitle: Text('Stock: 5', textAlign: TextAlign.center),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class NewItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      children: <Widget>[
        Card(
          borderOnForeground: true,
          child: InkWell(
            splashColor: Colors.blue.shade300,
            onTap: () {
              print('True');
            },
            child: Container(
              height: MediaQuery.of(context).size.height / 8,
              width: MediaQuery.of(context).size.width,
              child: new ListTile(
                title: Text(
                  'ADAPTOR (POWER SUPPLY) BM 28',
                  textAlign: TextAlign.center,
                ),
                subtitle: Text('Stock: 5', textAlign: TextAlign.center),
              ),
            ),
          ),
        ),
        Card(
          borderOnForeground: true,
          child: InkWell(
            splashColor: Colors.blue.shade300,
            onTap: () {
              print('True');
            },
            child: Container(
              height: MediaQuery.of(context).size.height / 8,
              width: MediaQuery.of(context).size.width,
              child: new ListTile(
                title: Text(
                  'ADAPTOR (POWER SUPPLY) BM 28',
                  textAlign: TextAlign.center,
                ),
                subtitle: Text('Stock: 5', textAlign: TextAlign.center),
              ),
            ),
          ),
        ),
        Card(
          borderOnForeground: true,
          child: InkWell(
            splashColor: Colors.blue.shade300,
            onTap: () {
              print('True');
            },
            child: Container(
              height: MediaQuery.of(context).size.height / 8,
              width: MediaQuery.of(context).size.width,
              child: new ListTile(
                title: Text(
                  'ADAPTOR (POWER SUPPLY) BM 28',
                  textAlign: TextAlign.center,
                ),
                subtitle: Text('Stock: 5', textAlign: TextAlign.center),
              ),
            ),
          ),
        ),
        Card(
          borderOnForeground: true,
          child: InkWell(
            splashColor: Colors.blue.shade300,
            onTap: () {
              print('True');
            },
            child: Container(
              height: MediaQuery.of(context).size.height / 8,
              width: MediaQuery.of(context).size.width,
              child: new ListTile(
                title: Text(
                  'ADAPTOR (POWER SUPPLY) BM 28',
                  textAlign: TextAlign.center,
                ),
                subtitle: Text('Stock: 5', textAlign: TextAlign.center),
              ),
            ),
          ),
        ),
        Card(
          borderOnForeground: true,
          child: InkWell(
            splashColor: Colors.blue.shade300,
            onTap: () {
              print('True');
            },
            child: Container(
              height: MediaQuery.of(context).size.height / 8,
              width: MediaQuery.of(context).size.width,
              child: new ListTile(
                title: Text(
                  'ADAPTOR (POWER SUPPLY) BM 28',
                  textAlign: TextAlign.center,
                ),
                subtitle: Text('Stock: 5', textAlign: TextAlign.center),
              ),
            ),
          ),
        ),
        Card(
          borderOnForeground: true,
          child: InkWell(
            splashColor: Colors.blue.shade300,
            onTap: () {
              print('True');
            },
            child: Container(
              height: MediaQuery.of(context).size.height / 8,
              width: MediaQuery.of(context).size.width,
              child: new ListTile(
                title: Text(
                  'ADAPTOR (POWER SUPPLY) BM 28',
                  textAlign: TextAlign.center,
                ),
                subtitle: Text('Stock: 5', textAlign: TextAlign.center),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
