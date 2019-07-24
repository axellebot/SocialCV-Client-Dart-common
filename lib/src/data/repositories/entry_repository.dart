import 'dart:async';

import 'package:meta/meta.dart';
import 'package:social_cv_client_dart_common/data.dart';
import 'package:social_cv_client_dart_common/domain.dart';
import 'package:social_cv_client_dart_common/presentation.dart';

class ImplEntryRepository extends EntryRepository {
  final String _tag = '$ImplEntryRepository';

  final EntryDataStoreFactory factory;

  ImplEntryRepository({@required this.factory}) : assert(factory != null);

  @override
  FutureOr<EntryEntity> getById(
    String id, {
    bool force = false,
  }) async {
    print('$_tag:getById($id)');
    assert(id != null);

    EntryDataModel dataModel;

    if (!force) dataModel = await factory.memoryDataStore.getEntry(id);

    if (dataModel == null) {
      dataModel = await factory.cloudDataStore.getEntry(id);
      factory.memoryDataStore.setEntry(dataModel);
    }

    return dataModel;
  }

  @override
  FutureOr<List<EntryEntity>> getList({
    /// TODO: Add filters
    /// TODO: Add sort
    Cursor cursor = const Cursor(),
  }) async {
    print('$_tag:getList');

    final dataModels = await factory.cloudDataStore.getEntries(
      cursor: cursor,
    );

    // Store in RAM
    dataModels.map(factory.memoryDataStore.setEntry);

    return dataModels;
  }

  @override
  FutureOr<List<EntryEntity>> getEntriesFromGroup(
    String groupId, {

    /// TODO: Add filters
    /// TODO: Add sort
    Cursor cursor = const Cursor(),
  }) async {
    print('$_tag:getEntriesFromGroup($groupId)');
    assert(groupId != null);

    final dataModels = await factory.cloudDataStore.getEntriesFromGroup(
      groupId,
      cursor: cursor,
    );

    // Store in RAM
    dataModels.map(factory.memoryDataStore.setEntry);

    return dataModels;
  }

  @override
  FutureOr<List<EntryEntity>> getEntriesFromUser(
    String userId, {

    /// TODO: Add filters
    /// TODO: Add sort
    Cursor cursor = const Cursor(),
  }) async {
    print('$_tag:getEntriesFromUser($userId)');
    assert(userId != null);

    final dataModels = await factory.cloudDataStore.getEntriesFromUser(
      userId,
      cursor: cursor,
    );

    // Store in RAM
    dataModels.map(factory.memoryDataStore.setEntry);

    return dataModels;
  }

  @override
  String toString() => '$runtimeType{ '
      'factory: $factory'
      ' }';
}