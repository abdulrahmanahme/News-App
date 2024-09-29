
final String tableArticle = 'News';

class ArticleFields {
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

class Article {
  final int id;
  final String url;
  final bool dark;
  final String image;
  final String title;
  // final String description;
  // final DateTime createdTime;
  final String createdTime;


  const Article({
    this.id,
    this.url,
     this.dark,
    this.image,
 this.title,
  // this.description,
  this.createdTime,
  });

  Article copy({
    int id,
    bool dark,
    String url,
    String image,
    String title,
    // String description,
    String createdTime,
  }) =>
      Article(
        id: id ?? this.id,
        dark: dark ?? this.dark,
        url: url??this.url,
        image: image ?? this.image,
        title: title ?? this.title,
        // description: description ?? this.description,
        createdTime: createdTime ?? this.createdTime,
      );

  static Article fromJson(Map<String, Object> json) => Article(
        id: json[ArticleFields .id] as int,
        url:json[ArticleFields.url] as String ,
        dark: json[ArticleFields .dark] == 1,
        image: json[ArticleFields .image] as String,
        title: json[ArticleFields .title] as String,
        // description: json[ArticleFields .description] as String,
        // createdTime: DateTime.parse(json[ArticleFields.time] as String),
        createdTime: json[ArticleFields.time] as String,

      );

  Map<String, Object> toJson() => {
        ArticleFields .id: id,
        ArticleFields.url:url,
        ArticleFields .title: title,
        ArticleFields .dark: dark ? 1 : 0,
        ArticleFields .image: image,
        // ArticleFields .description: description,
        ArticleFields .time: createdTime,
      };
}
