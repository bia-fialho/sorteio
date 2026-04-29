import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 224, 247, 246),

        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 0, 150, 136),
        ),

        appBarTheme: const AppBarTheme(
          elevation: 0,
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 0, 150, 136),
          foregroundColor: Colors.white,
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      home: const MainApp(),
    ),
  );
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {

  final TextEditingController _opcaoController = TextEditingController();
  String? _erroTexto;
  final List<String> _opcoes = [];

  final Random _random = Random();

  // 🔥 NOVA PALETA VERDE ÁGUA
  static const Color _rosa = Color.fromARGB(255, 0, 150, 136); // principal
  static const Color _rosaClaro = Color.fromARGB(255, 224, 247, 246); // fundo
  static const Color _rosaMedia = Color.fromARGB(255, 77, 208, 200); // destaque
  static const Color _cinza = Color.fromARGB(255, 38, 90, 87);
  static const Color _vermelho = Color.fromARGB(255, 46, 102, 91);
  static const Color _verde = Color.fromARGB(255, 74, 179, 146);

  void _sortear() {
    if (_opcoes.isEmpty || _opcoes.length < 2) {
      _mostrarErro("Adicione ao menos 2 opções para sortear!");
      return;
    }

    final int indice = _random.nextInt(_opcoes.length);
    final String sorteado = _opcoes[indice];

    _mostrarResultado(sorteado);
  }

  void _mostrarErro(String mensagem) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.warning_amber_rounded, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(child: Text(mensagem)),
          ],
        ),
        backgroundColor: _vermelho,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 5),
      ),
    );
  }

  void _mostrarSucesso(String opcao) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(child: Text('"$opcao" adicionada!')),
          ],
        ),
        backgroundColor: _verde,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _adicionarOpcao() {
    final texto = _opcaoController.text.trim();

    if (texto.isEmpty) {
      setState(() => _erroTexto = 'Digite ao menos uma opção');
      return;
    }

    if (_opcoes.contains(texto)) {
      setState(() => _erroTexto = 'Essa opção já foi adicionada!');
      return;
    }

    setState(() {
      _opcoes.add(texto);
      _erroTexto = null;
      _opcaoController.clear();
    });

    _mostrarSucesso(texto);
  }

  void _removerOpcao(int index) {
    setState(() => _opcoes.removeAt(index));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _rosaClaro,

      appBar: AppBar(
        title: const Text('🎲 Sorteador de Decisões'),
        actions: [
          if (_opcoes.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete_sweep),
              tooltip: 'Limpar tudo',
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('Limpar lista?'),
                    content: const Text('Todas as opções serão removidas.'),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    actions: [
                      TextButton(
                          onPressed: () => Navigator.pop(ctx),
                          child: const Text('Cancelar')),
                      ElevatedButton(
                        onPressed: () {
                          setState(() => _opcoes.clear());
                          Navigator.pop(ctx);
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: _vermelho,
                            foregroundColor: Colors.white),
                        child: const Text('Limpar'),
                      ),
                    ],
                  ),
                );
              },
            ),
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Center(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.25),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text('${_opcoes.length} opções',
                    style:
                        const TextStyle(color: Colors.white, fontSize: 13)),
              ),
            ),
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Image.network(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcShsq6J4utmCfd80S9OGCkv064sI5z1G2NblQ&s',
                height: 160,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  height: 160,
                  color: _rosaMedia,
                  child: const Center(
                      child: Text('🎲', style: TextStyle(fontSize: 64))),
                ),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: _opcaoController,
              onChanged: (_) => setState(() => _erroTexto = null),
              onSubmitted: (_) => _adicionarOpcao(),
              decoration: InputDecoration(
                hintText: 'Ex: Pizza, Sushi, Hambúrguer...',
                hintStyle: const TextStyle(
                    color: Color.fromARGB(255, 150, 200, 195)),
                labelText: 'Nova opção',
                labelStyle: const TextStyle(color: _cinza),
                prefixIcon:
                    const Icon(Icons.add_circle_outline, color: _rosa),
                errorText: _erroTexto,
                filled: true,
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide(
                      color: _erroTexto != null
                          ? _vermelho
                          : const Color.fromARGB(255, 200, 230, 225),
                      width: 1.5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide:
                      const BorderSide(color: _rosa, width: 2.0),
                ),
              ),
            ),

            const SizedBox(height: 12),

            ElevatedButton.icon(
              onPressed: _adicionarOpcao,
              icon: const Icon(Icons.add),
              label: const Text('Adicionar opção'),
              style: ElevatedButton.styleFrom(
                backgroundColor: _verde,
                foregroundColor: Colors.white,
              ),
            ),

            const SizedBox(height: 24),

            ElevatedButton.icon(
              onPressed: _opcoes.length >= 2 ? _sortear : null,
              icon: const Icon(Icons.shuffle),
              label: const Text('SORTEAR'),
              style: ElevatedButton.styleFrom(
                backgroundColor: _rosa,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _mostrarResultado(String resultado) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: _rosaMedia,
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Text('🎉', style: TextStyle(fontSize: 40)),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                resultado,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: _rosa,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      },
    );
  }
}