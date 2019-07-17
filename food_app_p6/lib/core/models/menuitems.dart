class MenuItems {
  String Description;
  String Discount;
  String Image;
  String MenuId;
  String Name;
  String Price;
  String Id;
  int quantity;

  MenuItems(
      {this.Description,
      this.Discount,
      this.Image,
      this.MenuId,
      this.Name,
      this.Price,
      this.Id,
      this.quantity = 0});

  MenuItems.fromSnapshot(Map<String, dynamic> snapShot)
      : Description = snapShot['Description'].toString() ?? "empty describtion",
        Discount = snapShot['Discount'].toString() ?? "no discount found",
        Image = snapShot['Image'].toString() ??
            "https://cdn.images.express.co.uk/img/dynamic/67/590x/Liverpool-news-Real-Madrid-Barcelona-Mohamed-Salah-942358.jpg",
        MenuId = snapShot['MenuId'].toString(),
        Name = snapShot['Name'].toString() ?? "null name",
        Price = snapShot['Price'].toString() ?? "1",
        Id = snapShot['ID'].toString(),
        quantity = 0;
}
