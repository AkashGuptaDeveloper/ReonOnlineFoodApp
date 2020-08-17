class CouponModel {
  int status;
  String statusMessage;
  List<Data> data;

  CouponModel({this.status, this.statusMessage, this.data});

  CouponModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusMessage = json['status_message'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
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

class Data {
  String id;
  String offerName;
  String offerDetails;
  String message;
  String image;
  String status;
  String createdBy;
  String createdAt;
  String updatedBy;
  String updatedAt;

  Data(
      {this.id,
        this.offerName,
        this.offerDetails,
        this.message,
        this.image,
        this.status,
        this.createdBy,
        this.createdAt,
        this.updatedBy,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    offerName = json['offer_name'];
    offerDetails = json['offer_details'];
    message = json['message'];
    image = json['image'];
    status = json['status'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    updatedBy = json['updated_by'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['offer_name'] = this.offerName;
    data['offer_details'] = this.offerDetails;
    data['message'] = this.message;
    data['image'] = this.image;
    data['status'] = this.status;
    data['created_by'] = this.createdBy;
    data['created_at'] = this.createdAt;
    data['updated_by'] = this.updatedBy;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}