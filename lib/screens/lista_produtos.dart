import 'package:flutter/material.dart';
import '../models/produto.dart';
import 'cadastro_produto.dart';
import 'detalhe_produto.dart';

class ListaProdutos extends StatefulWidget {
  const ListaProdutos({super.key});

  @override
  State<ListaProdutos> createState() => _ListaProdutosState();
}

class _ListaProdutosState extends State<ListaProdutos> {
  final List<Produto> _produtos = [];

  Future<void> _navegarParaCadastro() async {
    final produto = await Navigator.push<Produto>(
      context,
      MaterialPageRoute(builder: (context) => const CadastroProduto()),
    );

    if (produto != null) {
      setState(() => _produtos.add(produto));
    }
  }

  void _navegarParaDetalhe(Produto produto) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetalheProduto(produto: produto),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F0EB),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2C1810),
        foregroundColor: const Color(0xFFF5E6D3),
        title: const Text(
          'Produtos',
          style: TextStyle(
            fontFamily: 'Georgia',
            fontSize: 22,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navegarParaCadastro,
        backgroundColor: const Color(0xFFB85C38),
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
      body: _produtos.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.inventory_2_outlined,
                    size: 80,
                    color: Colors.brown.shade200,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Nenhum produto cadastrado',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.brown.shade400,
                      fontFamily: 'Georgia',
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Toque no + para adicionar',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.brown.shade300,
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _produtos.length,
              itemBuilder: (context, index) {
                final produto = _produtos[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () => _navegarParaDetalhe(produto),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.brown.shade100,
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 8,
                        ),
                        leading: CircleAvatar(
                          backgroundColor: const Color(0xFFB85C38),
                          child: Text(
                            produto.nome[0].toUpperCase(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        title: Text(
                          produto.nome,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Color(0xFF2C1810),
                          ),
                        ),
                        subtitle: Text(
                          'R\$ ${produto.preco.toStringAsFixed(2)}',
                          style: TextStyle(
                            color: Colors.brown.shade400,
                            fontSize: 14,
                          ),
                        ),
                        trailing: Icon(
                          Icons.chevron_right,
                          color: Colors.brown.shade300,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}