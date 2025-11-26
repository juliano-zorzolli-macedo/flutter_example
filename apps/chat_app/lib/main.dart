import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:design_system/design_system.dart';
import 'package:feature_chat_list/feature_chat_list.dart';
import 'l10n/app_localizations.dart';
import 'l10n/l10n_adapter.dart';
import 'router/app_router.dart';

void main() {
  FeatureChatListModule.init();
  runApp(const ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
     onGenerateTitle: (context) => AppLocalizations.of(context)?.appTitle ?? 'Chat App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      // Configuração de Locale
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: [
        AppLocalizations.delegate,
        // Injeta a implementação de tradução na Feature
        DynamicL10nDelegate<ChatL10n>(
          ChatL10n,
              (locale) => ChatL10nImpl(lookupAppLocalizations(locale)),
        ),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      routerConfig: appRouter,
    );
  }
}