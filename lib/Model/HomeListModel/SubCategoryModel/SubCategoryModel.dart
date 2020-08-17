class SubCategoryModel {
  int status;
  String statusMessage;
  List<SubCategoryData> data;

  SubCategoryModel({this.status, this.statusMessage, this.data});

  SubCategoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusMessage = json['status_message'];
    if (json['data'] != null) {
      data = new List<SubCategoryData>();
      json['data'].forEach((v) {
        data.add(new SubCategoryData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['status_message'] = this.statusMessage;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubCategoryData {
  String id;
  String categoryId;
  String subCategoryName;
  String headerImage;
  String description;
  String image;
  String status;
  String createdBy;
  String updatedBy;
  String createdAt;
  String updatedAt;

  SubCategoryData(
      {this.id,
        this.categoryId,
        this.subCategoryName,
        this.headerImage,
        this.description,
        this.image,
        this.status,
        this.createdBy,
        this.updatedBy,
        this.createdAt,
        this.updatedAt});

  SubCategoryData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    subCategoryName = json['sub_category_name'];
    headerImage = json['header_image'];
    description = json['description'];
    image = json['image'];
    status = json['status'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_id'] = this.categoryId;
    data['sub_category_name'] = this.subCategoryName;
    data['header_image'] = this.headerImage;
    data['description'] = this.description;
    data['image'] = this.image;
    data['status'] = this.status;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}