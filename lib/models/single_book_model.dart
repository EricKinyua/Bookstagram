class SingleBookModel {
  String tagline;
  String bookUrl;

  SingleBookModel({this.tagline, this.bookUrl});

  factory SingleBookModel.fromJson(Map<String, dynamic> data) {
    return SingleBookModel(
      bookUrl: data['bookUrl'],
      tagline: data['tagline']
    );
  }

  Map<String, dynamic> toJson() => {'tagline': tagline, 'bookUrl': bookUrl};
}
