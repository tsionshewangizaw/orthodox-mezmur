import 'package:flutter/material.dart';
import '../mezmur_model.dart';
import '../services/favorites_service.dart';
import 'audio_player_page.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  List<MezmurModel> _favorites = [];

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final favIds = await FavoritesService.getFavorites();
    final allSongs = MezmurModel.mockMezmurList;
    setState(() {
      _favorites = allSongs.where((song) => favIds.contains(song.id)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text('የምወዳቸው መዝሙሮች',
            style: TextStyle(color: Theme.of(context).primaryColor)),
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
      ),
      body: _favorites.isEmpty
          ? Center(
              child: Text('ምንም ተወዳጅ መዝሙር የለም',
                  style: TextStyle(color: Colors.grey[500], fontSize: 16)),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _favorites.length,
              itemBuilder: (context, index) {
                final mezmur = _favorites[index];
                return Card(
                  color: Theme.of(context).cardColor,
                  margin: const EdgeInsets.only(bottom: 8),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    leading: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Theme.of(context).primaryColor,
                            Theme.of(context).primaryColor.withOpacity(0.7)
                          ],
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.play_arrow, color: Colors.black),
                    ),
                    title: Text(mezmur.title,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.color)),
                    subtitle: Text(mezmur.artist,
                        style: TextStyle(
                            color:
                                Theme.of(context).textTheme.bodyMedium?.color)),
                    trailing: IconButton(
                      icon: const Icon(Icons.favorite, color: Colors.red),
                      onPressed: () async {
                        await FavoritesService.removeFavorite(mezmur.id);
                        _loadFavorites();
                      },
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                AudioPlayerPage(mezmur: mezmur)),
                      ).then((_) => _loadFavorites());
                    },
                  ),
                );
              },
            ),
    );
  }
}
