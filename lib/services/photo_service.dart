import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/photo_model.dart';

class PhotoService {
  static Future<List<PhotoModel>> getPhotos() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.take(50).map((json) => PhotoModel(
        id: json['id'],
        title: json['title'],
        thumbnailUrl: 'https://picsum.photos/id/${json['id']}/50/50', // Menggunakan Picsum agar gambar pasti muncul
      )).toList();
    } else {
      throw Exception('Gagal load API');
    }
  }
}
