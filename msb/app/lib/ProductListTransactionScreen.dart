import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:msb/HomeScreen.dart';
import 'package:msb/ProductDetailTransactionScreen.dart';
import 'package:msb/api/product_api.dart';
import 'package:msb/component/NumericButton.dart';
import 'package:msb/notifier/CartNotifier.dart';
import 'package:msb/notifier/ProductNotifier.dart';
import 'package:provider/provider.dart';
import 'package:flushbar/flushbar.dart';

class ProductListTransactionScreen extends StatefulWidget {
  _ProductListTransactionScreenState createState() =>
      _ProductListTransactionScreenState();
}

class _ProductListTransactionScreenState
    extends State<ProductListTransactionScreen>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  bool showFab;
  FocusNode focusNode;
  AnimationController controller;
  TextEditingController _textEditingController;
  ProductNotifier productNotifier;
  @override
  void initState() {
    // controller = AnimationController(
    //   vsync: this,
    //   duration: const Duration(milliseconds: 500),
    // );
    focusNode = FocusNode();
    showFab = true;
    _textEditingController = new TextEditingController();
    // productNotifier = ProductNotifier();
    // getProducts(productNotifier);
    super.initState();
  }

  Future<Null> _refreshData(BuildContext context) async {
    await Provider.of<ProductNotifier>(context, listen: false).getProducts();
  }

  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    super.build(context);
    BuildContext builderContext;
    final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
    final TextEditingController searchController = new TextEditingController();
    // final widget = List.generate(
    //   productNotifier.productList.length,
    //   (index) => new Card(
    //     borderOnForeground: true,
    //     child: InkWell(
    //       splashColor: Colors.blue.shade300,
    //       onTap: () {
    //         productNotifier.currentProduct = productNotifier.productList[index];
    //         Navigator.of(context).push(
    //           MaterialPageRoute(builder: (BuildContext context) {
    //             return ProductDetailTransactionScreen();
    //           }),
    //         );
    //       },
    //       child: Container(
    //         height: MediaQuery.of(context).size.height / 8,
    //         width: MediaQuery.of(context).size.width,
    //         child: new ListTile(
    //           title: Text(
    //             productNotifier.productList[index].name,
    //             textAlign: TextAlign.center,
    //           ),
    //           subtitle: Text(
    //               'Stock: ' +
    //                   productNotifier.productList[index].stock.toString(),
    //               textAlign: TextAlign.center),
    //         ),
    //       ),
    //     ),
    //   ),
    // );
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _globalKey,
      appBar: AppBar(title: new Text("Select Items to Add")),
      floatingActionButton: Visibility(
        visible: showFab,
        child: FloatingActionButton(
          heroTag: "tag1",
          backgroundColor: const Color(0xFF11CBD7),
          elevation: 0.0,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(index: 2),
              ),
            );
          },
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(100.0))),
          child: Icon(
            Icons.shopping_cart_outlined,
            color: Colors.white,
          ),
        ),
      ),
      body: Builder(
        builder: (builderContext) => SafeArea(
          child: RefreshIndicator(
              onRefresh: () => _refreshData(context),
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        prefixIcon: new Icon(Icons.search, color: Colors.black),
                        focusColor: Colors.blue,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onChanged: (value) {
                        if (value.length >= 3) {
                          print(value);
                          Provider.of<ProductNotifier>(context, listen: false)
                              .searchQuery(value);
                        } else if (value.isEmpty) {
                          Provider.of<ProductNotifier>(context, listen: false)
                              .getProducts();
                        }
                      },
                    ),
                  ),
                  Container(
                      height: MediaQuery.of(context).size.height * 0.66,
                      width: double.infinity,
                      child: FutureBuilder(
                        future:
                            Provider.of<ProductNotifier>(context, listen: false)
                                .getProducts(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            if (snapshot.hasError) {
                              return Center(
                                child: Text("Error Loading Data"),
                              );
                            } else {
                              return Consumer<ProductNotifier>(
                                builder: (context, productNotifier, child) =>
                                    Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 10.0),
                                  child: ListView.builder(
                                    itemCount:
                                        productNotifier.productList.length,
                                    padding: EdgeInsets.symmetric(vertical: 20),
                                    itemBuilder:
                                        (BuildContext context, int index) =>
                                            new Card(
                                      elevation: 0.0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: InkWell(
                                        splashColor: Colors.blue.shade300,
                                        onTap: () {
                                          productNotifier.currentProduct =
                                              productNotifier
                                                  .productList[index];
                                          Navigator.of(context).push(
                                            MaterialPageRoute(builder:
                                                (BuildContext context) {
                                              return ProductDetailTransactionScreen();
                                            }),
                                          );
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              8,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: ListTile(
                                            title: Text(
                                              productNotifier
                                                  .productList[index].name,
                                              textAlign: TextAlign.left,
                                            ),
                                            subtitle: Text(
                                                'Stock: ' +
                                                    productNotifier
                                                        .productList[index]
                                                        .stock
                                                        .toString(),
                                                textAlign: TextAlign.left),
                                            trailing: IconButton(
                                                alignment:
                                                    Alignment.centerRight,
                                                color: Colors.white,
                                                onPressed: () {
                                                  productNotifier
                                                          .currentProduct =
                                                      productNotifier
                                                          .productList[index];
                                                  showFab = false;
                                                  return modalBottomSheet(
                                                      builderContext,
                                                      productNotifier);
                                                  // cart.addItemtoCart(
                                                  //     productNotifier.currentProduct);
                                                  // ScaffoldMessenger.of(context)
                                                  //     .showSnackBar(new SnackBar(
                                                  //         duration: Duration(
                                                  //             milliseconds: 1500),
                                                  //         content: new Text(
                                                  //           "Added to Cart",
                                                  //         )));
                                                },
                                                icon: Icon(
                                                  Icons.add_circle,
                                                  color:
                                                      const Color(0xFF11CBD7),
                                                  size: 28.0,
                                                )),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }
                          }
                        },
                      )
                      // child: ListView(
                      //   padding: EdgeInsets.symmetric(horizontal: 20),
                      //   controller: ScrollController(),
                      //   children: widget,
                      //   itemExtent: 200,
                      // ),
                      ),
                ],
              )),
          // Stack(
          //   children: <Widget>[
          //     Expanded(
          //       child: Column(
          //         children: <Widget>[
          //           Container(
          //             height: MediaQuery.of(context).size.height * 0.66,
          //             width: MediaQuery.of(context).size.width,
          //             child: Container(
          //                 child: Center(
          //               child: Text("No Items Available"),
          //             )
          //                 //     child: ListView(
          //                 //   padding: EdgeInsets.symmetric(horizontal: 20),
          //                 //   controller: ScrollController(),
          //                 //   children: widget,
          //                 //   itemExtent: 200,
          //                 // )
          //                 // child: StreamBuilder(
          //                 //   stream: FirebaseFirestore.instance
          //                 //       .collection('products')
          //                 //       .snapshots(),
          //                 //   builder: (context, snapshot) {
          //                 // if (!snapshot.hasData) {
          //                 //   return Center(
          //                 //     child: CircularProgressIndicator(),
          //                 //   );
          //                 // } else
          //                 //   return Column(children: <Widget>[
          //                 // child: RefreshIndicator(
          //                 //   onRefresh: _onRefresh,
          //                 // child: ListView.builder(
          //                 //   padding: EdgeInsets.symmetric(horizontal: 20),
          //                 //   physics: ScrollPhysics(),
          //                 //   itemCount: productNotifier.productList.length,
          //                 //   itemBuilder: (BuildContext context, int index) =>
          //                 //       new Card(
          //                 //     borderOnForeground: true,
          //                 //     child: InkWell(
          //                 //       splashColor: Colors.blue.shade300,
          //                 //       onTap: () {
          //                 //         productNotifier.currentProduct =
          //                 //             productNotifier.productList[index];
          //                 //         Navigator.push(
          //                 //           context,
          //                 //           MaterialPageRoute(
          //                 //             builder: (context) =>
          //                 //                 ProductDetailTransactionScreen(),
          //                 //           ),
          //                 //         );
          //                 //       },
          //                 //       child: Container(
          //                 //         height:
          //                 //             MediaQuery.of(context).size.height / 8,
          //                 //         width: MediaQuery.of(context).size.width,
          //                 //         alignment: Alignment.center,
          //                 //         child: new ListTile(
          //                 //           title: Text(
          //                 //             productNotifier.productList[index].name,
          //                 //             textAlign: TextAlign.start,
          //                 //           ),
          //                 //           subtitle: Text(
          //                 //               'Available Stock: ' +
          //                 //                   productNotifier
          //                 //                       .productList[index].stock
          //                 //                       .toString(),
          //                 //               textAlign: TextAlign.left),
          //                 //           trailing: IconButton(
          //                 //               alignment: Alignment.centerRight,
          //                 //               color: Colors.white,
          //                 //               onPressed: () async {
          //                 //                 productNotifier.currentProduct =
          //                 //                     productNotifier
          //                 //                         .productList[index];
          //                 //                 showFab = false;
          //                 //                 showModalBottomSheet(
          //                 //                   transitionAnimationController:
          //                 //                       controller,
          //                 //                   context: context,
          //                 //                   builder:
          //                 //                       (BuildContext context) =>
          //                 //                           Container(
          //                 //                               height: MediaQuery.of(
          //                 //                                           context)
          //                 //                                       .size
          //                 //                                       .height *
          //                 //                                   0.3,
          //                 //                               color: Colors.white,
          //                 //                               padding:
          //                 //                                   EdgeInsets.fromLTRB(
          //                 //                                       20.0,
          //                 //                                       0,
          //                 //                                       20.0,
          //                 //                                       20.0),
          //                 //                               child: Column(
          //                 //                                 mainAxisAlignment:
          //                 //                                     MainAxisAlignment
          //                 //                                         .center,
          //                 //                                 crossAxisAlignment:
          //                 //                                     CrossAxisAlignment
          //                 //                                         .stretch,
          //                 //                                 mainAxisSize:
          //                 //                                     MainAxisSize.max,
          //                 //                                 children: <Widget>[
          //                 //                                   Container(
          //                 //                                     margin: EdgeInsets
          //                 //                                         .symmetric(
          //                 //                                             vertical:
          //                 //                                                 20.0),
          //                 //                                     child: Row(
          //                 //                                         mainAxisAlignment:
          //                 //                                             MainAxisAlignment
          //                 //                                                 .spaceBetween,
          //                 //                                         crossAxisAlignment:
          //                 //                                             CrossAxisAlignment
          //                 //                                                 .start,
          //                 //                                         children: <
          //                 //                                             Widget>[
          //                 //                                           Container(
          //                 //                                             width: MediaQuery.of(context)
          //                 //                                                     .size
          //                 //                                                     .width /
          //                 //                                                 1.5,
          //                 //                                             child:
          //                 //                                                 Text(
          //                 //                                               productNotifier
          //                 //                                                   .currentProduct
          //                 //                                                   .name,
          //                 //                                               style: TextStyle(
          //                 //                                                   fontFamily:
          //                 //                                                       "Segoe_UI_Bold",
          //                 //                                                   fontSize:
          //                 //                                                       18,
          //                 //                                                   fontWeight:
          //                 //                                                       FontWeight.w500),
          //                 //                                             ),
          //                 //                                           ),
          //                 //                                         ]),
          //                 //                                   ),
          //                 //                                   Container(
          //                 //                                     margin: EdgeInsets
          //                 //                                         .symmetric(
          //                 //                                             vertical:
          //                 //                                                 20.0),
          //                 //                                     child: Row(
          //                 //                                         mainAxisAlignment:
          //                 //                                             MainAxisAlignment
          //                 //                                                 .spaceBetween,
          //                 //                                         crossAxisAlignment:
          //                 //                                             CrossAxisAlignment
          //                 //                                                 .start,
          //                 //                                         children: <
          //                 //                                             Widget>[
          //                 //                                           Container(
          //                 //                                             child:
          //                 //                                                 Text(
          //                 //                                               "Price",
          //                 //                                               style: TextStyle(
          //                 //                                                   fontFamily:
          //                 //                                                       "Segoe_UI_Bold",
          //                 //                                                   fontSize:
          //                 //                                                       17,
          //                 //                                                   fontWeight:
          //                 //                                                       FontWeight.w500),
          //                 //                                             ),
          //                 //                                           ),
          //                 //                                           Container(
          //                 //                                             child:
          //                 //                                                 Text(
          //                 //                                               productNotifier
          //                 //                                                   .currentProduct
          //                 //                                                   .price
          //                 //                                                   .toString(),
          //                 //                                               style: TextStyle(
          //                 //                                                   fontFamily:
          //                 //                                                       "Segoe_UI_Bold",
          //                 //                                                   fontSize:
          //                 //                                                       17,
          //                 //                                                   fontWeight:
          //                 //                                                       FontWeight.w500),
          //                 //                                             ),
          //                 //                                           ),
          //                 //                                         ]),
          //                 //                                   ),
          //                 //                                   Container(
          //                 //                                     margin: EdgeInsets
          //                 //                                         .symmetric(
          //                 //                                             vertical:
          //                 //                                                 20.0),
          //                 //                                     child: Row(
          //                 //                                         mainAxisAlignment:
          //                 //                                             MainAxisAlignment
          //                 //                                                 .spaceBetween,
          //                 //                                         crossAxisAlignment:
          //                 //                                             CrossAxisAlignment
          //                 //                                                 .start,
          //                 //                                         children: <
          //                 //                                             Widget>[
          //                 //                                           Container(
          //                 //                                             child:
          //                 //                                                 Text(
          //                 //                                               "Quantity",
          //                 //                                               style: TextStyle(
          //                 //                                                   fontFamily:
          //                 //                                                       "Segoe_UI_Bold",
          //                 //                                                   fontSize:
          //                 //                                                       17,
          //                 //                                                   fontWeight:
          //                 //                                                       FontWeight.w500),
          //                 //                                             ),
          //                 //                                           ),
          //                 //                                           Container(
          //                 //                                             child:
          //                 //                                                 Text(
          //                 //                                               "1",
          //                 //                                               style: TextStyle(
          //                 //                                                   fontFamily:
          //                 //                                                       "Segoe_UI_Bold",
          //                 //                                                   fontSize:
          //                 //                                                       17,
          //                 //                                                   fontWeight:
          //                 //                                                       FontWeight.w500),
          //                 //                                             ),
          //                 //                                           ),
          //                 //                                         ]),
          //                 //                                   ),
          //                 //                                   SizedBox(
          //                 //                                     width: double
          //                 //                                         .infinity,
          //                 //                                     child: FlatButton(
          //                 //                                       shape: RoundedRectangleBorder(
          //                 //                                           borderRadius:
          //                 //                                               BorderRadius.circular(
          //                 //                                                   20.0)),
          //                 //                                       color: const Color(
          //                 //                                           0xFF11CBD7),
          //                 //                                       height: 50.0,
          //                 //                                       onPressed:
          //                 //                                           () {},
          //                 //                                       child: Row(
          //                 //                                         mainAxisSize:
          //                 //                                             MainAxisSize
          //                 //                                                 .max,
          //                 //                                         mainAxisAlignment:
          //                 //                                             MainAxisAlignment
          //                 //                                                 .center,
          //                 //                                         crossAxisAlignment:
          //                 //                                             CrossAxisAlignment
          //                 //                                                 .center,
          //                 //                                         children: <
          //                 //                                             Widget>[
          //                 //                                           Icon(Icons
          //                 //                                               .add_circle),
          //                 //                                           Padding(
          //                 //                                             padding: EdgeInsets.only(
          //                 //                                                 left:
          //                 //                                                     5),
          //                 //                                             child: Text(
          //                 //                                                 "Add to Cart",
          //                 //                                                 textAlign: TextAlign
          //                 //                                                     .end,
          //                 //                                                 style:
          //                 //                                                     new TextStyle(color: Colors.white)),
          //                 //                                           ),
          //                 //                                         ],
          //                 //                                       ),
          //                 //                                     ),
          //                 //                                   ),
          //                 //                                 ],
          //                 //                               )),
          //                 //                 ).whenComplete(() {
          //                 //                   setState(() {
          //                 //                     showFab = true;
          //                 //                   });
          //                 //                 });
          //                 //                 // cart.addItemtoCart(
          //                 //                 //     productNotifier.currentProduct);
          //                 //                 // ScaffoldMessenger.of(context)
          //                 //                 //     .showSnackBar(new SnackBar(
          //                 //                 //         duration: Duration(
          //                 //                 //             milliseconds: 1500),
          //                 //                 //         content: new Text(
          //                 //                 //           "Added to Cart",
          //                 //                 //         )));
          //                 //               },
          //                 //               icon: Icon(
          //                 //                 Icons.add_circle,
          //                 //                 color: const Color(0xFF11CBD7),
          //                 //                 size: 28.0,
          //                 //               )),
          //                 //         ),
          //                 //       ),
          //                 //     ),
          //                 //   ),
          //                 // ),
          //                 // child: ListView.builder(
          //                 //   padding: EdgeInsets.symmetric(horizontal: 20),
          //                 //   physics: ScrollPhysics(),
          //                 //   itemCount: productNotifier.productList.length,
          //                 //   itemBuilder: (BuildContext context, int index) =>
          //                 //       new Card(
          //                 //     borderOnForeground: true,
          //                 //     child: InkWell(
          //                 //       splashColor: Colors.blue.shade300,
          //                 //       onTap: () {
          //                 //         productNotifier.currentProduct =
          //                 //             productNotifier.productList[index];
          //                 //         Navigator.push(
          //                 //           context,
          //                 //           MaterialPageRoute(
          //                 //             builder: (context) =>
          //                 //                 ProductDetailTransactionScreen(),
          //                 //           ),
          //                 //         );
          //                 //       },
          //                 //       child: Container(
          //                 //         height:
          //                 //             MediaQuery.of(context).size.height / 8,
          //                 //         width: MediaQuery.of(context).size.width,
          //                 //         alignment: Alignment.center,
          //                 //         child: new ListTile(
          //                 //           title: Text(
          //                 //             productNotifier.productList[index].name,
          //                 //             textAlign: TextAlign.start,
          //                 //           ),
          //                 //           subtitle: Text(
          //                 //               'Available Stock: ' +
          //                 //                   productNotifier
          //                 //                       .productList[index].stock
          //                 //                       .toString(),
          //                 //               textAlign: TextAlign.left),
          //                 //           trailing: IconButton(
          //                 //               alignment: Alignment.centerRight,
          //                 //               color: Colors.white,
          //                 //               onPressed: () async {
          //                 //                 productNotifier.currentProduct =
          //                 //                     productNotifier
          //                 //                         .productList[index];
          //                 //                 showFab = false;
          //                 //                 showModalBottomSheet(
          //                 //                   transitionAnimationController:
          //                 //                       controller,
          //                 //                   context: context,
          //                 //                   builder:
          //                 //                       (BuildContext context) =>
          //                 //                           Container(
          //                 //                               height: MediaQuery.of(
          //                 //                                           context)
          //                 //                                       .size
          //                 //                                       .height *
          //                 //                                   0.3,
          //                 //                               color: Colors.white,
          //                 //                               padding: EdgeInsets
          //                 //                                   .fromLTRB(20.0, 0,
          //                 //                                       20.0, 20.0),
          //                 //                               child: Column(
          //                 //                                 mainAxisAlignment:
          //                 //                                     MainAxisAlignment
          //                 //                                         .center,
          //                 //                                 crossAxisAlignment:
          //                 //                                     CrossAxisAlignment
          //                 //                                         .stretch,
          //                 //                                 mainAxisSize:
          //                 //                                     MainAxisSize
          //                 //                                         .max,
          //                 //                                 children: <Widget>[
          //                 //                                   Container(
          //                 //                                     margin: EdgeInsets
          //                 //                                         .symmetric(
          //                 //                                             vertical:
          //                 //                                                 20.0),
          //                 //                                     child: Row(
          //                 //                                         mainAxisAlignment:
          //                 //                                             MainAxisAlignment
          //                 //                                                 .spaceBetween,
          //                 //                                         crossAxisAlignment:
          //                 //                                             CrossAxisAlignment
          //                 //                                                 .start,
          //                 //                                         children: <
          //                 //                                             Widget>[
          //                 //                                           Container(
          //                 //                                             width: MediaQuery.of(context).size.width /
          //                 //                                                 1.5,
          //                 //                                             child:
          //                 //                                                 Text(
          //                 //                                               productNotifier
          //                 //                                                   .currentProduct
          //                 //                                                   .name,
          //                 //                                               style: TextStyle(
          //                 //                                                   fontFamily: "Segoe_UI_Bold",
          //                 //                                                   fontSize: 18,
          //                 //                                                   fontWeight: FontWeight.w500),
          //                 //                                             ),
          //                 //                                           ),
          //                 //                                         ]),
          //                 //                                   ),
          //                 //                                   Container(
          //                 //                                     margin: EdgeInsets
          //                 //                                         .symmetric(
          //                 //                                             vertical:
          //                 //                                                 20.0),
          //                 //                                     child: Row(
          //                 //                                         mainAxisAlignment:
          //                 //                                             MainAxisAlignment
          //                 //                                                 .spaceBetween,
          //                 //                                         crossAxisAlignment:
          //                 //                                             CrossAxisAlignment
          //                 //                                                 .start,
          //                 //                                         children: <
          //                 //                                             Widget>[
          //                 //                                           Container(
          //                 //                                             child:
          //                 //                                                 Text(
          //                 //                                               "Price",
          //                 //                                               style: TextStyle(
          //                 //                                                   fontFamily: "Segoe_UI_Bold",
          //                 //                                                   fontSize: 17,
          //                 //                                                   fontWeight: FontWeight.w500),
          //                 //                                             ),
          //                 //                                           ),
          //                 //                                           Container(
          //                 //                                             child:
          //                 //                                                 Text(
          //                 //                                               productNotifier
          //                 //                                                   .currentProduct
          //                 //                                                   .price
          //                 //                                                   .toString(),
          //                 //                                               style: TextStyle(
          //                 //                                                   fontFamily: "Segoe_UI_Bold",
          //                 //                                                   fontSize: 17,
          //                 //                                                   fontWeight: FontWeight.w500),
          //                 //                                             ),
          //                 //                                           ),
          //                 //                                         ]),
          //                 //                                   ),
          //                 //                                   Container(
          //                 //                                     margin: EdgeInsets
          //                 //                                         .symmetric(
          //                 //                                             vertical:
          //                 //                                                 20.0),
          //                 //                                     child: Row(
          //                 //                                         mainAxisAlignment:
          //                 //                                             MainAxisAlignment
          //                 //                                                 .spaceBetween,
          //                 //                                         crossAxisAlignment:
          //                 //                                             CrossAxisAlignment
          //                 //                                                 .start,
          //                 //                                         children: <
          //                 //                                             Widget>[
          //                 //                                           Container(
          //                 //                                             child:
          //                 //                                                 Text(
          //                 //                                               "Quantity",
          //                 //                                               style: TextStyle(
          //                 //                                                   fontFamily: "Segoe_UI_Bold",
          //                 //                                                   fontSize: 17,
          //                 //                                                   fontWeight: FontWeight.w500),
          //                 //                                             ),
          //                 //                                           ),
          //                 //                                           Container(
          //                 //                                             child:
          //                 //                                                 Text(
          //                 //                                               "1",
          //                 //                                               style: TextStyle(
          //                 //                                                   fontFamily: "Segoe_UI_Bold",
          //                 //                                                   fontSize: 17,
          //                 //                                                   fontWeight: FontWeight.w500),
          //                 //                                             ),
          //                 //                                           ),
          //                 //                                         ]),
          //                 //                                   ),
          //                 //                                   SizedBox(
          //                 //                                     width: double
          //                 //                                         .infinity,
          //                 //                                     child:
          //                 //                                         FlatButton(
          //                 //                                       shape: RoundedRectangleBorder(
          //                 //                                           borderRadius:
          //                 //                                               BorderRadius.circular(
          //                 //                                                   20.0)),
          //                 //                                       color: const Color(
          //                 //                                           0xFF11CBD7),
          //                 //                                       height: 50.0,
          //                 //                                       onPressed:
          //                 //                                           () {},
          //                 //                                       child: Row(
          //                 //                                         mainAxisSize:
          //                 //                                             MainAxisSize
          //                 //                                                 .max,
          //                 //                                         mainAxisAlignment:
          //                 //                                             MainAxisAlignment
          //                 //                                                 .center,
          //                 //                                         crossAxisAlignment:
          //                 //                                             CrossAxisAlignment
          //                 //                                                 .center,
          //                 //                                         children: <
          //                 //                                             Widget>[
          //                 //                                           Icon(Icons
          //                 //                                               .add_circle),
          //                 //                                           Padding(
          //                 //                                             padding:
          //                 //                                                 EdgeInsets.only(left: 5),
          //                 //                                             child: Text(
          //                 //                                                 "Add to Cart",
          //                 //                                                 textAlign:
          //                 //                                                     TextAlign.end,
          //                 //                                                 style: new TextStyle(color: Colors.white)),
          //                 //                                           ),
          //                 //                                         ],
          //                 //                                       ),
          //                 //                                     ),
          //                 //                                   ),
          //                 //                                 ],
          //                 //                               )),
          //                 //                 ).whenComplete(() {
          //                 //                   setState(() {
          //                 //                     showFab = true;
          //                 //                   });
          //                 //                 });
          //                 //                 // cart.addItemtoCart(
          //                 //                 //     productNotifier.currentProduct);
          //                 //                 // ScaffoldMessenger.of(context)
          //                 //                 //     .showSnackBar(new SnackBar(
          //                 //                 //         duration: Duration(
          //                 //                 //             milliseconds: 1500),
          //                 //                 //         content: new Text(
          //                 //                 //           "Added to Cart",
          //                 //                 //         )));
          //                 //               },
          //                 //               icon: Icon(
          //                 //                 Icons.add_circle,
          //                 //                 color: const Color(0xFF11CBD7),
          //                 //                 size: 28.0,
          //                 //               )),
          //                 //         ),
          //                 //       ),
          //                 //     ),
          //                 //   ),
          //                 // ),
          //                 ),
          //           ),
          //         ],
          //       ),
          //     ),
          //   ],
          // ),
        ),
      ),
    );
  }

  // void showCartAddedSnackbar(BuildContext context) {
  //   Scaffold.of(context).showSnackBar(new SnackBar(
  //     behavior: SnackBarBehavior.floating,
  //     padding: EdgeInsets.all(30.0),
  //     duration: Duration(milliseconds: 2000),
  //     content: new Text(
  //       "Added to Cart",
  //     ),
  //     elevation: 7.0,
  //   ));
  // }

  void showFlushbar(BuildContext context) {
    Flushbar(
      padding: EdgeInsets.all(10),
      message: 'Added to cart',
      duration: Duration(seconds: 2),
    ).show(context);
  }

  Future<Widget> modalBottomSheet(
      BuildContext context, ProductNotifier productNotifier) {
    CartNotifier cart = Provider.of<CartNotifier>(context, listen: false);
    int count = 1;
    return showModalBottomSheet(
      isDismissible: true,
      context: context,
      builder: (BuildContext context) => Container(
          height: MediaQuery.of(context).size.height * 0.4,
          color: Colors.white,
          padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(vertical: 20.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width / 1.5,
                        child: Text(
                          productNotifier.currentProduct.name,
                          style: TextStyle(
                              fontFamily: "Segoe_UI_Bold",
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ]),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 20.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Text(
                          "Price",
                          style: TextStyle(
                              fontFamily: "Segoe_UI_Bold",
                              fontSize: 17,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Container(
                        child: Text(
                          productNotifier.currentProduct.price.toString(),
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontFamily: "Segoe_UI_Bold",
                              fontSize: 17,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ]),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Text(
                        "Quantity",
                        style: TextStyle(
                            fontFamily: "Segoe_UI_Bold",
                            fontSize: 17,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Container(
                      child: NumericButton(
                        min: 1,
                        max: 20,
                        quantityValue: (value) => count = value,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  color: const Color(0xFF11CBD7),
                  height: 50.0,
                  onPressed: () {
                    if (count == 0) {}
                    cart.addItemtoCart(productNotifier.currentProduct, count);
                    Navigator.pop(context);
                    // return showCartAddedSnackbar(
                    //     builderContext);
                    return showFlushbar(context);
                    // Scaffold.of(
                    //         builderContext)
                    //     .showSnackBar(
                    //         new SnackBar(
                    //   behavior:
                    //       SnackBarBehavior.floating,
                    //   padding:
                    //       EdgeInsets.all(30.0),
                    //   duration:
                    //       Duration(milliseconds: 2000),
                    //   content:
                    //       new Text(
                    //     "Added to Cart",
                    //   ),
                    //   elevation:
                    //       7.0,
                    // )).;
                    // setState(
                    //     () {
                    //   showFab =
                    //       true;
                    // });
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.add_circle),
                      Padding(
                        padding: EdgeInsets.only(left: 5),
                        child: Text("Add to Cart",
                            textAlign: TextAlign.end,
                            style: new TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
    ).whenComplete(() {
      // Scaffold.of(context)
      //     .showSnackBar(
      //         new SnackBar(
      //   behavior: SnackBarBehavior
      //       .floating,
      //   padding:
      //       EdgeInsets.all(30.0),
      //   duration: Duration(
      //       milliseconds: 2000),
      //   content: new Text(
      //     "Added to Cart",
      //   ),
      //   elevation: 7.0,
      // ));
      setState(() {
        showFab = true;
      });
    });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
