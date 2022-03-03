import 'package:moor/moor.dart';
import 'database.dart';

part 'tagdb.g.dart';

class MyTag extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get category => text().withLength(min: 1, max: 6)();
  TextColumn get tagname => text().withLength(min: 1, max: 10)();
}

@UseDao(tables: [MyTag])
class MyTagDao extends DatabaseAccessor<Database> with _$MyTagDaoMixin {
  MyTagDao(Database db) : super(db);

  Stream<List<MyTagData>> streamMyTag() => select(myTag).watch();

  Future insertMyTag(MyTagCompanion data) => into(myTag).insert(data);

  Future deleteMyTag(String tagName) {
    return (delete(myTag)..where((tbl) => tbl.tagname.equals(tagName))).go();
  }
  // Future deleteMyTag(MyTagCompanion data) => delete(myTag).delete(data);
}
