class OutlayType {
  String userId;
  int? id;
  String name;
  String desc;
  OutlayType({
    required this.userId,
    this.id,
    required this.name,
    required this.desc,
  });
}

class MaterialModel {
  String userId;
  int? id;
  String name;
  String desc;
  bool isService;
  MaterialModel({
    this.id,
    required this.userId,
    required this.name,
    required this.desc,
    required this.isService,
  });
}

class Outlay {
  int? id;
  int materialId;
  int outlayTypeId;
  String userId;
  double price;
  String date;
  String desc;
  MaterialModel? material;
  OutlayType? outlayType;
  Outlay({
    this.id,
    this.outlayType,
    required this.outlayTypeId,
    this.material,
    required this.materialId,
    required this.userId,
    required this.price,
    required this.date,
    required this.desc,
  });
}
