library feature_chat_list;

import 'package:get_it/get_it.dart';
import 'package:core_secure_storage/core_secure_storage.dart';

import 'src/data/datasources/chat_mock_datasource.dart';
import 'src/data/repositories/chat_repository_impl.dart';
import 'src/domain/repositories/chat_repository.dart';
import 'src/domain/usecases/get_conversations_usecase.dart';
import 'src/domain/usecases/get_chat_history_usecase.dart'; // Import
import 'src/presentation/bloc/chat_list_cubit.dart';
import 'src/presentation/bloc/chat_detail_cubit.dart'; // Import

export 'src/presentation/pages/chat_list_page.dart';
export 'src/presentation/pages/chat_detail_page.dart';
export 'src/presentation/l10n/chat_l10n.dart';

class FeatureChatListModule {
  static void init() {
    final i = GetIt.instance;

    i.registerLazySingleton(() => CoreSecureStorage());
    i.registerLazySingleton(() => ChatMockDataSource());

    i.registerLazySingleton<ChatRepository>(
          () => ChatRepositoryImpl(i(), i()),
    );

    // UseCases
    i.registerLazySingleton(() => GetConversationsUseCase(i()));
    i.registerLazySingleton(() => GetChatHistoryUseCase(i()));

    // Cubits
    i.registerFactory(() => ChatListCubit(i()));
    i.registerFactory(() => ChatDetailCubit(i()));
  }
}