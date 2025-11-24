import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_conversations_usecase.dart';
import 'chat_list_state.dart';

class ChatListCubit extends Cubit<ChatListState> {
  final GetConversationsUseCase getConversationsUseCase;

  ChatListCubit(this.getConversationsUseCase) : super(ChatListInitial());

  Future<void> loadConversations() async {
    emit(ChatListLoading());
    try {
      final list = await getConversationsUseCase();
      emit(ChatListLoaded(list));
    } catch (e) {
      emit(const ChatListError("Erro ao carregar conversas"));
    }
  }
}