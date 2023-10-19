class TabelaItem {
  static const String nomeTabela = 'Item';
  static const String nome = 'nome';
  static const String compraCasual = 'compraCasual';
  static const String estoqueAtual = 'estoqueAtual';
  static const String precoMinimo = 'precoMinimo';
  static const String precoMaximo = 'precoMaximo';
  static const String estoqueMaximo = 'estoqueMaximo';
  static const String estoqueMinimo = 'estoqueMinimo';
  static const String id = 'id';

  static const String tableSqlCreate = 'CREATE TABLE IF NOT EXISTS ${TabelaItem.nomeTabela}('
      '$id INTEGER PRIMARY KEY AUTOINCREMENT, '
      '$nome TEXT, '
      '$compraCasual INTEGER, '
      '$estoqueAtual INTEGER, '
      '$precoMaximo REAL, '
      '$precoMinimo REAL, '
      '$estoqueMaximo INTEGER, '
      '$estoqueMinimo INTEGER)';
}