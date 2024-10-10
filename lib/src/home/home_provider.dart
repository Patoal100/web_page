import 'dart:async';
import 'dart:convert';

import 'package:flutter_web/src/home/home_models.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../shared/provider/repository_provider.dart';

final homeProvider = StateNotifierProvider<HomeNotifier, HomeState>((ref) {
  final iotRepositoryService = ref.read(iotRepositoryProvider);
  return HomeNotifier(const HomeState(), iotRepositoryService);
});

class HomeState {
  final List<HomeItem> items;
  final bool isLoading;

  const HomeState({
    this.items = const [],
    this.isLoading = false,
  });

  HomeState copyWith({
    List<HomeItem>? items,
    bool? isLoading,
  }) {
    return HomeState(
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class HomeNotifier extends StateNotifier<HomeState> {
  final IotRepositoryService iotRepositoryService;
  late WebSocketChannel channel;

  HomeNotifier(super.state, this.iotRepositoryService) {
    // Timer.periodic(const Duration(seconds: 10), (timer) {
    //   loadHierarchy();
    // });
    _connectWebSocket();
  }

  void _connectWebSocket() {
    channel = WebSocketChannel.connect(Uri.parse('ws://localhost:8080'));

    channel.stream.listen((message) {
      final data = jsonDecode(message);
      if (data['type'] == 'update') {
        loadHierarchy();
      }
    });
  }

  Future<void> loadHierarchy() async {
    state = state.copyWith(isLoading: true);
    try {
      final hierarchy =
          await iotRepositoryService.iotRepository.fetchHierarchy();
      state = state.copyWith(items: [hierarchy], isLoading: false);
    } catch (error) {
      state = state.copyWith(isLoading: false);
      // print('Error loading hierarchy: $error');
    }
  }
}
