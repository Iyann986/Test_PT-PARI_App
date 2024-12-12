class ItemModels {
  final String? id;
  final String name;
  final Map<String, dynamic>? data;

  ItemModels({this.id, required this.name, this.data});

  factory ItemModels.fromJson(Map<String, dynamic> json) {
    return ItemModels(
      id: json['id'],
      name: json['name'],
      data:
          json['data'] != null ? Map<String, dynamic>.from(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'data': data,
    };
  }
}
