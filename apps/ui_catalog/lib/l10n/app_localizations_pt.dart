// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'Catálogo DS';

  @override
  String get menuFundamentals => 'Fundamentos';

  @override
  String get menuColorsTitle => 'Cores & Paleta';

  @override
  String get menuColorsSubtitle => 'Identidade visual, fundos e status';

  @override
  String get menuComponents => 'Componentes';

  @override
  String get menuChatTitle => 'Chat & Mensagens';

  @override
  String get menuChatSubtitle => 'Bolhas, avatars e lista de conversas';

  @override
  String get screenColorsTitle => 'Paleta de Cores';

  @override
  String get colorGroupBrand => 'Marca & Principal';

  @override
  String get colorGroupBackgrounds => 'Superfícies & Fundos';

  @override
  String get colorGroupMessages => 'Balões de Chat';

  @override
  String get colorGroupText => 'Tipografia & Ícones';

  @override
  String get screenChatTitle => 'Componentes de Chat';

  @override
  String get sectionListTiles => 'Listagem de Conversas';

  @override
  String get sectionBubbles => 'Balões de Mensagem';

  @override
  String get exampleName1 => 'Chaves';

  @override
  String get exampleMessage1 => 'Isso isso isso';

  @override
  String get exampleName2 => 'Seu Madruga';

  @override
  String get exampleMessage2 => 'Só não te dou outra porque...';

  @override
  String get exampleMessageReceived => 'Olá! Este é o balão de quem recebe.';

  @override
  String get exampleMessageSent => 'E este é o balão de quem envia (eu).';

  @override
  String get exampleMessageLong =>
      'Balão com texto longo para testar quebra de linha e layout responsivo no Flutter.';
}
