class SearchSubCategory {
  int status;
  String statusMessage;
  List<SearchSubCategoryData> data;

  SearchSubCategory({this.status, this.statusMessage, this.data});

  SearchSubCategory.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusMessage = json['status_message'];
    if (json['data'] != null) {
      data = new List<SearchSubCategoryData>();
      json['data'].forEach((v) {
        data.add(new SearchSubCategoryData.fromJson(v));
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

class SearchSubCategoryData {
  String id;
  String categoryId;
  String subCategoryId;
  String productName;
  String headerImage;
  String displayOrder;
  Null featuredOrder;
  String size;
  String content;
  String storage;
  String ingredients;
  String consumption;
  String labeling;
  String overview;
  String directions;
  String image;
  String price;
  String status;
  String createdBy;
  String updatedBy;
  String createdAt;
  String video;

  SearchSubCategoryData(
      {this.id,
        this.categoryId,
        this.subCategoryId,
        this.productName,
        this.headerImage,
        this.displayOrder,
        this.featuredOrder,
        this.size,
        this.content,
        this.storage,
        this.ingredients,
        this.consumption,
        this.labeling,
        this.overview,
        this.directions,
        this.image,
        this.price,
        this.status,
        this.createdBy,
        this.updatedBy,
        this.createdAt,
        this.video});

  SearchSubCategoryData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    subCategoryId = json['sub_category_id'];
    productName = json['product_name'];
    headerImage = json['header_image'];
    displayOrder = json['display_order'];
    featuredOrder = json['featured_order'];
    size = json['size'];
    content = json['content'];
    storage = json['storage'];
    ingredients = json['ingredients'];
    consumption = json['consumption'];
    labeling = json['labeling'];
    overview = json['overview'];
    directions = json['directions'];
    image = json['image'];
    price = json['price'];
    status = json['status'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    createdAt = json['created_at'];
    video = json['video'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_id'] = this.categoryId;
    data['sub_category_id'] = this.subCategoryId;
    data['product_name'] = this.productName;
    data['header_image'] = this.headerImage;
    data['display_order'] = this.displayOrder;
    data['featured_order'] = this.featuredOrder;
    data['size'] = this.size;
    data['content'] = this.content;
    data['storage'] = this.storage;
    data['ingredients'] = this.ingredients;
    data['consumption'] = this.consumption;
    data['labeling'] = this.labeling;
    data['overview'] = this.overview;
    data['directions'] = this.directions;
    data['image'] = this.image;
    data['price'] = this.price;
    data['status'] = this.status;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['created_at'] = this.createdAt;
    data['video'] = this.video;
    return data;
  }
}