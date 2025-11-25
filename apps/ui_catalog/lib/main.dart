import 'package:flutter/material.dart';
import 'package:design_system/design_system.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
// Certifique-se de gerar l10n para o ui_catalog também: 'melos run l10n:ui_catalog'
import 'l10n/app_localizations.dart';

void main() {
  runApp(const UiCatalogApp());
}

// Controller simples para troca de idioma em tempo real
class LanguageController extends ChangeNotifier {
  static final LanguageController instance = LanguageController();
  Locale? _currentLocale;
  Locale? get currentLocale => _currentLocale;
  void changeLanguage(Locale locale) {
    _currentLocale = locale;
    notifyListeners();
  }
}

// Configuração de Rotas do Catálogo
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

          // Usa o tema centralizado do Design System
          theme: AppTheme.lightTheme.copyWith(
            // Override leve apenas para o catálogo ter fundo cinza nas telas de menu
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

// --- TELA HOME DO CATÁLOGO ---
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

// --- TELA DE COMPONENTES DE CHAT ---
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
          const Text("List Tiles", style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Card(
            elevation: 0,
            child: Column(
              children: const [
                DSChatTile(
                  name: "Chaves",
                  lastMessage: "Isso isso isso",
                  time: "10:00",
                  avatarUrl: "https://ui-avatars.com/api/?name=Chaves",
                  unreadCount: 2,
                ),
                Divider(height: 1, indent: 70),
                DSChatTile(
                  name: "Seu Madruga",
                  lastMessage: "Só não te dou outra...",
                  time: "Ontem",
                  avatarUrl: "https://ui-avatars.com/api/?name=Seu+Madruga",
                  isMuted: true,
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text("Search Bar", style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const DSSearchBar(hintText: "Buscar no catálogo...", readOnly: true),
        ],
      ),
    );
  }
}