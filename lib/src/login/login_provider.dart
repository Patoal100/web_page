import 'package:flutter_web/src/login/login_model.dart';
import 'package:flutter_web/src/shared/provider/repository_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final loginProvider = StateNotifierProvider<LoginNotifier, LoginState>((ref) {
  final repositoryService = ref.read(repositoryProvider);
  return LoginNotifier(LoginState(user: null), repositoryService);
});

class LoginState {
  final User? user;

  LoginState({
    required this.user,
  });

  LoginState copyWith({
    User? user,
  }) {
    return LoginState(
      user: user ?? this.user,
    );
  }
}

class LoginNotifier extends StateNotifier<LoginState> {
  final RepositoryService repositoryService;
  LoginNotifier(super.state, this.repositoryService);

  Future<void> login(String username, String password) async {
    try {
      final user =
          await repositoryService.authRepository.login(username, password);
      state = state.copyWith(user: user);
    } catch (error) {
      state = state.copyWith(user: null);
      throw Exception('Error: $error');
    }
  }
}
