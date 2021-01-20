import '../Screens/AddPlaceScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Provider/GreatPlaces.dart';

class PlaceListScreen extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("You Places"),actions: [
      IconButton(icon: Icon(Icons.add),onPressed: (){
        Navigator.of(context).pushNamed(AddPlaceScreen.route);
      },)
    ],),body:FutureBuilder(
      future: Provider.of<GreatPlaces>(context,listen: false).getAndSet(),
       builder: (context,snapshot,)=>snapshot.connectionState==ConnectionState.waiting?Center(child: CircularProgressIndicator(),):
       Consumer<GreatPlaces>(builder: (context,places,child)=>places.items.isEmpty?Center(child: Text("no places added"),)
          :ListView.builder(itemBuilder: (context,index)=>ListTile(leading: CircleAvatar(backgroundImage: FileImage(places.items[index].image),)
        ,title: Text(places.items[index].title),),itemCount: places.items.length,),),
    ));
  }
}
