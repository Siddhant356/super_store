import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:super_store/Methods/getUser.dart';
import 'package:super_store/Models/cart.dart';
import 'package:super_store/Utils/appDrawer.dart';
import 'package:super_store/Utils/customAppBar.dart';
import 'package:super_store/Utils/util.dart';

class CartView extends StatefulWidget {
  @override
  _CartViewState createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  Future userDetail;

  @override
  void initState() {
    super.initState();
    GetUser getDetails = GetUser(userDetailsUrl);
    userDetail = getDetails.fetchUserDetails();
  }
  @override
  Widget build(BuildContext context) {
    var ccart = Provider.of<Cart>(context);
    var itemList = ccart.cartItems;

    return Scaffold(
      appBar: customAppBar(),
      drawer: appDrawer(userDetail, context),
      body: Stack(
        children: [
          Container(
          color: backgroundColor,
          child: ListView.builder(
              padding: EdgeInsets.only(bottom: 100),
            itemCount: itemList.length,
              itemBuilder: (BuildContext context, int i){
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              child: Container(
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                        color: containerShadowColor,
                        blurRadius: 15.0
                    )
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image(image: NetworkImage(itemList[i].image), width: 85, height: 85,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          itemList[i].title.length<20
                              ?itemList[i].title.trim()
                              :itemList[i].title.substring(0,20).trim(),
                          style: TextStyle(color: textColor2, fontSize: 16, fontWeight: FontWeight.bold,),
                          softWrap: true,
                          maxLines: 1,
                        ),
                        SizedBox(height: 10,),
                        Text(
                          '\$ ${itemList[i].price.toString()}',
                          style: TextStyle(color: textColor1, fontSize: 18, fontWeight: FontWeight.bold,),
                          softWrap: true,
                          maxLines: 1,
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(icon: Icon(Icons.delete, color: textColor1,), onPressed: (){
                          ccart.remove(itemList[i]);
                        })
                        // RawMaterialButton(
                        //   onPressed: () {},
                        //   elevation: 2.0,
                        //   fillColor: Colors.white,
                        //   child: Icon(
                        //     Icons.remove,
                        //     size: 20.0,
                        //   ),
                        //   padding: EdgeInsets.all(5.0),
                        //   shape: CircleBorder(),
                        // ),
                        // Text("1", style: TextStyle(color: textColor1, fontSize: 16, fontWeight: FontWeight.bold),),
                        // RawMaterialButton(
                        //   onPressed: () {},
                        //   elevation: 2.0,
                        //   fillColor: secondaryColor,
                        //   child: Icon(
                        //     Icons.add,
                        //     size: 20.0,
                        //   ),
                        //   padding: EdgeInsets.all(5.0),
                        //   shape: CircleBorder(),
                        // )
                      ],
                    )
                  ],
                ),
              ),
            );
          }),
        ),
          Positioned(
              bottom: 0,
              left: 0,
              child: Container(
                height: 100,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: containerShadowColor,
                        blurRadius: 15.0
                    )
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('\$${ccart.totalPrice}', style: TextStyle(color: textColor1, fontSize: 25, fontWeight: FontWeight.w700),),
                   Container(
                     height: 50,
                     child: RaisedButton.icon(
                       shape: RoundedRectangleBorder(
                           borderRadius: BorderRadius.circular(30.0),
                       ),
                       onPressed: (){},
                       icon: Icon(Icons.exit_to_app, color: secondaryColor,),
                       label: Text("Check Out", style: TextStyle(color: secondaryColor, fontSize: 16, fontWeight: FontWeight.bold),), color: primaryColor,),
                   )
                  ],
                ),
              ),
          ),
        ]
      ),
    );
  }
}
