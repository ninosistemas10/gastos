import 'package:gastos/models/feature_model.dart';

class CategoryList {
  var catList = [
    FeatureModel(
        category: 'Gasolina',
        color: '#087802',
        icon: 'local_gas_station_outlined'),
    FeatureModel(
        category: 'Supermercado',
        color: '#b58412',
        icon: 'shopping_cart_outlined'),
    FeatureModel(
        category: 'Restaurante',
        color: '#ff8605',
        icon: 'local_dining_outlined'),
    FeatureModel(category: 'Hogar', color: '#853afc', icon: 'home'),
  ];
}
