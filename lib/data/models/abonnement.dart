class Abonnement {
  late int id;
  late String libele;
  late String abreviation;
  late String contact;

  Abonnement.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    libele = json["libele"];
    abreviation = json["abreviation"];
    contact = json["contact"];
  }
}
