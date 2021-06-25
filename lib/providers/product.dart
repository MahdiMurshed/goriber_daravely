import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;
  Product(
      {@required this.id,
      @required this.title,
      @required this.description,
      @required this.price,
      @required this.imageUrl,
      this.isFavorite = false});

  Future<void> toggleFav() async {
    final old = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();
    final url =
        'https://shop-app-914b6-default-rtdb.firebaseio.com/products/$id.json';
    try {
      final response= await http.patch(Uri.parse(url),
          body: json.encode({
            'isFavorite': isFavorite,
          }));
          if(response.statusCode>=400){
            isFavorite = old;
            notifyListeners();
          }
    } catch (e) {
      isFavorite = old;
      notifyListeners();
    }
  }
}
