import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:social_cv_client_dart_common/src/events/element_list_event.dart';
import 'package:social_cv_client_dart_common/src/models/element_data_model.dart';
import 'package:social_cv_client_dart_common/src/models/entry_data_model.dart';
import 'package:social_cv_client_dart_common/src/models/group_data_model.dart';
import 'package:social_cv_client_dart_common/src/models/part_data_model.dart';
import 'package:social_cv_client_dart_common/src/models/profile_data_model.dart';
import 'package:social_cv_client_dart_common/src/models/user_data_model.dart';
import 'package:social_cv_client_dart_common/src/repositories/cv_repository.dart';
import 'package:social_cv_client_dart_common/src/states/element_list_state.dart';

class ElementListBloc<T extends ElementDataModel>
    extends Bloc<ElementListEvent, ElementListState> {
  final String _TAG = 'ElementListBloc<$T>';

  ElementListBloc({@required this.cvRepository}) : super();

  final CVRepository cvRepository;

  @override
  ElementListState get initialState => ElementListUninitialized();

  @override
  Stream<ElementListState> mapEventToState(ElementListEvent event) async* {
    print('$_TAG:mapEventToState($event)');
    try {
      if (event is ElementListFetch<T>) {
        yield ElementListLoading();

        dynamic response;

        if (T == UserDataModel) {
          // TODO : Add fetching Users
        } else if (T == ProfileDataModel) {
          response = await cvRepository.fetchProfiles(
            limit: event.limit,
            offset: event.offset,
          );
        } else if (T == PartDataModel) {
          response = await cvRepository.fetchParts(
            limit: event.limit,
            offset: event.offset,
          );
        } else if (T == GroupDataModel) {
          response = await cvRepository.fetchGroups(
            limit: event.limit,
            offset: event.offset,
          );
        } else if (T == EntryDataModel) {
          response = await cvRepository.fetchEntries(
            limit: event.limit,
            offset: event.offset,
          );
        }

        yield ElementListLoaded(elements: response as List<T>);
      } else if (event is ElementListFetchFromParent) {
        yield ElementListLoading();

        dynamic response;

        if (T == ProfileDataModel) {
          // TODO : Add fetching Profiles from User
        } else if (T == PartDataModel) {
          response = await cvRepository.fetchPartsFromProfile(
            profileId: event.parentId,
            limit: event.limit,
            offset: event.offset,
          );
        } else if (T == GroupDataModel) {
          response = await cvRepository.fetchGroupsFromPart(
            partId: event.parentId,
            limit: event.limit,
            offset: event.offset,
          );
        } else if (T == EntryDataModel) {
          response = await cvRepository.fetchEntriesFromGroup(
            groupId: event.parentId,
            limit: event.limit,
            offset: event.offset,
          );
        }

        yield ElementListLoaded(elements: response as List<T>);
      }
    } catch (error) {
      yield ElementListFailure(error: error);
    }
  }
}
