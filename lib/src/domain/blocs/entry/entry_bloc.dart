import 'package:meta/meta.dart';
import 'package:social_cv_client_dart_common/blocs.dart';
import 'package:social_cv_client_dart_common/models.dart';
import 'package:social_cv_client_dart_common/repositories.dart';

class EntryBloc extends ElementBloc<EntryViewModel, EntryEvent, EntryState> {
  final String _tag = '$EntryBloc';

  EntryBloc({@required CVRepository cvRepository})
      : super(cvRepository: cvRepository);

  /// [_fallBackId] is used if [element] is never assigned and
  /// an [EntryRefresh] is dispatched
  String _fallBackId;

  @override
  get initialState => EntryUninitialized();

  @override
  Stream<EntryState> mapEventToState(EntryEvent event) async* {
    print('$_tag:$mapEventToState($event)');
    if (event is EntryInitialized) {
      yield* _mapInitializedEventToState(event);
    } else if (event is EntryRefresh) {
      yield* _mapRefreshEventToState(event);
    }
  }

  Stream<EntryState> _mapInitializedEventToState(
      EntryInitialized event) async* {
    print('$_tag:$_mapInitializedEventToState($event)');
    try {
      yield EntryLoading();

      if (event.elementId != null) {
        _fallBackId = event.elementId;
        element = await await cvRepository.fetchEntry(event.elementId);
      } else if (event.element != null) {
        _fallBackId = event.element.id;
        element = event.element;
      }

      yield EntryLoaded(entry: element);
    } catch (error) {
      yield EntryFailure(error: error);
    }
  }

  Stream<EntryState> _mapRefreshEventToState(EntryRefresh event) async* {
    print('$_tag:$_mapRefreshEventToState($event)');
    try {
      yield EntryLoading();

      element = await cvRepository.fetchEntry(
        element?.id ?? _fallBackId,
        force: true,
      );

      _fallBackId = element.id;

      yield EntryLoaded(entry: element);
    } catch (error) {
      yield EntryFailure(error: error);
    }
  }
}
