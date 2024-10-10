import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web/src/home/home_provider.dart';
import '../settings/settings_view.dart';
import 'home_models.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  static const routeName = '/home';

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  bool _expandAll = false;

  @override
  void initState() {
    super.initState();
    // Realizar la consulta al iniciar la vista
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(homeProvider.notifier).loadHierarchy();
    });
  }

  void _toggleExpandAll() {
    setState(() {
      _expandAll = !_expandAll;
    });
  }

  @override
  Widget build(BuildContext context) {
    final homeState = ref.watch(homeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Entidades y servicios'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.restorablePushNamed(context, SettingsView.routeName);
            },
          ),
        ],
      ),
      body: homeState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              children: homeState.items
                  .map((item) => TreeNode(item: item, expandAll: _expandAll))
                  .toList(),
            ),
    );
  }
}

class TreeNode extends StatefulWidget {
  final HomeItem item;
  final int level;
  final bool expandAll;

  const TreeNode(
      {Key? key, required this.item, this.level = 0, this.expandAll = false})
      : super(key: key);

  @override
  _TreeNodeState createState() => _TreeNodeState();
}

class _TreeNodeState extends State<TreeNode> {
  late bool _isExpanded;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.expandAll;
  }

  @override
  void didUpdateWidget(TreeNode oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.expandAll != oldWidget.expandAll) {
      setState(() {
        _isExpanded = widget.expandAll;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: widget.level * 16.0),
      child: ExpansionTile(
        key: PageStorageKey(widget.item.id),
        initiallyExpanded: _isExpanded,
        title: Text(
          '${widget.item.entity} : ${widget.item.name}',
          style: const TextStyle(
              color: Colors.blue), // Color for physical entities
        ),
        children: [
          ...widget.item.children
              .map((child) => TreeNode(
                  item: child,
                  level: widget.level + 1,
                  expandAll: widget.expandAll))
              .toList(),
          ...widget.item.services
              .map((service) => Padding(
                    padding: EdgeInsets.only(left: (widget.level + 1) * 16.0),
                    child: ListTile(
                      title: Text(
                        service.type != null
                            ? '${service.type} : ${service.service.map((apiService) => apiService.apiService).join(", ")}'
                            : service.service
                                .map((apiService) => apiService.apiService)
                                .join(", "),
                        style: const TextStyle(
                            color: Colors.green), // Color for services
                      ),
                      subtitle: service.address != null && service.port != null
                          ? Text('Address: ${service.address}:${service.port}')
                          : null,
                    ),
                  ))
              .toList(),
        ],
      ),
    );
  }
}
