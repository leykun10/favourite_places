import 'package:flutter/foundation.dart';
import '../models/Place.dart';
import 'dart:io';
import '../sqlhelper/SqlHelper.dart';

class GreatPlaces with ChangeNotifier{
 List<Place> _items = [];

 List get items{
   return [..._items];

 }
 Future<void> addPlaces(String title,File pickedImage) async{
    Place newPlace =Place(id: DateTime.now().toIso8601String(),title: title,location: null,image: pickedImage);
      _items.add(newPlace);
      notifyListeners();
      SqlHelper.insert('places' ,{'id':newPlace.id,'title':newPlace.title,'image':newPlace.image.path});
 }
 Future<void> getAndSet() async{
   List items = await SqlHelper.placeList('places');
   _items =items.map((e) => Place(id: e['id'],title: e['title'],image: File(e['image']),location: null)).toList();
   notifyListeners();
 }
}