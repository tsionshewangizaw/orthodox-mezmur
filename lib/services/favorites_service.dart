import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class FavoritesService {
  static const String _favoritesKey = 'favorite_songs';

  static Future<List<String>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final String? favoritesJson = prefs.getString(_favoritesKey);
    if (favoritesJson == null) return [];
    return List<String>.from(json.decode(favoritesJson));
  }

  static Future<void> addFavorite(String songId) async {
    final favorites = await getFavorites();
    if (!favorites.contains(songId)) {
      favorites.add(songId);
      await _saveFavorites(favorites);
    }
  }

  static Future<void> removeFavorite(String songId) async {
    final favorites = await getFavorites();
    favorites.remove(songId);
    await _saveFavorites(favorites);
  }

  static Future<bool> isFavorite(String songId) async {
    final favorites = await getFavorites();
    return favorites.contains(songId);
  }

  static Future<void> toggleFavorite(String songId) async {
    final isFav = await isFavorite(songId);
    if (isFav) {
      await removeFavorite(songId);
    } else {
      await addFavorite(songId);
    }
  }

  static Future<void> _saveFavorites(List<String> favorites) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_favoritesKey, json.encode(favorites));
  }
}
