import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:design_system/design_system.dart';
import 'package:feature_chat_list/feature_chat_list.dart';
import 'l10n/app_localizations.dart';

void main() {
  FeatureChatListModule.init();
  runApp(const ChatApp());
}

final _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const ChatListPage(),
      routes: [
        GoRoute(
          path: 'chat/:id',
          builder: (context, state) {
            final id = state.pathParameters['id'] ?? '';
            final extra = state.extra as Map<String, dynamic>?;
            final name = extra?['name'] ?? 'Conversa';

            return ChatDetailPage(chatId: id, chatName: name);
          },
        ),
      ],
    ),
  ],
);

class ChatL10nImpl implements ChatL10n {
  final AppLocalizations _l10n;
  ChatL10nImpl(this._l10n);

  @override
  String get appTitle => _l10n.appTitle;

  @override
  String get actionSearch => _l10n.actionSearch;

  @override
  String get errorGeneric => _l10n.errorGeneric;
}

class _DynamicDelegate<T> extends LocalizationsDelegate<T> {
  final Type _type;
  final T Function(Locale) _loadSync;

  const _DynamicDelegate(this._type, this._loadSync);

  @override
  bool isSupported(Locale locale) => true;

  @override
  Future<T> load(Locale locale) async => _loadSync(locale);

  @override
  bool shouldReload(old) => false;

  @override
  Type get type => _type;
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Phiz Chat',
      debugShowCheckedModeBanner: false,

      theme: AppTheme.lightTheme,

      locale: const Locale('pt'),
      supportedLocales: AppLocalizations.supportedLocales,

      localizationsDelegates: [
        AppLocalizations.delegate,

        _DynamicDelegate<ChatL10n>(
          ChatL10n,
              (locale) => ChatL10nImpl(lookupAppLocalizations(locale)),
        ),

        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      routerConfig: _router,
    );
  }
}