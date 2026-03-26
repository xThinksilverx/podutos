class Produto {
  final String nome;
  final double preco;
  final String descricao;

  Produto({
    required this.nome,
    required this.preco,
    this.descricao = '',
  });
}