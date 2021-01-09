import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:super_store/Utils/util.dart';
import 'package:super_store/View/cartview.dart';
import 'package:super_store/View/dashboard.dart';


Widget customBottomNavigation(context, int index){
  final Size size = MediaQuery.of(context).size;
  return Positioned(
    bottom: 0,
    left: 0,
    child: Container(
      height: 80,
      width: size.width,
      child: Stack(
        children: [
          CustomPaint(
            size: Size(size.width, 80),
            painter: BNBCustomPainter(),
          ),

          Center(
            heightFactor: 0.6,
            child: FloatingActionButton(
              onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CartView()));
              },
              backgroundColor: primaryColor,
              child: Icon(Icons.shopping_basket,color: index==0?secondaryColor:Colors.white,),
              elevation: 0.1,
            ),
          ),
          Container(
            width: size.width,
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(icon: Icon(Icons.home, color: index==1?secondaryColor:textColor1,),
                    onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Dashboard()));
                    }),
                IconButton(icon: Icon(Icons.style, color: index==2?secondaryColor:textColor1), onPressed: (){}),
                Container(width: size.width*0.20,),
                IconButton(icon: Icon(Icons.bookmark, color: index==3?secondaryColor:textColor1), onPressed: (){}),
                IconButton(icon: Icon(Icons.settings, color: index==4?secondaryColor:textColor1,), onPressed: (){}),
              ],
            ),
          )
        ],
      ),
    ),
  );
}

class BNBCustomPainter extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Colors.white..style = PaintingStyle.fill;
    Path path = Path()..moveTo(0, 20);
    path.quadraticBezierTo(size.width*0.20, 0, size.width*0.35, 0);
    path.quadraticBezierTo(size.width*0.40, 0, size.width*0.40, 20);
    path.arcToPoint(
        Offset(size.width*0.60, 20),
        radius: Radius.circular(10.0),
        clockwise: false
    );
    path.quadraticBezierTo(size.width*0.60, 0, size.width*0.65, 0);
    path.quadraticBezierTo(size.width*0.80, 0, size.width, 20);
    path.lineTo(size.width, size.width);
    path.lineTo(0, size.height);
    path.close();
    canvas.drawShadow(path, Colors.black, 4, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

}