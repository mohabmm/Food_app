class Category {
  String image;
  String name;

  Category({this.image, this.name});

  Category.fromSnapshot(Map<String, dynamic> snapShot)
      : image = snapShot['Image'] ??
            "https://via.placeholder.com/300/09f.png/fff%20C/O%20https://placeholder.com/",
        name = snapShot['Name'] ?? "null name";
}
