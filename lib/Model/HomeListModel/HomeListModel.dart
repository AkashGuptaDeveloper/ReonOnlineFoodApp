class HomeListModel {
  int status;
  String statusMessage;
  List<HomeListData> data;

  HomeListModel({this.status, this.statusMessage, this.data});

  HomeListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusMessage = json['status_message'];
    if (json['data'] != null) {
      data = new List<HomeListData>();
      json['data'].forEach((v) {
        data.add(new HomeListData.fromJson(v));
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

class HomeListData {
  String id;
  String categoryName;
  String headerImage;
  String description;
  String image;
  String backgroundImage;
  String status;
  String createdBy;
  String updatedBy;
  String createdAt;
  String updatedAt;

  HomeListData(
      {this.id,
        this.categoryName,
        this.headerImage,
        this.description,
        this.image,
        this.backgroundImage,
        this.status,
        this.createdBy,
        this.updatedBy,
        this.createdAt,
        this.updatedAt});

  HomeListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryName = json['category_name'];
    headerImage = json['header_image'];
    description = json['description'];
    image = json['image'];
    backgroundImage = json['background_image'];
    status = json['status'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_name'] = this.categoryName;
    data['header_image'] = this.headerImage;
    data['description'] = this.description;
    data['image'] = this.image;
    data['background_image'] = this.backgroundImage;
    data['status'] = this.status;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}