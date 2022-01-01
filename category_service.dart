import 'package:eltodo/models/categlry.dart';
import 'package:eltodo/repositories/repositories.dart';

class CategoryService {

  Repository _repository;
  
    CategoryService(){
      _repository = Repository();
    }
    

  saveCategory(Category category)async{
 return await _repository.save('categories', category.categoryMap());
  }

  getCategories()async{
   return await _repository.getAll('categories');
  }

   getCategoryById(categoryId) async{
    return await  _repository.getById('categories', categoryId);
   }
}