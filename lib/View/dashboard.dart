import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:super_store/Methods/getSample.dart';
import 'package:super_store/Methods/getUser.dart';
import 'package:super_store/Models/cart.dart';
import 'package:super_store/Models/sample.dart';
import 'package:super_store/Utils/appDrawer.dart';
import 'package:super_store/Utils/customAppBar.dart';
import 'package:super_store/Utils/customBottomNavigation.dart';
import 'package:super_store/Utils/gridView.dart';
import 'package:super_store/Utils/util.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Future<List<Sample>> data;
  Set<String> categories;
  String selectedCategories;
  List<Sample> productList;
  Future userDetail;
  @override
  void initState() {
    super.initState();
    categories = new Set();
    Network network = Network(sampleApi);
    GetUser getDetails = GetUser(userDetailsUrl);
    data = network.loadResults();
    userDetail = getDetails.fetchUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    var ccart = Provider.of<Cart>(context);
    return Scaffold(
      drawer: appDrawer(userDetail, context),
      appBar: customAppBar(),
      body: Stack(children: [
        Container(
          color: backgroundColor,
          child: FutureBuilder(
            future: data,
            builder: (context, AsyncSnapshot<List<Sample>> snapshot) {
              if (snapshot.hasData) {
                productList = snapshot.data;
                productList.forEach((element) {
                  categories.add(element.category);
                });
                if (selectedCategories != null) {
                  productList = productList
                      .where(
                          (element) => element.category == selectedCategories)
                      .toList();
                } else {
                  productList = snapshot.data;
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Our Product",
                            style: TextStyle(
                                color: textColor1,
                                fontSize: 22,
                                fontWeight: FontWeight.bold),
                          ),
                          FlatButton(
                            onPressed: () {
                              _openFilter(context, categories);
                            },
                            child: Row(
                              children: [
                                Text('Sort',
                                    style: TextStyle(color: textColor1)),
                                Icon(Icons.keyboard_arrow_up),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(child: gridViewHome(context, productList)),
                  ],
                );
              } else {
                return Center(
                    child: CircularProgressIndicator(
                        backgroundColor: primaryColor));
              }
            },
          ),
        ),
        customBottomNavigation(context, 1),
      ]),
    );
  }

  _openFilter(BuildContext context, Set categories) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: Center(
              child: Text(
                'Add Filter',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: textColor1,
                ),
              ),
            ),
            content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      height: 50,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: containerShadowColor,
                              blurRadius: 10,
                              offset: Offset(2, 7),
                            )
                          ],
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white),
                      child: Center(
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            isExpanded: true,
                            hint: Text("Choose Category"),
                            value: selectedCategories,
                            items: categories
                                .map<DropdownMenuItem<String>>((value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: TextStyle(color: textColor1),
                                ),
                              );
                            }).toList(),
                            onChanged: (String value) {
                              setState(() {
                                selectedCategories = value;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: new Text("Reset"),
                onPressed: () {
                  setState(() {
                    selectedCategories = null;
                  });
                  Navigator.of(context).pop();
                },
              ),
              // usually buttons at the bottom of the dialog
              FlatButton(
                child: new Text("Apply"),
                onPressed: () {
                  setState(() {
                    productList = productList
                        .where(
                            (element) => element.category == selectedCategories)
                        .toList();
                  });
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}
