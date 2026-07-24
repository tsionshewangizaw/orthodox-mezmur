import 'package:equatable/equatable.dart';

enum MezmurCategory {
  bealat('በዓላት', 'መስቀል'),
  zemariwoch('ዘማሪዎች', 'ዲያቆን'),
  tsom('ጾም', 'ሆሣዕና'),
  kidase('ቅዳሴ', 'ቅዳሴ'),
  maryam('ማርያም', 'ድንግል');

  final String nameAmharic;
  final String iconEmoji;
  const MezmurCategory(this.nameAmharic, this.iconEmoji);
}

class MezmurModel extends Equatable {
  final String id;
  final String title;
  final String artist;
  final String category;
  final String duration;
  final String audioUrl;
  final String lyrics;
  final String? description;
  final String? coverImageUrl;
  final bool isFavorite;

  const MezmurModel({
    required this.id,
    required this.title,
    required this.artist,
    required this.category,
    required this.duration,
    required this.audioUrl,
    required this.lyrics,
    this.description,
    this.coverImageUrl,
    this.isFavorite = false,
  });

  MezmurModel copyWith({
    String? id,
    String? title,
    String? artist,
    String? category,
    String? duration,
    String? audioUrl,
    String? lyrics,
    String? description,
    String? coverImageUrl,
    bool? isFavorite,
  }) {
    return MezmurModel(
      id: id ?? this.id,
      title: title ?? this.title,
      artist: artist ?? this.artist,
      category: category ?? this.category,
      duration: duration ?? this.duration,
      audioUrl: audioUrl ?? this.audioUrl,
      lyrics: lyrics ?? this.lyrics,
      description: description ?? this.description,
      coverImageUrl: coverImageUrl ?? this.coverImageUrl,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  factory MezmurModel.fromJson(Map<String, dynamic> json) {
    return MezmurModel(
      id: json['id'] as String,
      title: json['title'] as String,
      artist: json['artist'] as String,
      category: json['category'] as String,
      duration: json['duration'] as String,
      audioUrl: json['audioUrl'] as String,
      lyrics: json['lyrics'] as String,
      description: json['description'] as String?,
      coverImageUrl: json['coverImageUrl'] as String?,
      isFavorite: json['isFavorite'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'artist': artist,
      'category': category,
      'duration': duration,
      'audioUrl': audioUrl,
      'lyrics': lyrics,
      'description': description,
      'coverImageUrl': coverImageUrl,
      'isFavorite': isFavorite,
    };
  }

  static List<MezmurModel> mockMezmurList = [
    MezmurModel(
      id: '1',
      title: 'እግዚአብሔርን አመስግኑ',
      artist: 'ዲያቆን አቤል መክብብ',
      category: 'በዓላት',
      duration: '5:39',
      audioUrl: 'assets/audio/4_5848350211256092996.m4a',
      lyrics: '''እግዚአብሔርን አመስግኑ
ስራው ግሩም ድንቅ ነው በሉ

እግዚአብሔርን አመስግኑት

እግዚአብሔርን አመስግኑት
ሥራ ግሩም ድንቅ ነው በሉት
እግዚአብሔርን እመስግኑት
ስራህ ግሩም ድንቅ ነው በሉት

❴አዝ❵

ሠማይን ያለ ምሰሶ
ምድርንም ያለ መሰረት
ያጸናው እርሱ ነው
ሥራህ ድንቅ ነው በሉት

❴አዝ❵

የባህርንም ጥልቀት የመጠነ
ዳርቻዋን የወሰነ
እግዚአብሔርን አመስግኑ
ሥራ ግሩም ድንቅ ነው በሉት

❴አዝ❵

ማእበል ንፋሱን የሚገስጽ
ፍጥረቱ ለስሙ የሚታዘዝ
ትጉህ እረኛ ድካም የሌለበት
እግዚአብሔርን ሥራህ ድንቅ ነው በሉት

❴አዝ❵

ንጹሐ ባህርይ ነው ሁሉን የሚገዛ
የነገስታት ንጉስ አልፋና ኦሜጋ
ዘለዓለም እርሱ ነው የማይለወጥ
እግዚአብሔር ስራህ ድንቅ ነው በሉት

❴አዝ❵

ጥበብን የሚሰጥ ጥበበኛ
ፍርድ የማያጎድል እውነተኛ ዳኛ
እንደ እርሱ ያለ ከቶ አይገኝም
እግዚአብሔር ግሩም ነው ለዘልዓለም''',
      description: 'የምስጋና መዝሙር',
      isFavorite: true,
    ),
    MezmurModel(
      id: '2',
      title: 'ኪዳነምህረት እናቴ',
      artist: 'ሊቀ መዘምራን ቴዎድሮስ',
      category: 'ማርያም',
      duration: '5:34',
      audioUrl: 'assets/audio/kidane_mihret.mp3',
      lyrics: '''ኪዳነምህረት እናቴ
ሚስጥረኛየ ጓዳዬ
የጎደለኝን ታውቂያለሽ
ሳይወጣ ሳልነግርሽ

አዝ፦
አልፏል መናኛው ኑሮ
ምልጃሽ ውሀውን ቀይሮ
መልካሙ ወይን ደረሰ
እንባዬ ባንቺ ታበሰ

ልዘምር ልቁም ከፊትሽ
ልምጣ ልንበርከክ ለክብርሽ
ብርቅ ከሀገር ከቤቴ
ከቶ አረሳሽም እናቴ

አልልም መቼ ነው ቀኑ
የኔ መጎብኛ ዘመኑ
እንደሚፈፀም አምናለሁ
ሁሉን በጊዜው አያለሁ

የልቤን ችግር ላዋይሽ
ከስእልሽ ፊት ቆሜ
እንባዬ ቀድሞኝ ዝም አልኩኝ
ሳልነግርሽ ስለምታውቂ''',
      description: 'የእመቤታችን ቅድስት ድንግል ማርያም መዝሙር',
      isFavorite: true,
    ),
    MezmurModel(
      id: '3',
      title: 'አበረታኝ ፍቅርህ ጌታዬ',
      artist: 'ዲያቆን ቴዎድሮስ ዮሴፍ',
      category: 'ጾም',
      duration: '8:02',
      audioUrl: 'assets/audio/abretagn_fikreh.mp3',
      lyrics: '''አበረታኝ ፍቅርህ ጌታዬ
አበረታኝ ክንድህ አምላኬ
በስምህ ድኛለሁ በፀጋህ
በማደሪያህ ሆኜ ስጠራህ

አዝ፦
ሰዶም ስትቃጠል መርገሟ ሲበዛ
ሊተወኝ አይሻም ልጁን እንደዋዛ
ህጉን በማሰቤ አምላክ ፈረደልኝ
ጎትቶ የሚያወጣ መልአክ ሰደደልኝ

በገናን መደርደር አያቆምም ጣቴ
የወንጭፌ ድንጋይ አንተነህ ጉልበቴ
የሳኦልን ካባ አውልቀህ ጣልክልኝ
የፍልስጤሙን ሰው ክንድህ ሰበረልኝ

ሶስት ጊዜ ስክድህ አላውቅህም ብዬ
ዶሮ ስለጮኸ ትዝ አልከኝ ጌታዬ
ወጣሁኝ በዕንባ ከአይሁድ እሳት ሥር
ከሐዲ ሳትለኝ አኖርኝ በፍቅር

ሳምራዊ ናት ሳትል ክብርን የጠማኝ
እንደ አንተ ከአይሁድ ፍቅርን ማን አሳየኝ
ምስጢሬን በሙሉ ነገርከኝ ጌታዬ
የፍቅር ውሃ ቀዳሁ እንሥራዬን ጥዬ''',
      description: 'የፍቅር እና የጸጋ መዝሙር',
      isFavorite: true,
    ),
    MezmurModel(
      id: '4',
      title: 'ኢየሱስ ልበል ኢየሱስ',
      artist: 'ዘማሪ ገብረዮሐንስ ገብረፃዲቅ',
      category: 'ቅዳሴ',
      duration: '5:43',
      audioUrl: 'assets/audio/iyesus_libel.mp3',
      lyrics: '''ኢየሱስ ልበል ኢየሱስ እርሱ ነው ህይወቴ
የምኖርበት ተስፋ እርሱ ነው እረፍቴ
ያለ ጌታ ብኖርማ እንዴት እሆናለሁ
ስለ ስሙ ብነቀፍም ነብሴን እሰጣለሁ

አዝ፦
በአይሁድ መንደር ስሄድ የቤቱ ቅናት በላኝ
ኢየሱስ የሚሉትን ስሙን አትጥራ ቢሉኝ
እምቢ ብያለሁ ያለፍቅሩ አልመላለስም
ያበራልኝ ይታየኛል እኔ አላፍርበትም

በሙሴ ወንበር ሳሉ ጸሀፍቱን ሳነጋግር
በህጋቸው ኮነኑኝ ለጌታዬ ስዘምር
በሰዎች ይልቅ ክርስቶስን መስማት ስላለብኝ
በመከራ ተከብቤ አዳኜን ገለጥኩኝ

አላስደነገጠኝም የቄሳር ቀጭን ትዕዛዝ
በምኩራብ ተፈልጌ በመሰዊያው ፊት ብያዝ
ልቤ አይክድም የተገዛው ለእውነት ነውና
ምንም አይኖር የሚያቆመኝ ከአምላኬ ምስጋና

ኢየሱስ በተአምር ሁሉን እየከወነ
በግንበኞች ከተማ ታላቅ ፍርሀት ሆነ
በየጥቂቱ እየበዛ ቃሉ እያደገ
በተፈታ አንደበቴ ምርኮውን ፈለገ''',
      description: 'የኢየሱስ ስም ክብር መዝሙር',
    ),
    MezmurModel(
      id: '5',
      title: 'አረሳት ኢትዮጵያን',
      artist: 'ዲያቆን ቴዎድሮስ ዮሴፍ',
      category: 'ዘማሪዎች',
      duration: '5:55',
      audioUrl: 'assets/audio/aresat_ethiopian.mp3',
      lyrics: '''አረሳት ኢትዮጵያን በእርፈ መስቀል
አባ ተክለ ሀይማኖት ሰባኪ ወንጌል
የእግዚአብሔር ሰው ነው ተወዳጅ በሰማይ
የተረማመደ በፅድቅ አደባባይ

አዝማች፦
ፈውስና ፀሎቱ ቃሉ የተሰማ
ወንጌል የሰበከ በገጠር ከተማ
የኢቲሳው ኮከብ የደብረ አስቦቱ
ለወንጌል ተዋጋች ንፅህት ህይወቱ

ፋናው እስከ ዛሬ ሲያበራ የኖረው
የኢቲሳው አባት ፍስሀ ፅዮን ነው
እግዚአርያ እናቱ ማህፀነ ብሩክ
ወለደች ኮከብን ሲዖልን የሚያውክ

ዲያብሎስ እስካሁን ስሙ ሲጠራበት
ሲገረፍ ይኖራል በእሳት ሰንሰለት
አዲስ ሀዋርያ የኢትዮጲያ አባት
ደጋና ቆላውን በመስቀል ባረካት

ምንጩና ፏፏቴው ተራራው ቅዱስ ነው
የአባታችን መስቀል ፀሎት ስለነካው
የተራመደበት የዳሰሰው ሁሉ
ድውይ ይፈውሳል ሳር እና ቅጠሉ''',
      description: 'ስለ አባ ተክለ ሃይማኖት የሚዘመር',
      isFavorite: false,
    ),
    MezmurModel(
      id: '6',
      title: 'ጾም ዘከመ ነነዌ',
      artist: 'ዲያቆን ሄኖክ ኃይሌ',
      category: 'ጾም',
      duration: '4:50',
      audioUrl: 'assets/audio/tsom_zekeme.mp3',
      lyrics: '''ንስሐ ግቡ ንስሐ ግቡ
እግዚአብሔር መሐሪ ነውና ይቅር ይላችኋል
ንስሐ ግቡ ንስሐ ግቡ
እንደ ነነዌ ሕዝብ ጾም ዘከመ

ነነዌ ትልቅ ከተማ ነበረች
ነገር ግን ኃጢአት ሞልቶባት ነበር
እግዚአብሔር ዮናስን ላከ ያስጠነቅቃት
ሕዝቡም ንስሐ ገብተው ዳኑ

እኛም ንስሐ እንግባ በዚህ ጾም ወራት
ልባችንን እናንጻ በጸሎትና በስግደት
እግዚአብሔር ይማረን ኃጢአታችንን ይቅር ይበል
እንደ ነነዌ ሕዝብ ምሕረትን እናገኝ''',
      description: 'የነነዌ ጾም መዝሙር',
    ),
  ];

  @override
  List<Object?> get props => [
        id,
        title,
        artist,
        category,
        duration,
        audioUrl,
        lyrics,
        description,
        coverImageUrl,
        isFavorite,
      ];
}
