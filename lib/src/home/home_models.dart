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
      id: json['id'] as String,
      entity: json['entity'] as String,
      name: json['name'] as String,
      children: (json['childs'] as List<dynamic>)
          .map((child) => HomeItem.fromJson(child as Map<String, dynamic>))
          .toList(),
      services: (json['services'] as List<dynamic>)
          .map((service) => Service.fromJson(service as Map<String, dynamic>))
          .toList(),
    );
  }
}

class Service {
  final String id;
  final String? address;
  final int? port;
  final String? type;
  final List<ApiService> service;

  Service({
    required this.id,
    this.address,
    this.port,
    this.type,
    required this.service,
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    var serviceData = json['service'];
    List<ApiService> serviceList;

    if (serviceData is String) {
      serviceList = [
        ApiService(apiService: serviceData, actuatorNode: '', property: '')
      ];
    } else if (serviceData is List) {
      serviceList = serviceData
          .map((apiService) =>
              ApiService.fromJson(apiService as Map<String, dynamic>))
          .toList();
    } else {
      serviceList = [];
    }

    return Service(
      id: json['id'] as String,
      address: json['address'] as String?,
      port: json['port'] as int?,
      type: json['type'] as String?,
      service: serviceList,
    );
  }
}

class ApiService {
  final String apiService;
  final String actuatorNode;
  final String property;

  ApiService({
    required this.apiService,
    required this.actuatorNode,
    required this.property,
  });

  factory ApiService.fromJson(Map<String, dynamic> json) {
    return ApiService(
      apiService: json['apiService'] as String,
      actuatorNode: json['actuatorNode'] as String,
      property: json['property'] as String,
    );
  }
}
