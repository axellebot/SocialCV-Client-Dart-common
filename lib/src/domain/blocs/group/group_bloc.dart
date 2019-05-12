import 'package:meta/meta.dart';
import 'package:social_cv_client_dart_common/blocs.dart';
import 'package:social_cv_client_dart_common/models.dart';
import 'package:social_cv_client_dart_common/repositories.dart';

class GroupBloc extends ElementBloc<GroupViewModel, GroupEvent, GroupState> {
  final String _tag = '$GroupBloc';

  GroupBloc({@required CVRepository cvRepository})
      : super(cvRepository: cvRepository);

  /// [_fallBackId] is used if [element] is never assigned and
  /// an [GroupRefresh] is dispatched
  String _fallBackId;

  @override
  get initialState => GroupUninitialized();

  @override
  Stream<GroupState> mapEventToState(GroupEvent event) async* {
    print('$_tag:$mapEventToState($event)');
    if (event is GroupInitialized) {
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
        _fallBackId = event.elementId;
        element = await await cvRepository.fetchGroup(event.elementId);
      } else if (event.element != null) {
        _fallBackId = event.element.id;
        element = event.element;
      }

      yield GroupLoaded(group: element);
    } catch (error) {
      yield GroupFailure(error: error);
    }
  }

  Stream<GroupState> _mapRefreshEventToState(GroupRefresh event) async* {
    print('$_tag:$_mapRefreshEventToState($event)');
    try {
      yield GroupLoading();

      element = await cvRepository.fetchGroup(
        element?.id ?? _fallBackId,
        force: true,
      );

      _fallBackId = element.id;

      yield GroupLoaded(group: element);
    } catch (error) {
      yield GroupFailure(error: error);
    }
  }
}
