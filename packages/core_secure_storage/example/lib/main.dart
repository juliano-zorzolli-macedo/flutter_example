import 'package:flutter/material.dart';
import 'package:core_secure_storage/core_secure_storage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _storage = CoreSecureStorage();

  final _controller = TextEditingController(text: '{"id": 1, "msg": "Olá Nativo!"}');

  String _statusMessage = 'Aguardando ação...';
  bool _isLoading = false;

  Future<void> _saveToNative() async {
    setState(() {
      _isLoading = true;
      _statusMessage = 'Encriptando e salvando no DataStore...';
    });

    try {
     await _storage.saveChatList(_controller.text);

      setState(() {
        _statusMessage = '✅ Sucesso! Dados encriptados e salvos no Android.';
      });
    } catch (e) {
      setState(() {
        _statusMessage = '❌ Erro: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _readFromNative() async {
    setState(() => _isLoading = true);
    try {
      final data = await _storage.getChatList();
      setState(() {
        _statusMessage = '📖 Leitura: $data';
      });
    } catch (e) {
      setState(() => _statusMessage = '❌ Erro na leitura: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Teste Secure Storage'),
          backgroundColor: Colors.teal,
        ),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Simulação de Dados (JSON)',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _controller,
                maxLines: 3,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Digite o JSON aqui',
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: _isLoading ? null : _saveToNative,
                icon: const Icon(Icons.lock),
                label: const Text('Salvar Seguro (Nativo)'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(16),
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                ),
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: _isLoading ? null : _readFromNative,
                icon: const Icon(Icons.lock_open),
                label: const Text('Ler Decriptado'),
              ),
              const SizedBox(height: 32),
              const Divider(),
              const SizedBox(height: 16),
              Text(
                'Status:',
                style: TextStyle(color: Colors.grey[600], fontSize: 12),
              ),
              const SizedBox(height: 8),
              Text(
                _statusMessage,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87
                ),
                textAlign: TextAlign.center,
              ),
              if (_isLoading)
                const Padding(
                  padding: EdgeInsets.only(top: 24.0),
                  child: Center(child: CircularProgressIndicator()),
                ),
            ],
          ),
        ),
      ),
    );
  }
}