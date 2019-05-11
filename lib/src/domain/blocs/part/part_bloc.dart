import 'package:social_cv_client_dart_common/blocs.dart';
import 'package:social_cv_client_dart_common/models.dart';

class PartBloc extends ElementBloc<PartViewModel, PartEvent, PartState> {
  final String _tag = '$PartBloc';

  @override
  get initialState => PartUninitialized();

  @override
  Stream<PartState> mapEventToState(PartEvent event) async* {
    print('$_tag:$mapEventToState($event)');
    try {
      if (event is PartInitialized && event.elementId != null) {
        yield* _mapInitializedEventWithElementToState(event);
      } else if (event is PartInitialized && event.element != null) {
        yield* _mapInitializedEventWithIdToState(event);
      }
    } catch (error) {
      yield PartFailure(error: error);
    }
  }

  Stream<PartState> _mapInitializedEventWithElementToState(
      PartInitialized event) async* {
    try {
      yield PartLoading();

      elementId = event.elementId;
      elementViewModel = event.element;

      yield PartLoaded(part: elementViewModel);
    } catch (error) {
      yield PartFailure(error: error);
    }
  }

  Stream<PartState> _mapInitializedEventWithIdToState(
      PartInitialized event) async* {
    try {
      yield PartLoading();

      elementId = event.elementId;
      elementViewModel = await cvRepository.fetchPart(elementId);

      yield PartLoaded(part: elementViewModel);
    } catch (error) {
      yield PartFailure(error: error);
    }
  }
}
