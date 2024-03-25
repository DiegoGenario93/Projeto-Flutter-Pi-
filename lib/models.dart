import 'dart:typed_data';

class MaintenanceForm {
  int? id;
  String? description;
  String? name;
  String? email;
  Uint8List? image;

  MaintenanceForm({this.id, this.description, this.name, this.email, this.image});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'description': description ?? '',
      'name': name ?? '',
      'email': email ?? '',
      'image': image,
    };
  }

  MaintenanceForm.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    description = map['description'];
    name = map['name'];
    email = map['email'];
    image = map['image'] as Uint8List?;
  }
}

