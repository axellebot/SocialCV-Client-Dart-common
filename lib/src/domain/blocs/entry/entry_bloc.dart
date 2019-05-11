import 'package:social_cv_client_dart_common/blocs.dart';
import 'package:social_cv_client_dart_common/models.dart';

class EntryBloc extends ElementBloc<EntryViewModel, EntryEvent, EntryState> {
  final String _tag = '$EntryBloc';

  @override
  get initialState => EntryUninitialized();

  @override
  Stream<EntryState> mapEventToState(EntryEvent event) async* {
    print('$_tag:$mapEventToState($event)');
    try {
      if (event is EntryInitialized && event.elementId != null) {
        yield* _mapInitializedEventWithElementToState(event);
      } else if (event is EntryInitialized && event.element != null) {
        yield* _mapInitializedEventWithIdToState(event);
      }
    } catch (error) {
      yield EntryFailure(error: error);
    }
  }

  Stream<EntryState> _mapInitializedEventWithElementToState(
      EntryInitialized event) async* {
    print('$_tag:$_mapInitializedEventWithElementToState($event)');
    try {
      yield EntryLoading();

      elementId = event.elementId;
      elementViewModel = event.element;

      yield EntryLoaded(entry: elementViewModel);
    } catch (error) {
      yield EntryFailure(error: error);
    }
  }

  Stream<EntryState> _mapInitializedEventWithIdToState(
      EntryInitialized event) async* {
    print('$_tag:$_mapInitializedEventWithIdToState($event)');
    try {
      yield EntryLoading();

      elementId = event.elementId;
      elementViewModel = await cvRepository.fetchEntry(elementId);

      yield EntryLoaded(entry: elementViewModel);
    } catch (error) {
      yield EntryFailure(error: error);
    }
  }
}
