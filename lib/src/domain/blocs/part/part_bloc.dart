import 'package:meta/meta.dart';
import 'package:social_cv_client_dart_common/blocs.dart';
import 'package:social_cv_client_dart_common/models.dart';
import 'package:social_cv_client_dart_common/repositories.dart';

class PartBloc extends ElementBloc<PartViewModel, PartEvent, PartState> {
  final String _tag = '$PartBloc';

  PartBloc({@required CVRepository cvRepository})
      : super(cvRepository: cvRepository);

  @override
  get initialState => PartUninitialized();

  @override
  Stream<PartState> mapEventToState(PartEvent event) async* {
    print('$_tag:$mapEventToState($event)');
    try {
      if (event is PartInitialized) {
        yield* _mapInitializedEventToState(event);
      } else if (event is PartRefresh) {
        yield* _mapRefreshEventToState(event);
      }
    } catch (error) {
      yield PartFailure(error: error);
    }
  }

  Stream<PartState> _mapInitializedEventToState(PartInitialized event) async* {
    print('$_tag:$_mapInitializedEventToState($event)');
    try {
      yield PartLoading();

      if (event.elementId != null) {
        element = await _fetchPart(event.elementId);
      } else if (event.element != null) {
        element = event.element;
      }

      yield PartLoaded(part: element);
    } catch (error) {
      yield PartFailure(error: error);
    }
  }

  Stream<PartState> _mapRefreshEventToState(PartRefresh event) async* {
    try {
      yield PartLoading();

      element = await _fetchPart(element?.id);

      yield PartLoaded(part: element);
    } catch (error) {
      yield PartFailure(error: error);
    }
  }

  /// [_fallBackId] is used if [element] is never assigned and
  /// an [PartRefresh] is dispatched
  String _fallBackId;

  Future<PartViewModel> _fetchPart(String partId) async {
    if (partId == null) partId = _fallBackId;
    _fallBackId = partId;
    return await cvRepository.fetchPart(partId);
  }
}
