class product_model {
  String? title;
  String? price;
  String? condition;
  String? address;
  String? model;
  bool? box;
  bool? reciept;
  bool? laces;
  bool? legitCheck;
  List? images;
  String? sellerId;
  product_model(
      {this.title,
        this.price,
        this.condition,
        this.address,
        this.model,
        this.box,
        this.reciept,
        this.images,
        this.sellerId,this.laces,this.legitCheck});

  product_model.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    price = json['price'];
    condition = json['condition'];
    address = json['address'];
    model = json['model'];
    box = json['box'];
    reciept = json['reciept'];
    legitCheck = json['legitCheck'];
    laces = json['laces'];
    images = json['images'];
    sellerId = json['sellerId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['price'] = this.price;
    data['condition'] = this.condition;
    data['address'] = this.address;
    data['model'] = this.model;
    data['box'] = this.box;
    data['reciept'] = this.reciept;
    data['laces'] = this.laces;
    data['legitCheck'] = this.legitCheck;
    data['images'] = this.images;
    data['sellerId'] = this.sellerId;
    return data;
  }
}
