import 'package:flutter/material.dart';
import '../models/produto.dart';

class CadastroProduto extends StatefulWidget {
  const CadastroProduto({super.key});

  @override
  State<CadastroProduto> createState() => _CadastroProdutoState();
}

class _CadastroProdutoState extends State<CadastroProduto> {
  final _nomeController = TextEditingController();
  final _precoController = TextEditingController();
  final _descricaoController = TextEditingController();
  String? _erroNome;
  String? _erroPreco;

  @override
  void dispose() {
    _nomeController.dispose();
    _precoController.dispose();
    _descricaoController.dispose();
    super.dispose();
  }

  void _salvar() {
    setState(() {
      _erroNome = _nomeController.text.trim().isEmpty ? 'Informe o nome do produto' : null;
      _erroPreco = _precoController.text.trim().isEmpty ? 'Informe o preco do produto' : null;

      if (_erroPreco == null) {
        final preco = double.tryParse(_precoController.text.replaceAll(',', '.'));
        if (preco == null || preco < 0) {
          _erroPreco = 'Informe um preco valido';
        }
      }
    });

    if (_erroNome != null || _erroPreco != null) return;

    final produto = Produto(
      nome: _nomeController.text.trim(),
      preco: double.parse(_precoController.text.replaceAll(',', '.')),
      descricao: _descricaoController.text.trim(),
    );

    Navigator.pop(context, produto);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F0EB),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2C1810),
        foregroundColor: const Color(0xFFF5E6D3),
        title: const Text(
          'Novo Produto',
          style: TextStyle(
            fontFamily: 'Georgia',
            fontSize: 22,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            const Text(
              'Informacoes do Produto',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2C1810),
                fontFamily: 'Georgia',
              ),
            ),
            const SizedBox(height: 24),
            _buildCampo(
              label: 'Nome do Produto',
              controller: _nomeController,
              erro: _erroNome,
              icone: Icons.label_outline,
              hint: 'Ex: Camiseta Polo',
            ),
            const SizedBox(height: 16),
            _buildCampo(
              label: 'Preco (R\$)',
              controller: _precoController,
              erro: _erroPreco,
              icone: Icons.attach_money,
              hint: 'Ex: 59.90',
              teclado: TextInputType.numberWithOptions(decimal: true),
            ),
            const SizedBox(height: 16),
            _buildCampo(
              label: 'Descricao (opcional)',
              controller: _descricaoController,
              icone: Icons.description_outlined,
              hint: 'Descreva o produto...',
              maxLines: 3,
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: _salvar,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFB85C38),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                ),
                child: const Text(
                  'Salvar Produto',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCampo({
    required String label,
    required TextEditingController controller,
    required IconData icone,
    required String hint,
    String? erro,
    TextInputType teclado = TextInputType.text,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: Color(0xFF4A2C1A),
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: teclado,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.brown.shade300),
            prefixIcon: Icon(icone, color: const Color(0xFFB85C38), size: 20),
            filled: true,
            fillColor: Colors.white,
            errorText: erro,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.brown.shade100),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0xFFB85C38), width: 1.5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.red),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
        ),
      ],
    );
  }
}