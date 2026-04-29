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
  final Random _random = Random();

  static const Color _principal = Color.fromARGB(255, 0, 150, 136);
  static const Color _claro = Color.fromARGB(255, 224, 247, 246);
  static const Color _medio = Color.fromARGB(255, 77, 208, 200);
  static const Color _cinza = Color.fromARGB(255, 38, 90, 87);

  final List<String> _frases = [
    "Acredite em você mesmo",
    "Você é mais forte do que imagina",
    "Nunca desista dos seus sonhos",
    "Tudo começa com o primeiro passo",
    "Você consegue!",
    "Hoje é um novo dia ",
    "Confie no processo",
    "Seja sua melhor versão",
    "Seu esforço vai valer a pena",
    "Grandes coisas levam tempo ",
    "Insista, persista, mas nunca desista, um dia você conquista!",
    "Nunca desista!",
    "Não deixe para amanhã, o que pode fazer hoje",
  ];

  String _fraseAtual = "";

  void _sortearFrase() {
    final int indice = _random.nextInt(_frases.length);
    final String frase = _frases[indice];

    _mostrarResultado(frase);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _claro,

      appBar: AppBar(
        title: const Text('❤️ Frases Motivacionais'),
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
                  color: _medio,
                  child: const Center(
                    child: Text('❤️', style: TextStyle(fontSize: 64)),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),

            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFEEEEEE)),
              ),
              child: const Text(
                "Um clique, uma frase motivacional ❤️",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: _cinza),
              ),
            ),

            const SizedBox(height: 30),

            ElevatedButton.icon(
              onPressed: _sortearFrase,
              icon: const Icon(Icons.auto_awesome),
              label: const Text(
                "GERAR FRASE",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: _principal,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 18),
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  // 🎉 DIALOG IGUAL AO DO SORTEADOR (adaptado)
  void _mostrarResultado(String resultado) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24)),
          backgroundColor: Colors.white,

          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: _medio,
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Text('💡', style: TextStyle(fontSize: 40)),
                ),
              ),

              const SizedBox(height: 16),

              const Text(
                'Sua motivação:',
                style: TextStyle(fontSize: 14, color: _cinza),
              ),

              const SizedBox(height: 8),

              Text(
                resultado,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: _principal,
                ),
              ),
            ],
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                Future.delayed(const Duration(milliseconds: 200), _sortearFrase);
              },
              child: const Text('Gerar outra', style: TextStyle(color: _cinza)),
            ),

            ElevatedButton(
              onPressed: () => Navigator.pop(dialogContext),
              style: ElevatedButton.styleFrom(
                backgroundColor: _principal,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Gostei!'),
            ),
          ],
        );
      },
    );
  }
}