import 'package:flutter_web/src/data/repositories/auth_repository.dart';
import 'package:flutter_web/src/data/services/auth_services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/repositories/iot_repository.dart';
import '../../data/services/iot_services.dart';

final repositoryProvider = Provider<RepositoryService>((ref) {
  final authRepository = AuthRepository(AuthService());

  return RepositoryService(authRepository: authRepository);
});

class RepositoryService {
  final AuthRepository authRepository;

  RepositoryService({
    required this.authRepository,
  });
}

final iotRepositoryProvider = Provider<IotRepositoryService>((ref) {
  final iotRepository = IotRepository(IotService());

  return IotRepositoryService(iotRepository: iotRepository);
});

class IotRepositoryService {
  final IotRepository iotRepository;

  IotRepositoryService({required this.iotRepository});
}
