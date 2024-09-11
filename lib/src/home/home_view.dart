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
  @override
  void initState() {
    super.initState();
    // Realizar la consulta al iniciar la vista
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(homeProvider.notifier).loadHierarchy();
    });
  }

  @override
  Widget build(BuildContext context) {
    final homeState = ref.watch(homeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
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
              children:
                  homeState.items.map((item) => TreeNode(item: item)).toList(),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Agregar lógica para añadir un nuevo elemento
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class TreeNode extends StatelessWidget {
  final HomeItem item;
  final int level;

  const TreeNode({Key? key, required this.item, this.level = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: level * 16.0),
      child: ExpansionTile(
        title: Text('${item.entity} : ${item.name}'),
        children: item.children
            .map((child) => TreeNode(item: child, level: level + 1))
            .toList(),
      ),
    );
  }
}
