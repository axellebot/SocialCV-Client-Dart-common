import 'package:meta/meta.dart';
import 'package:social_cv_client_dart_common/blocs.dart';
import 'package:social_cv_client_dart_common/models.dart';
import 'package:social_cv_client_dart_common/repositories.dart';

class PartBloc extends ElementBloc<PartViewModel, PartEvent, PartState> {
  final String _tag = '$PartBloc';

  PartBloc({@required CVRepository cvRepository})
      : super(cvRepository: cvRepository);

  /// [_fallBackId] is used if [element] is never assigned and
  /// an [PartRefresh] is dispatched
  String _fallBackId;

  @override
  get initialState => PartUninitialized();

  @override
  Stream<PartState> mapEventToState(PartEvent event) async* {
    print('$_tag:$mapEventToState($event)');
    if (event is PartInitialized) {
      yield* _mapInitializedEventToState(event);
    } else if (event is PartRefresh) {
      yield* _mapRefreshEventToState(event);
    }
  }

  /// Map [PartInitialized] to [PartState]
  ///
  /// ```dart
  /// yield* _mapInitializedEventToState(event);
  /// ```
  Stream<PartState> _mapInitializedEventToState(PartInitialized event) async* {
    print('$_tag:$_mapInitializedEventToState($event)');
    try {
      yield PartLoading();

      if (event.elementId != null) {
        _fallBackId = event.elementId;
        element = await await cvRepository.fetchPart(event.elementId);
      } else if (event.element != null) {
        _fallBackId = event.element.id;
        element = event.element;
      }

      yield PartLoaded(part: element);
    } catch (error) {
      yield PartFailure(error: error);
    }
  }

  /// Map [PartRefresh] to [PartState]
  ///
  /// ```dart
  /// yield* _mapRefreshEventToState(event);
  /// ```
  Stream<PartState> _mapRefreshEventToState(PartRefresh event) async* {
    print('$_tag:$_mapRefreshEventToState($event)');
    try {
      yield PartLoading();

      element = await cvRepository.fetchPart(
        element?.id ?? _fallBackId,
        force: true,
      );

      _fallBackId = element.id;

      yield PartLoaded(part: element);
    } catch (error) {
      yield PartFailure(error: error);
    }
  }
}
