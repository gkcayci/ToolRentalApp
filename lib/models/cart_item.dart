class CartItemModel {
  static const ID = "id";
  static const NAME = "name";
  static const IMAGE = "image";
  static const AVAILABLEDAYS = "availabledays";

  static const PRODUCT_ID = "productId";
  static const RENT = "rent";
  static const TOTALPAY = "totalPay";
  // static const SIZE = "size";
  // static const COLOR = "color";

  String _id;
  String _name;
  num _totalPay;
  String _image;
  String _productId;
  num _availabledays;

  // String _size;
  // String _color;
  num _rent;

  //  getters
  String get id => _id;
  num get totalPay => _totalPay;

  String get name => _name;

  String get image => _image;

  String get productId => _productId;
  num get availabledays => _availabledays;

  // String get size => _size;

  // String get color => _color;

  num get rent => _rent;

  CartItemModel.fromMap(Map data) {
    _id = data[ID];
    _name = data[NAME];
    _image = data[IMAGE];
    _productId = data[PRODUCT_ID];
    _availabledays = data[AVAILABLEDAYS];
    _totalPay = data[TOTALPAY];
    _rent = data[RENT];
    // _size = data[SIZE];
    // _color = data[COLOR];
  }

  Map toMap() => {
        ID: _id,
        IMAGE: _image,
        TOTALPAY: _totalPay,
        NAME: _name,
        PRODUCT_ID: _productId,
        RENT: _rent,
        AVAILABLEDAYS: _availabledays,
        // SIZE: _size,
        // COLOR: _color
      };
}
