class message_Model{
  String ?recieverId;
  String ?senderId;
  String ?messageBody;
  String ? fileUrl;
  String ? messagetype;
  var createdAt;
  message_Model({this.createdAt,this.messageBody,this.recieverId,this.senderId,this.fileUrl,this.messagetype});
  message_Model.fromJson(Map<String, dynamic> json) {
   recieverId = json['recieverId'];
    senderId = json['senderId'];
    messageBody = json['messageBody'];
    createdAt = json['createdAt'];
    messagetype=json['messagetype'];
    fileUrl=json['fileUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['recieverId'] = this.recieverId;
    data['senderId'] = this.senderId;
    data['messageBody'] = this.messageBody;
    data['createdAt'] = this.createdAt;
    data['messagetype']=this.messagetype;
    data['fileUrl']=this.fileUrl;
    return data;
  }
}