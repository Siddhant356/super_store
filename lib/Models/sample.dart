class Sample {
  String title;
  int id;
  double price;
  String image;
  String description;
  String category;
  Sample({this.id, this.title, this.price, this.image, this.description, this.category});
  factory Sample.fromJson(Map<String,dynamic> parsedJson){
    return Sample(
      image: parsedJson['image'],
      id: parsedJson['id'],
      price: parsedJson['price'].toDouble(),
      title: parsedJson['title'],
      description: parsedJson['description'],
      category: parsedJson['category']
    );
  }
}
