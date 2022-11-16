
final String tableArtical = 'News';

class ArticalFields {
  static final List<String> values = [
    /// Add all fields
    id, dark, image, title, description, time
  ];

  static final String id = '_id';
  static final String dark = 'Dark';
  static final String image = 'image';
  static final String url = 'url';

  static final String title = 'title';
  static final String description = 'description';
  static final String time = 'time';
}

class Artical {
  final int id;
  final String url;
  final bool dark;
  final String image;
  final String title;
  // final String description;
  // final DateTime createdTime;
  final String createdTime;


  const Artical({
    this.id,
    this.url,
     this.dark,
    this.image,
 this.title,
  // this.description,
  this.createdTime,
  });

  Artical copy({
    int id,
    bool dark,
    String url,
    String image,
    String title,
    // String description,
    String createdTime,
  }) =>
      Artical(
        id: id ?? this.id,
        dark: dark ?? this.dark,
        url: url??this.url,
        image: image ?? this.image,
        title: title ?? this.title,
        // description: description ?? this.description,
        createdTime: createdTime ?? this.createdTime,
      );

  static Artical fromJson(Map<String, Object> json) => Artical(
        id: json[ArticalFields .id] as int,
        url:json[ArticalFields.url] as String ,
        dark: json[ArticalFields .dark] == 1,
        image: json[ArticalFields .image] as String,
        title: json[ArticalFields .title] as String,
        // description: json[ArticalFields .description] as String,
        // createdTime: DateTime.parse(json[ArticalFields.time] as String),
        createdTime: json[ArticalFields.time] as String,

      );

  Map<String, Object> toJson() => {
        ArticalFields .id: id,
        ArticalFields.url:url,
        ArticalFields .title: title,
        ArticalFields .dark: dark ? 1 : 0,
        ArticalFields .image: image,
        // ArticalFields .description: description,
        ArticalFields .time: createdTime,
      };
}
