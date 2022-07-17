import 'package:flutter/material.dart';
import 'package:pelisapp/screens/screens.dart';
import 'package:pelisapp/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Now Showing', style: TextStyle(color: Colors.black),),
        elevation: 0,
        actions: [IconButton(onPressed: () {}, 
        icon: Icon(Icons.search_outlined),
        color: Colors.black,)],
        
      ),
      body:  SingleChildScrollView(
        child: Column(
        children: [
          // CardSwiper
          CardSwiper(),

          //Lista Horizontal
          MovieSlider(),

        ],
      )
      )
    );
  }
}