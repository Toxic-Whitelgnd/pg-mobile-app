import 'FoodMenuModel.dart';

class Food{
  List<FoodMenu> foodmenus = [];

  Food();

  void addToMenu(FoodMenu f){
    foodmenus.add(f);
  }

  List<FoodMenu> getMenus(){
    return foodmenus;
  }

}