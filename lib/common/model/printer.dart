class Printer {
  int rowNo;
  int port;
  String ip;
  String name;
  int pageSize;
  String state;
  int id;
  int pageNum;
  String status;

  Printer({this.rowNo, this.port, this.ip, this.name, this.pageSize, this.state, this.id, this.pageNum, this.status});

  Printer.fromJson(Map<String, dynamic> json) {
    rowNo = json['rowNo'];
    port = json['port'];
    ip = json['ip'];
    name = json['name'];
    pageSize = json['pageSize'];
    state = json['state'];
    id = json['id'];
    pageNum = json['pageNum'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rowNo'] = this.rowNo;
    data['port'] = this.port;
    data['ip'] = this.ip;
    data['name'] = this.name;
    data['pageSize'] = this.pageSize;
    data['state'] = this.state;
    data['id'] = this.id;
    data['pageNum'] = this.pageNum;
    data['status'] = this.status;
    return data;
  }
}
