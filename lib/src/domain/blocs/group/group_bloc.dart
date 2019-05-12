import 'package:meta/meta.dart';
import 'package:social_cv_client_dart_common/blocs.dart';
import 'package:social_cv_client_dart_common/models.dart';
import 'package:social_cv_client_dart_common/repositories.dart';

class GroupBloc extends ElementBloc<GroupViewModel, GroupEvent, GroupState> {
  final String _tag = '$PartBloc';

  GroupBloc({@required CVRepository cvRepository})
      : super(cvRepository: cvRepository);

  @override
  get initialState => GroupUninitialized();

  @override
  Stream<GroupState> mapEventToState(GroupEvent event) async* {
    print('$_tag:$mapEventToState($event)');
    if (event is GroupInitialized && event.elementId != null) {
      yield* _mapInitializedEventToState(event);
    } else if (event is GroupRefresh) {
      yield* _mapRefreshEventToState(event);
    }
  }

  Stream<GroupState> _mapInitializedEventToState(
      GroupInitialized event) async* {
    print('$_tag:$_mapInitializedEventToState($event)');
    try {
      yield GroupLoading();

      if (event.elementId != null) {
        element = await _fetchGroup(event.elementId);
      } else if (event.element != null) {
        element = event.element;
      }

      yield GroupLoaded(group: element);
    } catch (error) {
      yield GroupFailure(error: error);
    }
  }

  Stream<GroupState> _mapRefreshEventToState(GroupRefresh event) async* {
    try {
      yield GroupLoading();

      element = await _fetchGroup(element?.id);

      yield GroupLoaded(group: element);
    } catch (error) {
      yield GroupFailure(error: error);
    }
  }

  /// [_fallBackId] is used if [element] is never assigned and
  /// an [GroupRefresh] is dispatched
  String _fallBackId;

  Future<GroupViewModel> _fetchGroup(String groupId) async {
    if (groupId == null) groupId = _fallBackId;
    _fallBackId = groupId;
    return await cvRepository.fetchGroup(groupId);
  }
}
