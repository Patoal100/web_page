class HomeItem {
  final String id;
  final String entity;
  final String name;
  final List<HomeItem> children;
  final List<Service> services;

  HomeItem({
    required this.id,
    required this.entity,
    required this.name,
    this.children = const [],
    this.services = const [],
  });

  factory HomeItem.fromJson(Map<String, dynamic> json) {
    return HomeItem(
      id: json['id'],
      entity: json['entity'],
      name: json['name'],
      children: (json['childs'] as List)
          .map((child) => HomeItem.fromJson(child))
          .toList(),
      services: (json['services'] as List)
          .map((service) => Service.fromJson(service))
          .toList(),
    );
  }
}

class Service {
  final String id;
  final String? address;
  final int? port;
  final String? type;
  final String service;

  Service({
    required this.id,
    this.address,
    this.port,
    this.type,
    required this.service,
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      id: json['id'],
      address: json['address'],
      port: json['port'],
      type: json['type'],
      service: json['service'],
    );
  }
}
