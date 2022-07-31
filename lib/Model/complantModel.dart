class ComplaintModel {
  String? complaintId;
  String? date;
  String? complaint;
  String? postNumber;
  String? status;

  ComplaintModel(
      {this.complaintId,
        this.date,
        this.complaint,
        this.postNumber,
        this.status});

  ComplaintModel.fromJson(Map<String, dynamic> json) {
    complaintId = json['complaint_id'];
    date = json['date'];
    complaint = json['complaint'];
    postNumber = json['post_number'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['complaint_id'] = this.complaintId;
    data['date'] = this.date;
    data['complaint'] = this.complaint;
    data['post_number'] = this.postNumber;
    data['status'] = this.status;
    return data;
  }
}