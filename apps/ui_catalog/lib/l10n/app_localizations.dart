import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('pt'),
    Locale('zh'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In pt, this message translates to:
  /// **'Catálogo DS'**
  String get appTitle;

  /// No description provided for @menuFundamentals.
  ///
  /// In pt, this message translates to:
  /// **'Fundamentos'**
  String get menuFundamentals;

  /// No description provided for @menuColorsTitle.
  ///
  /// In pt, this message translates to:
  /// **'Cores & Paleta'**
  String get menuColorsTitle;

  /// No description provided for @menuColorsSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'Identidade visual, fundos e status'**
  String get menuColorsSubtitle;

  /// No description provided for @menuComponents.
  ///
  /// In pt, this message translates to:
  /// **'Componentes'**
  String get menuComponents;

  /// No description provided for @menuChatTitle.
  ///
  /// In pt, this message translates to:
  /// **'Chat & Mensagens'**
  String get menuChatTitle;

  /// No description provided for @menuChatSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'Bolhas, avatars e lista de conversas'**
  String get menuChatSubtitle;

  /// No description provided for @screenColorsTitle.
  ///
  /// In pt, this message translates to:
  /// **'Paleta de Cores'**
  String get screenColorsTitle;

  /// No description provided for @colorGroupBrand.
  ///
  /// In pt, this message translates to:
  /// **'Marca & Principal'**
  String get colorGroupBrand;

  /// No description provided for @colorGroupBackgrounds.
  ///
  /// In pt, this message translates to:
  /// **'Superfícies & Fundos'**
  String get colorGroupBackgrounds;

  /// No description provided for @colorGroupMessages.
  ///
  /// In pt, this message translates to:
  /// **'Balões de Chat'**
  String get colorGroupMessages;

  /// No description provided for @colorGroupText.
  ///
  /// In pt, this message translates to:
  /// **'Tipografia & Ícones'**
  String get colorGroupText;

  /// No description provided for @screenChatTitle.
  ///
  /// In pt, this message translates to:
  /// **'Componentes de Chat'**
  String get screenChatTitle;

  /// No description provided for @sectionListTiles.
  ///
  /// In pt, this message translates to:
  /// **'Listagem de Conversas'**
  String get sectionListTiles;

  /// No description provided for @sectionBubbles.
  ///
  /// In pt, this message translates to:
  /// **'Balões de Mensagem'**
  String get sectionBubbles;

  /// No description provided for @exampleName1.
  ///
  /// In pt, this message translates to:
  /// **'Chaves'**
  String get exampleName1;

  /// No description provided for @exampleMessage1.
  ///
  /// In pt, this message translates to:
  /// **'Isso isso isso'**
  String get exampleMessage1;

  /// No description provided for @exampleName2.
  ///
  /// In pt, this message translates to:
  /// **'Seu Madruga'**
  String get exampleName2;

  /// No description provided for @exampleMessage2.
  ///
  /// In pt, this message translates to:
  /// **'Só não te dou outra porque...'**
  String get exampleMessage2;

  /// No description provided for @exampleMessageReceived.
  ///
  /// In pt, this message translates to:
  /// **'Olá! Este é o balão de quem recebe.'**
  String get exampleMessageReceived;

  /// No description provided for @exampleMessageSent.
  ///
  /// In pt, this message translates to:
  /// **'E este é o balão de quem envia (eu).'**
  String get exampleMessageSent;

  /// No description provided for @exampleMessageLong.
  ///
  /// In pt, this message translates to:
  /// **'Balão com texto longo para testar quebra de linha e layout responsivo no Flutter.'**
  String get exampleMessageLong;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'pt', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'pt':
      return AppLocalizationsPt();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
