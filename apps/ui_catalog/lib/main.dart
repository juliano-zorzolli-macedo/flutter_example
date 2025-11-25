import 'package:flutter/material.dart';
import 'package:design_system/design_system.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/app_localizations.dart';

void main() {
  runApp(const UiCatalogApp());
}

// --- Controller de Idioma ---
class LanguageController extends ChangeNotifier {
  static final LanguageController instance = LanguageController();
  Locale? _currentLocale;
  Locale? get currentLocale => _currentLocale;
  void changeLanguage(Locale locale) {
    _currentLocale = locale;
    notifyListeners();
  }
}

// --- Rotas ---
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

// --- App ---
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
          theme: AppTheme.lightTheme.copyWith(
            scaffoldBackgroundColor: const Color(0xFFF5F5F5),
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

// --- TELA HOME ---
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
              const PopupMenuItem(value: Locale('pt'), child: Text("🇧🇷 Português")),
              const PopupMenuItem(value: Locale('en'), child: Text("🇺🇸 English")),
              const PopupMenuItem(value: Locale('zh'), child: Text("🇨🇳 中文")),
            ],
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildMenuCard(
            context,
            title: s.menuColorsTitle,
            subtitle: s.menuColorsSubtitle,
            icon: Icons.palette_outlined,
            path: '/tokens/colors',
            color: Colors.purple.shade100,
          ),
          const SizedBox(height: 12),
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
        side: BorderSide(color: Colors.grey.shade200),
      ),
      color: Colors.white,
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(12)),
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

// --- TELA DE PALETA DE CORES ---
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
          _buildColorGroup("Brand", [
            _ColorItem("Primary", AppColors.primary),
            _ColorItem("Secondary", AppColors.secondary),
          ]),
          _buildColorGroup("Backgrounds", [
            _ColorItem("Bg Default", AppColors.background),
            _ColorItem("Bg Chat", AppColors.backgroundChat),
          ]),
          _buildColorGroup("Chat Elements", [
            _ColorItem("Bubble Me", AppColors.bubbleMe),
            _ColorItem("Bubble Other", AppColors.bubbleOther),
            _ColorItem("Badge", AppColors.badgeColor),
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
          child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: colors.map((c) => _buildColorCard(c)).toList(),
        ),
        const Divider(height: 32),
      ],
    );
  }

  Widget _buildColorCard(_ColorItem item) {
    return Container(
      width: 150,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          Container(
            height: 60,
            decoration: BoxDecoration(
              color: item.color,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: Colors.grey.shade300),
            ),
          ),
          const SizedBox(height: 8),
          Text(item.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
          Text(
            "#${item.color.value.toRadixString(16).toUpperCase().substring(2)}",
            style: TextStyle(color: Colors.grey[600], fontSize: 10),
          ),
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

// --- TELA DE COMPONENTES DE CHAT (ATUALIZADA) ---
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
          // Seção Avatars
          _buildSectionHeader("Avatars"),
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: Row(
              children: const [
                DSAvatar(size: 48, imageUrl: null),
                SizedBox(width: 16),
                DSAvatar(size: 48, imageUrl: "https://ui-avatars.com/api/?name=User+Name"),
                SizedBox(width: 16),
                DSAvatar(size: 32, imageUrl: null),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Seção Inputs
          _buildSectionHeader("Inputs"),
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: const DSSearchBar(hintText: "Search bar component", readOnly: true),
          ),

          const SizedBox(height: 24),

          // Seção Chat Tiles
          _buildSectionHeader(s.sectionListTiles),
          Card(
            elevation: 0,
            margin: EdgeInsets.zero,
            child: Column(
              children: [
                DSChatTile(
                  name: s.exampleName1,
                  lastMessage: s.exampleMessage1,
                  time: "10:00",
                  avatarUrl: "https://imagem.natelinha.uol.com.br/original/Chaves-Amazon_fc6facde849860724ed4afc8361abe83b4cc60d4.jpeg",
                  unreadCount: 2,
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

          const SizedBox(height: 24),

          // Seção Mensagens
          _buildSectionHeader(s.sectionBubbles),
          Container(
            padding: const EdgeInsets.all(16),
            color: AppColors.backgroundChat,
            child: Column(
              children: [
                DSMessageBubble(
                  text: s.exampleMessageReceived,
                  time: "09:00",
                  isMe: false,
                ),
                DSMessageBubble(
                  text: s.exampleMessageSent,
                  time: "09:02",
                  isMe: true,
                  isRead: true,
                ),
                DSMessageBubble(
                  text: s.exampleMessageLong,
                  time: "09:05",
                  isMe: false,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, left: 4),
      child: Text(
        title.toUpperCase(),
        style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
            letterSpacing: 1.0
        ),
      ),
    );
  }
}