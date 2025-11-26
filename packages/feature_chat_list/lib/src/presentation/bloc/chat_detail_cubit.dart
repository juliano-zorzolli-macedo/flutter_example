import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_chat_history_usecase.dart';
import 'chat_detail_state.dart';

class ChatDetailCubit extends Cubit<ChatDetailState> {
  final GetChatHistoryUseCase getChatHistoryUseCase;

  ChatDetailCubit(this.getChatHistoryUseCase) : super(ChatDetailInitial());

  Future<void> loadMessages(String chatId) async {
    emit(ChatDetailLoading());
    try {
      final messages = await getChatHistoryUseCase(chatId);
      emit(ChatDetailLoaded(messages));
    } catch (e) {
      emit(const ChatDetailError("Erro ao carregar histórico"));
    }
  }
}