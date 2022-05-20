//bu dosyayı veritabanındaki tabloları modellemek için kullanacağız.
//dakika 01:08:40

class Category{
  String? name;
  String? description;
  int? id;
  String? deneme;
  //modeli maplemek için oluşturacağım fonksiyon; category map
  categoryMapp(){
    var mapping = Map<String, dynamic>();
    mapping['id'] = id;
    mapping['name'] = name;
    mapping['description'] = description;
    return mapping;
  }
}