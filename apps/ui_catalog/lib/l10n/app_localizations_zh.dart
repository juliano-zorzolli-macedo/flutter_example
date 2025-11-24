// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => '设计系统目录';

  @override
  String get menuFundamentals => '基础 (Token)';

  @override
  String get menuColorsTitle => '颜色和调色板';

  @override
  String get menuColorsSubtitle => '主要颜色、背景和状态';

  @override
  String get menuComponents => '组件';

  @override
  String get menuChatTitle => '聊天和消息';

  @override
  String get menuChatSubtitle => '气泡、头像和对话列表';

  @override
  String get screenColorsTitle => '调色板';

  @override
  String get colorGroupBrand => '品牌与主色';

  @override
  String get colorGroupBackgrounds => '表面与背景';

  @override
  String get colorGroupMessages => '聊天气泡';

  @override
  String get colorGroupText => '排版与图标';

  @override
  String get screenChatTitle => '聊天组件';

  @override
  String get sectionListTiles => '对话列表';

  @override
  String get sectionBubbles => '消息气泡';

  @override
  String get exampleName1 => '查维斯';

  @override
  String get exampleMessage1 => '是的是的是的';

  @override
  String get exampleName2 => '雷蒙先生';

  @override
  String get exampleMessage2 => '我不给你另一个只是因为...';

  @override
  String get exampleMessageReceived => '你好！这是接收者的气泡。';

  @override
  String get exampleMessageSent => '这是发送者的气泡（我）。';

  @override
  String get exampleMessageLong => '带有长文本的气泡，用于测试 Flutter 中的换行和响应式布局。';
}
