// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'DS Catalog';

  @override
  String get menuFundamentals => 'Fundamentals';

  @override
  String get menuColorsTitle => 'Colors & Palette';

  @override
  String get menuColorsSubtitle => 'Brand identity, backgrounds and status';

  @override
  String get menuComponents => 'Components';

  @override
  String get menuChatTitle => 'Chat & Messages';

  @override
  String get menuChatSubtitle => 'Bubbles, avatars and chat lists';

  @override
  String get screenColorsTitle => 'Color Palette';

  @override
  String get colorGroupBrand => 'Brand & Primary';

  @override
  String get colorGroupBackgrounds => 'Surfaces & Backgrounds';

  @override
  String get colorGroupMessages => 'Chat Bubbles';

  @override
  String get colorGroupText => 'Typography & Icons';

  @override
  String get screenChatTitle => 'Chat Components';

  @override
  String get sectionListTiles => 'Conversation List';

  @override
  String get sectionBubbles => 'Message Bubbles';

  @override
  String get exampleName1 => 'Chaves';

  @override
  String get exampleMessage1 => 'It is it is it is';

  @override
  String get exampleName2 => 'Mr. Raymond';

  @override
  String get exampleMessage2 => 'I don\'t give you another one just because...';

  @override
  String get exampleMessageReceived => 'Hello! This is the receiver bubble.';

  @override
  String get exampleMessageSent => 'And this is the sender bubble (me).';

  @override
  String get exampleMessageLong =>
      'Bubble with long text to test line breaking and responsive layout in Flutter.';
}
