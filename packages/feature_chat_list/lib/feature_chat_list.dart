library feature_chat_list;

import 'package:get_it/get_it.dart';
import 'src/data/datasources/chat_mock_datasource.dart';
import 'src/data/repositories/chat_repository_impl.dart';
import 'src/domain/repositories/chat_repository.dart';
import 'src/domain/usecases/get_conversations_usecase.dart';
import 'src/presentation/bloc/chat_list_cubit.dart';

export 'src/presentation/pages/chat_list_page.dart';

// Classe simples para inicializar DI do módulo
class FeatureChatListModule {
  static void init() {
    final i = GetIt.instance;

    // Datasource
    i.registerLazySingleton(() => ChatMockDataSource());

    // Repository
    i.registerLazySingleton<ChatRepository>(
          () => ChatRepositoryImpl(i()),
    );

    // UseCase
    i.registerLazySingleton(() => GetConversationsUseCase(i()));

    // Cubit
    i.registerFactory(() => ChatListCubit(i()));
  }
}