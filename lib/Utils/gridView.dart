import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:super_store/Models/cart.dart';
import 'package:super_store/Models/sample.dart';
import 'package:super_store/Utils/util.dart';

Widget gridViewHome(context, List<Sample> data){
  var ccart = Provider.of<Cart>(context);
  return GridView.builder(
    padding: EdgeInsets.only(bottom: 100),
      itemCount: data.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: (MediaQuery.of(context).size.height*4/10)/ (MediaQuery.of(context).size.width)
      ),
      itemBuilder: (BuildContext context, int i){
        return GridTile(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: containerShadowColor,
                    blurRadius: 10,
                    offset: Offset(2, 7),
                  )
                ],
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(data[i].image),
                        )
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [
                          Center(
                              child: Text(
                                data[i].title.length<20
                                    ?data[i].title.trim()
                                    :data[i].title.substring(0,20).trim(),
                                style: TextStyle(color: textColor2, fontSize: 14.5, fontWeight: FontWeight.bold,),
                                softWrap: true,
                                maxLines: 1,
                              )),
                          SizedBox(height: 10,),
                          Center(
                              child: Text(
                                '\$ ${data[i].price.toString()}',
                                style: TextStyle(color: textColor1, fontSize: 18, fontWeight: FontWeight.bold,),
                                softWrap: true,
                                maxLines: 1,
                              )),
                          RaisedButton(onPressed: (){
                            ccart.add(data[i]);
                            Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text("Added to the cart"),
                              action: SnackBarAction(
                                label: 'Undo',
                                onPressed: () {
                                  ccart.remove(data[i]);
                                },
                              ),
                            ));
                          },
                          child:Text("Add", style: TextStyle(color: secondaryColor),),
                            color: primaryColor,
                          )
                        ],
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ),
        );
      }
  );
}