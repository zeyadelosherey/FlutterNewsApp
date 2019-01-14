class NewsModel {
  final String flag;
  final int sum;
  final List<News> newsList;

  NewsModel({this.flag ,this.sum , this.newsList});

  factory NewsModel.fromJson(Map<String, dynamic> parsedJson){

    var list = parsedJson['articles'] as List;
    print(list.runtimeType);
    List<News> NewsList = list.map((i) => News.fromJson(i)).toList();


    return NewsModel(
        flag: parsedJson['status'],
        sum: parsedJson['totalResults'],
        newsList: NewsList

    );
  }
}

class News {
  final Source source;

  final String author;
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final String publishedAt;
  final String content;



  News({this.source , this.author , this.title, this.description , this.url,this.urlToImage ,this.publishedAt, this.content  });

  factory News.fromJson(Map<String, dynamic> parsedJson){
    return News(
        source: Source.fromJson(parsedJson['source']),
        author : parsedJson['author'],
        title:parsedJson['title'],
        description:parsedJson['description'],
        url:parsedJson['url'],
        urlToImage:parsedJson['urlToImage'],
        publishedAt:parsedJson['publishedAt'],
        content:parsedJson['content'],


    );
  }
}

class Source{
  String id;
  String name;

  Source({
    this.id,
    this.name
  });

  factory Source.fromJson(Map<String, dynamic> json){
    return Source(
        id: json['id'],
        name: json['name']
    );
  }
}