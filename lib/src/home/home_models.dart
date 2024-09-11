class HomeItem {
  final int id;
  final String entity;
  final String name;
  final List<HomeItem> children;

  HomeItem({
    required this.id,
    required this.entity,
    required this.name,
    this.children = const [],
  });

  factory HomeItem.fromJson(Map<String, dynamic> json) {
    return HomeItem(
      id: json['id'],
      entity: json['entity'],
      name: json['name'],
      children: (json['childs'] as List)
          .map((child) => HomeItem.fromJson(child))
          .toList(),
    );
  }
}
