import 'package:flutter/material.dart';



class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(

      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('Hello Meme Lovers!'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.home ,color: Colors.black, size: 30,),
            title: Text('Home' , style: Theme.of(context).textTheme.title,),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.image , color: Colors.black,size:30),
            title: Text('My Memes' , style: Theme.of(context).textTheme.title,),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed('/my-meme');
            },
          ),
        ],
      ),
    );
  }
}