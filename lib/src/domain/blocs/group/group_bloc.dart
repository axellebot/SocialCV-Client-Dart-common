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
    try {
      if (event is GroupInitialized && event.elementId != null) {
        yield* _mapInitializedEventWithElementToState(event);
      } else if (event is GroupInitialized && event.element != null) {
        yield* _mapInitializedEventWithIdToState(event);
      }
    } catch (error) {
      yield GroupFailure(error: error);
    }
  }

  Stream<GroupState> _mapInitializedEventWithElementToState(
      GroupInitialized event) async* {
    try {
      yield GroupLoading();

      elementId = event.elementId;
      elementViewModel = event.element;

      yield GroupLoaded(group: elementViewModel);
    } catch (error) {
      yield GroupFailure(error: error);
    }
  }

  Stream<GroupState> _mapInitializedEventWithIdToState(
      GroupInitialized event) async* {
    try {
      yield GroupLoading();

      elementId = event.elementId;
      elementViewModel = await cvRepository.fetchGroup(elementId);

      yield GroupLoaded(group: elementViewModel);
    } catch (error) {
      yield GroupFailure(error: error);
    }
  }
}
