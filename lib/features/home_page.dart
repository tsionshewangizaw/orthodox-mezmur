import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import '../mezmur_bloc.dart';
import '../mezmur_model.dart';
import '../features/theme_settings.dart';
import 'audio_player_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<MezmurBloc>().add(const LoadMezmurs());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showThemeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).cardColor,
          title: const Text('Choose Theme',
              style: TextStyle(fontWeight: FontWeight.bold)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _themeOption(context, 'Black', Colors.black, Icons.dark_mode),
              _themeOption(
                  context, 'Dark', const Color(0xFF1A1A1A), Icons.nights_stay),
              _themeOption(context, 'White', Colors.white, Icons.light_mode),
              _themeOption(context, 'Sepia', const Color(0xFFF4ECD8),
                  Icons.auto_stories),
              _themeOption(
                  context, 'Gold', Color(0xFF3E2723), Icons.auto_awesome),
              _themeOption(
                  context, 'Midnight', Color(0xFF0D1B2A), Icons.nights_stay),
              _themeOption(context, 'Forest', Color(0xFF1B2E1B), Icons.nature),
              _themeOption(context, 'Royal', Color(0xFF1A0A2E), Icons.diamond),
            ],
          ),
        );
      },
    );
  }

  Widget _themeOption(
      BuildContext context, String name, Color color, IconData icon) {
    final themeSettings = Provider.of<ThemeSettings>(context);
    final isSelected = themeSettings.selectedTheme == name;

    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey, width: 1),
        ),
        child: Icon(icon,
            size: 20,
            color: name == 'Black' || name == 'Dark'
                ? Colors.white
                : Colors.black87),
      ),
      title: Text(name, style: const TextStyle(fontWeight: FontWeight.w500)),
      trailing: isSelected
          ? const Icon(Icons.check_circle, color: Colors.green)
          : null,
      onTap: () {
        themeSettings.setTheme(name);
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildSearchBar(),
            _buildCategories(),
            Expanded(child: _buildMezmurList()),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ኦርቶዶክስ ተዋሕዶ',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Text(
                'መዝሙርና ግጥም',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white70
                          : Colors.black54,
                    ),
              ),
            ],
          ),
          IconButton(
            icon: Icon(Icons.palette_outlined,
                color: Theme.of(context).primaryColor, size: 28),
            onPressed: () => _showThemeDialog(context),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextField(
        controller: _searchController,
        onChanged: (query) {
          context.read<MezmurBloc>().add(SearchMezmurs(query));
        },
        style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color),
        decoration: InputDecoration(
          hintText: 'መዝሙር ወይም ዘማሪ ፈልግ...',
          hintStyle: TextStyle(color: Colors.grey[500]),
          prefixIcon: Icon(Icons.search, color: Theme.of(context).primaryColor),
          filled: true,
          fillColor: Theme.of(context).cardColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _buildCategories() {
    final categories = ['ሁሉም', 'በዓላት', 'ዘማሪዎች', 'ጾም', 'ማርያም', 'ቅዳሴ'];
    final icons = [
      Icons.music_note,
      Icons.celebration,
      Icons.person,
      Icons.self_improvement,
      Icons.star,
      Icons.church,
    ];

    return SizedBox(
      height: 90,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              if (index == 0) {
                context.read<MezmurBloc>().add(const LoadMezmurs());
              } else {
                context
                    .read<MezmurBloc>()
                    .add(FilterByCategory(categories[index]));
              }
            },
            child: Container(
              width: 80,
              margin: const EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).primaryColor.withOpacity(0.3),
                    Theme.of(context).primaryColor.withOpacity(0.1),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                    color: Theme.of(context).primaryColor.withOpacity(0.3)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icons[index],
                      color: Theme.of(context).primaryColor, size: 28),
                  const SizedBox(height: 8),
                  Text(
                    categories[index],
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMezmurList() {
    return BlocBuilder<MezmurBloc, MezmurState>(
      builder: (context, state) {
        if (state is MezmurLoading) {
          return Center(
            child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor),
          );
        }

        if (state is MezmurLoaded) {
          if (state.filteredMezmurs.isEmpty) {
            return Center(
              child: Text(
                'ምንም መዝሙር አልተገኘም',
                style: TextStyle(color: Colors.grey[500], fontSize: 18),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: state.filteredMezmurs.length,
            itemBuilder: (context, index) {
              final mezmur = state.filteredMezmurs[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                color: Theme.of(context).cardColor,
                child: ListTile(
                  leading: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Theme.of(context).primaryColor,
                          Theme.of(context).primaryColor.withOpacity(0.7),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.play_arrow, color: Colors.black),
                  ),
                  title: Text(
                    mezmur.title,
                    style: TextStyle(
                      color: Theme.of(context).textTheme.titleMedium?.color,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    mezmur.artist,
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyMedium?.color,
                    ),
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      mezmur.isFavorite
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: mezmur.isFavorite
                          ? Colors.red
                          : Theme.of(context).primaryColor,
                    ),
                    onPressed: () {
                      context.read<MezmurBloc>().add(ToggleFavorite(mezmur.id));
                    },
                  ),
                  onTap: () {
                    context.read<MezmurBloc>().add(SelectMezmur(mezmur));
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AudioPlayerPage(mezmur: mezmur),
                      ),
                    );
                  },
                ),
              );
            },
          );
        }

        return const SizedBox();
      },
    );
  }
}
