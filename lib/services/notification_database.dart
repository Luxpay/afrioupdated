import 'package:luxpay/podos/notifications.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class NotificationDatabase {
  static final NotificationDatabase instance = NotificationDatabase._init();

  static Database? _database;

  NotificationDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('notification.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';

    await db.execute('''
CREATE TABLE $tableNotification ( 
  ${NotificationFields.id} $idType, 
  ${NotificationFields.msgTitle} $textType,
  ${NotificationFields.msgBody} $textType,
  ${NotificationFields.time} $textType
  )
''');
  }

  Future<Notifications> create(Notifications notification) async {
    final db = await instance.database;

    // final json = note.toJson();
    // final columns =
    //     '${NoteFields.title}, ${NoteFields.description}, ${NoteFields.time}';
    // final values =
    //     '${json[NoteFields.title]}, ${json[NoteFields.description]}, ${json[NoteFields.time]}';
    // final id = await db
    //     .rawInsert('INSERT INTO table_name ($columns) VALUES ($values)');

    final id = await db.insert(tableNotification, notification.toJson());

    return notification.copy(id: id);
  }

  Future<Notifications> readNote(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableNotification,
      columns: NotificationFields.values,
      where: '${NotificationFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Notifications.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Notifications>> readAllNotification() async {
    final db = await instance.database;

    final orderBy = '${NotificationFields.time} ASC';
    final result =
        await db.rawQuery('SELECT * FROM $tableNotification ORDER BY $orderBy');

    // final result = await db.query(tableNotification, orderBy: orderBy);

    return result.map((json) => Notifications.fromJson(json)).toList();
  }

  Future<int> update(Notifications notification) async {
    final db = await instance.database;

    return db.update(
      tableNotification,
      notification.toJson(),
      where: '${NotificationFields.id} = ?',
      whereArgs: [notification.id],
    );
  }

  Future<int> delete(int? id) async {
    final db = await instance.database;

    return await db.delete(
      tableNotification,
      where: '${NotificationFields.id} = ?',
      whereArgs: [id],
    );
  }

  // Future close() async {
  //   final db = await instance.database;

  //   db.close();
  // }
}
