class TabelaItem {
  static const String tablename = 'ItemTable';
  static const String name = 'name';
  static const String compraCasual = 'compraCasual';
  static const String estoqueAtual = 'estoqueAtual';
  static const String precoMinimo = 'precoMinimo';
  static const String precoMaximo = 'precoMaximo';
  static const String estoqueMaximo = 'estoqueMaximo';
  static const String estoqueMinimo = 'estoqueMinimo';
  static const String id = 'id';

  static const String tableSql = 'CREATE TABLE IF NOT EXISTS $tablename('
      '$id INTEGER PRIMARY KEY AUTOINCREMENT, '
      '$name TEXT, '
      '$compraCasual INTEGER, '
      '$estoqueAtual INTEGER, '
      '$precoMaximo REAL, '
      '$precoMinimo REAL, '
      '$estoqueMaximo INTEGER, '
      '$estoqueMinimo INTEGER)';
}