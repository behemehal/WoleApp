class Connection {
  Connection(this.ip, this.title, this.mac, this.isFavorite);
  String ip;
  String title;
  String mac;
  bool isFavorite;

  Connection.fromJson(Map<String, dynamic> json)
      : ip = json["ip"],
        title = json["title"],
        mac = json["mac"],
        isFavorite = json["isFavorite"];

  Map<String, dynamic> toJson() => {
        "ip": ip,
        "title": title,
        "mac": mac,
        "isFavorite": isFavorite,
      };
}
