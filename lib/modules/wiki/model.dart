class Wiki {
  String titre;
  String desc;

  Wiki({required this.titre, required this.desc});

  factory Wiki.fromJson(Map<String, dynamic> json) {
    return Wiki(
      titre: json['titre'],
      desc: json['desc'],
    );
  }

  factory Wiki.empty() {
    return Wiki(
      titre: "",
      desc: "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'titre': titre,
      'desc': desc,
    };
  }
}
