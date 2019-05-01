import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:social_cv_client_dart_common/blocs.dart';
import 'package:social_cv_client_dart_common/models.dart';
import 'package:social_cv_client_dart_common/repositories.dart';

class ElementListBloc<T extends ElementViewModel>
    extends Bloc<ElementListEvent, ElementListState> {
  final String _TAG = 'ElementListBloc<$T>';

  final CVRepository cvRepository;

  ElementListBloc({@required this.cvRepository})
      : assert(cvRepository != null, 'Missing CV Repository'),
        super();

  @override
  ElementListState get initialState => ElementListUninitialized();

  @override
  Stream<ElementListState> mapEventToState(ElementListEvent event) async* {
    print('$_TAG:mapEventToState($event)');
    try {
      if (event is ElementListFetch<T>) {
        yield ElementListLoading();

        dynamic response;

        if (T == UserViewModel) {
          // TODO : Add fetching Users
        } else if (T == ProfileViewModel) {
          response = await cvRepository.fetchProfiles(
            limit: event.limit,
            offset: event.offset,
          );
        } else if (T == PartViewModel) {
          response = await cvRepository.fetchParts(
            limit: event.limit,
            offset: event.offset,
          );
        } else if (T == GroupViewModel) {
          response = await cvRepository.fetchGroups(
            limit: event.limit,
            offset: event.offset,
          );
        } else if (T == EntryViewModel) {
          response = await cvRepository.fetchEntries(
            limit: event.limit,
            offset: event.offset,
          );
        }

        yield ElementListLoaded(elements: response as List<T>);
      } else if (event is ElementListFetchFromParent) {
        yield ElementListLoading();

        dynamic response;

        if (T == ProfileViewModel) {
          response = await cvRepository.fetchPartsFromUser(
            userId: event.parentId,
          );
          // TODO : Add fetching Profiles from User
        } else if (T == PartViewModel) {
          response = await cvRepository.fetchPartsFromProfile(
            profileId: event.parentId,
            limit: event.limit,
            offset: event.offset,
          );
        } else if (T == GroupViewModel) {
          response = await cvRepository.fetchGroupsFromPart(
            partId: event.parentId,
            limit: event.limit,
            offset: event.offset,
          );
        } else if (T == EntryViewModel) {
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
