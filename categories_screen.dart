
import 'package:eltodo/screens/home_screen.dart';
import 'package:eltodo/services/category_service.dart';
import 'package:flutter/material.dart';

import 'models/categlry.dart';

class CategoriesScreen extends StatefulWidget{
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>{
 var _CategoryName = TextEditingController();
 var _CategoryDesciption = TextEditingController();

 var _category = Category();
 var _categoryService = CategoryService();
 List<Category> _categoryList = List<Category>();

  var _editCategoryName = TextEditingController();

  var _editCategoryDesciption = TextEditingController();

 
 void initState(){
   super.initState();
   getAllCategories();
 }

 getAllCategories() async{
  var categories = await _categoryService.getCategories();
  categories.forEach((category){
  setState(() {
    var model =  Category();
    model.name = category['name'];
    model.id = category['id'];
    model.description = category['description'];

    _categoryList.add(model);

  });
  });

 }

 _showFromInDialog(BuildContext context){
    return showDialog(context: context, barrierDismissible: true, builder: (param){
      return AlertDialog(
        actions: <Widget> [
          FlatButton(
              onPressed: (){
                Navigator.pop(context);
              },
              child: Text("Cancel"),
          ),
          FlatButton(
            onPressed: () async{
              _category.name = _CategoryName.text;
              _category.description = _CategoryDesciption.text;
           var result =  await _categoryService.saveCategory(_category);
              if (result > 0){
                Navigator.pop(context);
              }
           print(result);
            },
            child: Text("save"),
          ),
        ],
        title: Text("Category from"), content: SingleChildScrollView(
       child: Column(
         children: <Widget>[
           TextField(
             controller: _CategoryName,
             decoration:  InputDecoration(
               labelText: "Category name",
               hintText: "Write Category name",
             ),
           ),
           TextField(
             controller: _CategoryDesciption,
             decoration:  InputDecoration(
               labelText: "Category description",
               hintText: "Write Category description",
             ),
           )
         ],
       ),
      ),);
    });
  }
 _editCategoryDialog(BuildContext context){
   return showDialog(context: context, barrierDismissible: true, builder: (param){
     return AlertDialog(
       actions: <Widget> [
         FlatButton(
           onPressed: (){
             Navigator.pop(context);
           },
           child: Text("Cancel"),
         ),
         FlatButton(
           onPressed: () async{
             _category.name = _CategoryName.text;
             _category.description = _CategoryDesciption.text;
             var result =  await _categoryService.saveCategory(_category);
             if (result > 0){
               Navigator.pop(context);
             }
             print(result);
           },
           child: Text("save"),
         ),
       ],
       title: Text("Categort from"), content: SingleChildScrollView(
       child: Column(
         children: <Widget>[
           TextField(
             controller: _editCategoryName,
             decoration:  InputDecoration(
               labelText: "Category name",
               hintText: "Write Category name",
             ),
           ),
           TextField(
             controller: _editCategoryDesciption,
             decoration:  InputDecoration(
               labelText: "Category description",
               hintText: "Write Category description",
             ),
           )
         ],
       ),
     ),);
   });
 }

 _editCategory(BuildContext context, categoryId) async {
 var category =  await  _categoryService.getCategoryById(categoryId);
 setState(() {
   _editCategoryName.text = category[0]['name']?? 'no name';
   _editCategoryDesciption.text = category[0]['dexciption']?? 'no dexciption';
 });
 _editCategoryDialog(context);
 }


  @override
  Widget build(BuildContext context) {
 return Scaffold (
   appBar:AppBar(
   leading: RaisedButton(
     elevation: 0.0,
    color: Colors.purple,
     child: Icon(Icons. arrow_back, color: Colors.white,),
     onPressed: (){
       Navigator.of(context).push(new MaterialPageRoute(builder: (context) => new HomeScreen()));
     },
   ) ,
   title: Text("Softwaer Engineering"),
   ),
   body: ListView.builder(itemCount: _categoryList.length,  itemBuilder: (context, index) {
    return Card(child: ListTile(
      leading: IconButton(icon: Icon(Icons.edit),onPressed: (){
        _editCategory(context, _categoryList[index].id);
      } ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween ,
        children: [
          Text(_categoryList[index].name),
          IconButton(icon: Icon(Icons.delete), onPressed: (){},)
        ],
      ),
    )
    );
   }),
   floatingActionButton: FloatingActionButton(onPressed: (){
     _showFromInDialog(context);
   }, child: Icon (Icons.add),),
 );
  }

}