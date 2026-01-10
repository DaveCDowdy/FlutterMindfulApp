import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sembast/sembast_io.dart';
import 'quote.dart';

class DbHelper {
  DatabaseFactory dbFactory = databaseFactoryIo;
  Database? _db;
  final store = intMapStoreFactory.store('quotes');

  static final DbHelper _instance = DbHelper._internal();
  factory DbHelper() => _instance;
  DbHelper._internal();

  Future<Database> get _database async {
    _db ??= await _openDb();
    return _db!;
  }

  Future<Database> _openDb() async {
    if (_db == null) {
      final docsPath = await getApplicationDocumentsDirectory();
      final dbPath = join(docsPath.path, 'quotes.db');
      _db = await dbFactory.openDatabase(dbPath);
    }
    return _db!;
  }

  Future<int> insertQuote(Quote quote) async {
    try {
      final database = await _database;
      int id = await store.add(database, quote.toMap());
      return id;
    } catch (_) {
      return 0;
    }
  }

  Future<List<Quote>> getQuotes() async {
    final database = await _database;
    final finder = Finder(sortOrders: [SortOrder(Field.key, false)]);

    final quotesSnapshot = await store.find(database, finder: finder);
    return quotesSnapshot.map((item) {
      final quote = Quote.fromJson(item.value);
      quote.id = item.key;
      return quote;
    }).toList();
  }

  Future<bool> deleteQuote(int id) async {
    try {
      final database = await _database;
      await store.record(id).delete(database);
      return true;
    } on Exception catch (_) {
      return false;
    }
  }
}
