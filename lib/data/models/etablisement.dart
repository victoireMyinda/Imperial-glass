class Donnee {
    String? id;
    String? libele;
    String? abreviation;
    String? contact;

    Donnee({this.id, this.libele, this.abreviation, this.contact}); 

    Donnee.fromJson(Map<String, dynamic> json) {
        id = json['id'];
        libele = json['libele'];
        abreviation = json['abreviation'];
        contact = json['contact'];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = Map<String, dynamic>();
        data['id'] = id;
        data['libele'] = libele;
        data['abreviation'] = abreviation;
        data['contact'] = contact;
        return data;
    }
}

class Root {
    String? msg;
    int? status;
    List<Donnee?>? donnes;

    Root({this.msg, this.status, this.donnes}); 

    Root.fromJson(Map<String, dynamic> json) {
        msg = json['msg'];
        status = json['status'];
        if (json['données'] != null) {
         donnes = <Donnee>[];
         json['données'].forEach((v) {
         donnes!.add(Donnee.fromJson(v));
        });
      }
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = Map<String, dynamic>();
        data['msg'] = msg;
        data['status'] = status;
        // ignore: unnecessary_null_comparison
        data['Donnees'] =Donnee != null ? donnes!.map((v) => v?.toJson()).toList() : null;
        return data;
    }
}
