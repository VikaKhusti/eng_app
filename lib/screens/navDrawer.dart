import 'package:engapp/screens/dictionary/myDictionary.dart';
import 'package:flutter/material.dart';

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'Side menu',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            decoration: BoxDecoration(
                color: Colors.deepOrange[800],
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/images/avatar.jpg'))),
          ),
          ListTile(
            leading: Icon(Icons.bookmark),
            title: Text('My Dictionary'),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyDictionary()),
              )
            },
          ),
          ListTile(
            leading: Icon(Icons.verified_user),
            title: Text('Profile'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () => {Navigator.of(context).pop()},
          ),

        ],
      ),
    );
  }
}