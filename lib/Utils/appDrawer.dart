import 'package:flutter/material.dart';
import 'package:super_store/Methods/sharedPrefrences.dart';
import 'package:super_store/Utils/util.dart';
import 'package:super_store/View/splashscreen.dart';

Widget appDrawer(Future userDetail, BuildContext context) {
  return Drawer(
    child: ListView(
      children: [
        FutureBuilder(
          future: userDetail,
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return DrawerHeader(
                decoration: BoxDecoration(
                  color: backgroundColor,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 80.0,
                      height: 80.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(coverImage),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(50.0)),
                        border: Border.all(
                          color: primaryColor,
                          width: 4.0,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        "${snapshot.data['msg']}",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Center(
                  child:
                      CircularProgressIndicator(backgroundColor: primaryColor));
            }
          },
        ),
        ListTile(
          leading: Icon(Icons.edit),
          title: Text("Profile"),
          subtitle: Text("More Details"),
          trailing: Icon(Icons.keyboard_arrow_right),
          isThreeLine: false,
        ),
        ListTile(
          leading: Icon(Icons.settings),
          title: Text("Settings"),
          subtitle: Text("More Details"),
          trailing: Icon(Icons.keyboard_arrow_right),
        ),
        ListTile(
          leading: Icon(Icons.people),
          title: Text("Manage"),
          subtitle: Text("More Details"),
          trailing: Icon(Icons.keyboard_arrow_right),
        ),
        ListTile(
          leading: Icon(Icons.info_outline_rounded),
          title: Text("Help & Support"),
          subtitle: Text("More Details"),
          trailing: Icon(Icons.keyboard_arrow_right),
        ),
        ListTile(
          onTap: () async {
            await logOut();
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => Splashscreen()),
                (route) => false);
          },
          leading: Icon(Icons.logout),
          title: Text("Logout"),
          subtitle: Text("More Details"),
          trailing: Icon(Icons.keyboard_arrow_right),
        ),
      ],
    ),
  );
}
