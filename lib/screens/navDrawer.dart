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
            decoration: BoxDecoration(
                color: Colors.lightBlue[50],
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/images/avatar.jpg'))),
          ),
          ListTile(
            leading: Icon(Icons.bookmark),
            title: Text(
                'My Dictionary',
              style: TextStyle(fontSize: 15.0),
            ),
            onTap: () => {
              Navigator.push(context,
                MaterialPageRoute(builder: (context) => MyDictionary()),
              )
            },
          ),
          ListTile(
            leading: Icon(Icons.verified_user),
            title: Text('Profile',
              style: TextStyle(fontSize: 15.0),),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings',
              style: TextStyle(fontSize: 15.0),),
            onTap: () => {Navigator.of(context).pop()},
          ),
        ],
      ),
    );
  }
}
