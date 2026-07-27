import 'package:flutter/material.dart';
import '../models/sub_category_model.dart';

class SubCategoryPage extends StatelessWidget {
  final String categoryName;
  final List<SubCategoryModel> subCategories;

  const SubCategoryPage({
    super.key,
    required this.categoryName,
    required this.subCategories,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(categoryName,
            style: TextStyle(color: Theme.of(context).primaryColor)),
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: subCategories.length,
        itemBuilder: (context, index) {
          final sub = subCategories[index];
          return Card(
            color: Theme.of(context).cardColor,
            margin: const EdgeInsets.only(bottom: 8),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              title: Text(sub.name,
                  style: TextStyle(
                      color: Theme.of(context).textTheme.titleMedium?.color)),
              subtitle: sub.date != null
                  ? Text(sub.date!,
                      style: TextStyle(
                          color: Theme.of(context).primaryColor, fontSize: 13))
                  : null,
              trailing: Icon(Icons.arrow_forward_ios,
                  size: 16, color: Theme.of(context).primaryColor),
              onTap: () {
                // Future: Navigate to songs filtered by this sub-category
              },
            ),
          );
        },
      ),
    );
  }
}
