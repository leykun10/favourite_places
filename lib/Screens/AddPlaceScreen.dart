import 'package:provider/provider.dart';
import '../Provider/GreatPlaces.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart' as syspath;
import 'package:path/path.dart' as path;
import 'package:image_picker/image_picker.dart';
class AddPlaceScreen extends StatefulWidget {
  static const route= "/addPlaceScreen";

  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  var  titleController = TextEditingController();
 File _storedImage;

  Future<void> _imagePick()  async {
    final image =await ImagePicker().getImage(source: ImageSource.camera);
    if (image==null){
      return;
    }
    setState(() {
      _storedImage=File(image.path);

    });
    var endpoint = path.basename(image.path);
    var appDir = await syspath.getApplicationDocumentsDirectory();

    _storedImage =await _storedImage.copy( path.join(appDir.path,endpoint));
  }
  void savePlace(){
    if(titleController.value==null || _storedImage==null){
      return;
    }
    Provider.of<GreatPlaces>(context,listen: false).addPlaces(titleController.text,_storedImage);
    Navigator.of(context).pop();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('Add a new place'),)
      ,body:
      Column(crossAxisAlignment: CrossAxisAlignment.stretch,children: [Expanded(child: SingleChildScrollView(child: Column(children: [
        Padding(padding: EdgeInsets.symmetric(horizontal: 15,vertical: 30),child: TextField(controller: titleController,decoration:
        InputDecoration(labelText: "title",labelStyle: TextStyle(fontSize: 24,color: Colors.black),fillColor:
        Colors.black45,focusColor: Colors.black45)))
      ,Row(mainAxisAlignment: MainAxisAlignment.start,children: [SizedBox(width: 20,),Container( decoration: BoxDecoration(
            border: Border.all(color: Colors.black54,)),height:200,width:200,
          child:Center(child:_storedImage!=null?Image.file(_storedImage,fit: BoxFit.cover,width: double.infinity,):Text("no images taken")),),
          FlatButton.icon(onPressed: _imagePick, icon: Icon(Icons.camera), label: Text("take a picture"))],)],),),),
      RaisedButton.icon(color: Theme.of(context).accentColor,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          onPressed: (){savePlace();}, icon: Icon(Icons.add), label: Text(" Add Place")
      )],),);
  }
}
