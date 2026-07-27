class SubCategoryModel {
  final String name;
  final String? date;

  const SubCategoryModel({
    required this.name,
    this.date,
  });
}

class SubCategoryData {
  static Map<String, List<SubCategoryModel>> getSubCategories() {
    return {
      'ዓመታዊ በዓላት': [
        SubCategoryModel(name: 'መስቀል', date: 'መስከረም 17'),
        SubCategoryModel(name: 'ልደት', date: 'ታህሳስ 29'),
        SubCategoryModel(name: 'ጥምቀት', date: 'ጥር 11'),
        SubCategoryModel(name: 'ሆሣዕና'),
        SubCategoryModel(name: 'ስቅለት'),
        SubCategoryModel(name: 'ትንሣኤ'),
        SubCategoryModel(name: 'ደብረ ዘይት'),
        SubCategoryModel(name: 'ጰራቅሊጦስ'),
      ],
      'በገና': [
        SubCategoryModel(name: 'ትዝታ / ዋኔን'),
        SubCategoryModel(name: 'ሰላምታ'),
        SubCategoryModel(name: 'ስለ ቸርነትህ / አንቺ ሆዬ'),
      ],
      'ወረብ': [
        SubCategoryModel(name: 'መስከረም'),
        SubCategoryModel(name: 'ጥቅምት'),
        SubCategoryModel(name: 'ኅዳር'),
        SubCategoryModel(name: 'ታህሳስ'),
        SubCategoryModel(name: 'ጥር'),
        SubCategoryModel(name: 'የካቲት'),
        SubCategoryModel(name: 'መጋቢት'),
        SubCategoryModel(name: 'ሚያዝያ'),
        SubCategoryModel(name: 'ግንቦት'),
        SubCategoryModel(name: 'ሰኔ'),
        SubCategoryModel(name: 'ሐምሌ'),
        SubCategoryModel(name: 'ነሐሴ'),
        SubCategoryModel(name: 'ጳጉሜ'),
      ],
      'ወርሀዊ በዓላት': [
        SubCategoryModel(name: '1 | ልደታ፣ ራጉኤል፣ ኤልያስ'),
        SubCategoryModel(name: '2 | ታዴዎስ ሐዋርያ፣ ኢዮብ ጻድቅ'),
        SubCategoryModel(name: '3 | በዓታ ማርያም፣ ዜና ማርቆስ'),
        SubCategoryModel(name: '4 | ዮሐንስ ወልደ ነጎድጓድ'),
        SubCategoryModel(name: '5 | ጴጥሮስ ወጳውሎስ'),
        SubCategoryModel(name: '6 | ኢየሱስ፣ ቁስቋም'),
        SubCategoryModel(name: '7 | ሥላሴ፣ ፊሊሞን'),
        SubCategoryModel(name: '8 | ማቴዎስ፣ ዮልያኖስ'),
        SubCategoryModel(name: '9 | ቶማስ ሐዋርያ፣ አርባ ሰማዕታት'),
        SubCategoryModel(name: '10 | በዓለ መስቀሉ'),
        SubCategoryModel(name: '11 | ሃና ወኢያቄም'),
        SubCategoryModel(name: '12 | ቅዱስ ሚካኤል'),
        SubCategoryModel(name: '13 | እግዚአብሔር አብ፣ ሩፋኤል'),
        SubCategoryModel(name: '14 | አባ አረጋዊ'),
        SubCategoryModel(name: '15 | ቂርቆስና ኢየሉጣ'),
        SubCategoryModel(name: '16 | ኪዳነ ምሕረት'),
        SubCategoryModel(name: '17 | ቅዱስ እስጢፋኖስ'),
        SubCategoryModel(name: '18 | ፊልጶስ ሐዋርያ'),
        SubCategoryModel(name: '19 | ቅዱስ ገብርኤል'),
        SubCategoryModel(name: '20 | ጽንሰታ ለማርያም'),
        SubCategoryModel(name: '21 | በዓለ እግዝእትነ ማርያም'),
        SubCategoryModel(name: '22 | ቅዱስ ዑራኤል'),
        SubCategoryModel(name: '23 | ቅዱስ ጊዮርጊስ'),
        SubCategoryModel(name: '24 | አቡነ ተክለ ሃይማኖት'),
        SubCategoryModel(name: '25 | መርቆሬዎስ'),
        SubCategoryModel(name: '26 | ሆሴዕ ነቢይ'),
        SubCategoryModel(name: '27 | መድኃኔዓለም'),
        SubCategoryModel(name: '28 | አማኑኤል፣ ቆስጠንጢኖስ'),
        SubCategoryModel(name: '29 | በዓለ ወልድ'),
        SubCategoryModel(name: '30 | ማርቆስ ወንጌላዊ'),
      ],
    };
  }
}
