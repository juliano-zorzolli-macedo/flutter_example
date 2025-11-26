import 'package:flutter/material.dart';
import 'package:feature_chat_list/feature_chat_list.dart';
import '../l10n/app_localizations.dart';

/// Implementação concreta da interface de tradução que a Feature espera.
/// Ela delega as chamadas para o AppLocalizations gerado pelo Flutter.
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

/// Delegate genérico para injetar dependências de tradução dinamicamente.
class DynamicL10nDelegate<T> extends LocalizationsDelegate<T> {
  final Type _type;
  final T Function(Locale) _loadSync;

  const DynamicL10nDelegate(this._type, this._loadSync);

  @override
  bool isSupported(Locale locale) => true;

  @override
  Future<T> load(Locale locale) async => _loadSync(locale);

  @override
  bool shouldReload(old) => false;

  @override
  Type get type => _type;
}