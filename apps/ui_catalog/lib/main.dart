import 'package:flutter/material.dart';
import 'package:design_system/design_system.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/app_localizations.dart';

void main() {
  runApp(const UiCatalogApp());
}

class LanguageController extends ChangeNotifier {
  static final LanguageController instance = LanguageController();

  Locale? _currentLocale;

  Locale? get currentLocale => _currentLocale;

  void changeLanguage(Locale locale) {
    _currentLocale = locale;
    notifyListeners();
  }
}

final _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const CatalogHomeScreen(),
      routes: [
        GoRoute(
          path: 'tokens/colors',
          builder: (context, state) => const ColorPaletteScreen(),
        ),
        GoRoute(
          path: 'components/chat',
          builder: (context, state) => const ChatComponentsScreen(),
        ),
      ],
    ),
  ],
);

class UiCatalogApp extends StatelessWidget {
  const UiCatalogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: LanguageController.instance,
      builder: (context, child) {
        return MaterialApp.router(
          onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,
          debugShowCheckedModeBanner: false,

          locale: LanguageController.instance.currentLocale,

          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
            useMaterial3: true,
            scaffoldBackgroundColor: const Color(0xFFF5F5F5),
            appBarTheme: const AppBarTheme(
              centerTitle: true,
              backgroundColor: Colors.white,
              elevation: 0,
              titleTextStyle: TextStyle(
                  color: Colors.black87,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
              iconTheme: IconThemeData(color: Colors.black87),
            ),
          ),
          routerConfig: _router,

          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('pt'),
            Locale('en'),
            Locale('zh'),
          ],
        );
      },
    );
  }
}

// --- TELA 1: HOME (Menu Principal) ---
class CatalogHomeScreen extends StatelessWidget {
  const CatalogHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final s = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(s.appTitle),
        actions: [
          PopupMenuButton<Locale>(
            icon: const Icon(Icons.language),
            onSelected: (Locale locale) {
              LanguageController.instance.changeLanguage(locale);
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: Locale('pt'),
                child: Row(children: [Text("🇧🇷 Português")]),
              ),
              const PopupMenuItem(
                value: Locale('en'),
                child: Row(children: [Text("🇺🇸 English")]),
              ),
              const PopupMenuItem(
                value: Locale('zh'),
                child: Row(children: [Text("🇨🇳 中文 (Chinese)")]),
              ),
            ],
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSectionTitle(s.menuFundamentals),
          _buildMenuCard(
            context,
            title: s.menuColorsTitle,
            subtitle: s.menuColorsSubtitle,
            icon: Icons.palette_outlined,
            path: '/tokens/colors',
            color: Colors.purple.shade100,
          ),
          const SizedBox(height: 24),
          _buildSectionTitle(s.menuComponents),
          _buildMenuCard(
            context,
            title: s.menuChatTitle,
            subtitle: s.menuChatSubtitle,
            icon: Icons.chat_bubble_outline,
            path: '/components/chat',
            color: Colors.green.shade100,
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 12),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
          color: Colors.grey[600],
        ),
      ),
    );
  }

  Widget _buildMenuCard(BuildContext context,
      {required String title,
        required String subtitle,
        required IconData icon,
        required String path,
        required Color color}) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: Colors.grey.shade200)),
      color: Colors.white,
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: Colors.black87),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => context.go(path),
      ),
    );
  }
}

class ColorPaletteScreen extends StatelessWidget {
  const ColorPaletteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final s = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(s.screenColorsTitle)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildColorGroup(s.colorGroupBrand, [
            _ColorItem("Primary", AppColors.primary),
          ]),
          _buildColorGroup(s.colorGroupBackgrounds, [
            _ColorItem("Background App", AppColors.background),
            _ColorItem("Chat Wallpaper", AppColors.backgroundChat),
          ]),
          _buildColorGroup(s.colorGroupMessages, [
            _ColorItem("Bubble Me", AppColors.bubbleMe),
            _ColorItem("Bubble Other", AppColors.bubbleOther),
          ]),
          _buildColorGroup(s.colorGroupText, [
            _ColorItem("Primary Text", AppColors.textPrimary),
            _ColorItem("Secondary Text", AppColors.textSecondary),
          ]),
        ],
      ),
    );
  }

  Widget _buildColorGroup(String title, List<_ColorItem> colors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Text(title,
              style:
              const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 2.0,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: colors.length,
          itemBuilder: (context, index) => _buildColorCard(colors[index]),
        ),
        const Divider(height: 32),
      ],
    );
  }

  Widget _buildColorCard(_ColorItem item) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: item.color,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade300),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  item.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 13),
                ),
                const SizedBox(height: 2),
                Text(
                  "#${item.color.value.toRadixString(16).toUpperCase().substring(2)}",
                  style: TextStyle(color: Colors.grey[600], fontSize: 11),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _ColorItem {
  final String name;
  final Color color;
  _ColorItem(this.name, this.color);
}

class ChatComponentsScreen extends StatelessWidget {
  const ChatComponentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final s = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: const Color(0xFFF0F2F5),
      appBar: AppBar(title: Text(s.screenChatTitle)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(s.sectionListTiles,
              style:
              const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Card(
            elevation: 0,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Column(
              children: [
                DSChatTile(
                  name: s.exampleName1,
                  lastMessage: s.exampleMessage1,
                  time: "17:21",
                  avatarUrl: "https://imagem.natelinha.uol.com.br/original/Chaves-Amazon_fc6facde849860724ed4afc8361abe83b4cc60d4.jpeg",
                  unreadCount: 1,
                ),
                const Divider(height: 1, indent: 70),
                DSChatTile(
                  name: s.exampleName2,
                  lastMessage: s.exampleMessage2,
                  time: "16:04",
                  avatarUrl: "https://www.rbsdirect.com.br/imagesrc/24341400.jpg?w=700",
                  isMuted: true,
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          Text(s.sectionBubbles,
              style:
              const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: AppColors.backgroundChat,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey.shade300),
            ),
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              children: [
                DSMessageBubble(
                  text: s.exampleMessageReceived,
                  time: "09:15",
                  isMe: false,
                ),
                DSMessageBubble(
                  text: s.exampleMessageSent,
                  time: "09:16",
                  isMe: true,
                  isRead: true,
                ),
                DSMessageBubble(
                  text: s.exampleMessageLong,
                  time: "09:17",
                  isMe: false,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}