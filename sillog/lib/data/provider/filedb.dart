import 'database.dart';
import 'package:moor/moor.dart';
import 'dart:developer' as dev;

part 'filedb.g.dart';

class UserFile extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get title => text()();

  TextColumn get beforePath => text()();
  TextColumn get appPath => text()();
  TextColumn get category => text().withLength(min: 1, max: 10)();
  TextColumn get extension => text().withLength(min: 1, max: 10)();

  IntColumn get size => integer()();
  TextColumn get linkedSillog => text()();

  DateTimeColumn get createdAt =>
      dateTime().withDefault(Constant(DateTime.now()))();
}

/// file - tag (many - many)
/// file - sillog (one - one)
/// file - fileWithTag - tag : 연결고리를 만들어서 진행

// 대부분의 기능이 Dao에 있음
@UseDao(tables: [UserFile])
class UserFileDao extends DatabaseAccessor<Database> with _$UserFileDaoMixin {
  UserFileDao(Database db) : super(db);

  // get은 한번만 가져오는 것, watch는 스트림
  Stream<List<UserFileData>> streamUserFiles() => select(userFile).watch();

  Stream<UserFileData> streamUserFile(int id) =>
      (select(userFile)..where((tbl) => tbl.id.equals(id))).watchSingle();

  Stream<List<UserFileData>> streamCategoryFiles(String category) =>
      (select(userFile)..where((tbl) => tbl.category.equals(category))).watch();

  Stream<List<UserFileData>> streamLinkedSillog(String sillogId) =>
      (select(userFile)..where((tbl) => tbl.linkedSillog.equals(sillogId)))
          .watch();

  // // 태그와 파일을 함께 부르는 태그
  // // Join
  // Stream<List<FileWithTagModel>> streamFilesWithTags() {
  //   // 먼저 모든 파일을 불러오는 스트림을 생성
  //   final filesStream = select(userFile).watch();

  //   // rxdart package가 필요
  //   // 중복으로 실행되지 않게 해줌
  //   return filesStream.switchMap((files) {
  //     final idToFiles = {for (var file in files) file.id: file};

  //     final fileIds = idToFiles.keys;

  //     final tagQuery = select(userFileWithTag)
  //         .join([innerJoin(tag, tag.id.equalsExp(userFileWithTag.tagId))])
  //           ..where(userFileWithTag.tagId.isIn(fileIds));

  //     return tagQuery.watch().map(
  //       (rows) {
  //         final idToTags = <int, List<TagData>>{};

  //         for (var row in rows) {
  //           final tags = row.readTable(tag);
  //           final id = row.readTable(userFileWithTag).fileId;

  //           // null 값 처리
  //           idToTags.putIfAbsent(id, () => []).add(tags);
  //         }

  //         return [
  //           for (var id in fileIds)
  //             FileWithTagModel(file: idToFiles[id]!, tag: idToTags[id]!)
  //         ];
  //       },
  //     );
  //   });
  // }

  Future deleteUserFile(UserFileCompanion data) =>
      delete(userFile).delete(data);

  Future deleteUserFileWithID(int id) {
    return (delete(userFile)..where((tbl) => tbl.id.equals(id))).go();
  }

  Future insertUserFile(UserFileCompanion data) => into(userFile).insert(data);

  deleteAllUserFile() {
    try {
      return delete(userFile).go();
    } catch (e) {
      dev.log('Delete All user File error', name: 'db.filedb');
    }
  }

  // Future insertUserFile(UserFileCompanion data) async {
  //   return transaction(() async {
  //     final tags =
  //         fileTag.split(',').length > 0 ? fileTag.split(',') : [fileTag];
  //     final tagIds = [];

  //     for (var fileTag in tags) {
  //       final tagCompanion = TagCompanion(
  //         name: Value(fileTag),
  //       );
  //       // 태그 테이블에 새로운 태그를 추가함
  //       await into(tag).insert(
  //         tagCompanion,
  //         mode: InsertMode.insertOrIgnore,
  //       );

  //       // 같은 값을 불러와서 id를 확인함
  //       final tagInstance = await (select(tag)
  //             ..where((tbl) => tbl.name.equals(fileTag)))
  //           .getSingle();

  //       tagIds.add(tagInstance.id);
  //     }

  //     // 파일에 데이터를 추가함으로써 userFileID를 불러옴
  //     final userFileId = await into(userFile).insert(data);

  //     for (var tagId in tagIds) {
  //       await into(userFileWithTag).insert(UserFileWithTagCompanion(
  //           fileId: Value(userFileId), tagId: Value(tagId)));
  //     }
  //   });
  // }
}
