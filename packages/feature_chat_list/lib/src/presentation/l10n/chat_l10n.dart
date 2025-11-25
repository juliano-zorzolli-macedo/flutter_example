import 'package:flutter/material.dart';

abstract class ChatL10n {
  static ChatL10n of(BuildContext context) {
    return Localizations.of<ChatL10n>(context, ChatL10n)!;
  }

  String get appTitle;
  String get actionSearch;
  String get errorGeneric;
}

class ChatL10nDelegate extends LocalizationsDelegate<ChatL10n> {
  final ChatL10n? _implementation;

  const ChatL10nDelegate([this._implementation]);

  @override
  bool isSupported(Locale locale) => true;

  @override
  Future<ChatL10n> load(Locale locale) async {
    return _implementation!;
  }

  @override
  bool shouldReload(ChatL10nDelegate old) => false;
}