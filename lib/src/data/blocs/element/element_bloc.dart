import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:social_cv_client_dart_common/blocs.dart';
import 'package:social_cv_client_dart_common/models.dart';
import 'package:social_cv_client_dart_common/repositories.dart';

class ElementBloc<T extends ElementViewModel>
    extends Bloc<ElementEvent, ElementState> {
  final String _TAG = 'ElementBloc<$T>';

  final CVRepository cvRepository;

  ElementBloc({@required this.cvRepository})
      : assert(cvRepository != null, 'Missing CV Repository'),
        super();

  @override
  ElementState get initialState => ElementUninitialized();

  @override
  Stream<ElementState> mapEventToState(ElementEvent event) async* {
    print('$_TAG:mapEventToState($event)');
    try {
      if (event is ElementFetch<T>) {
        yield ElementLoading();

        T response;

        if (T == UserViewModel) {
          //response = await cvRepository.fetchUser(event.id) as T;
        } else if (T == ProfileViewModel) {
          response = (await cvRepository.fetchProfile(event.id)) as T;
        } else if (T == PartViewModel) {
          response = (await cvRepository.fetchPart(event.id)) as T;
        } else if (T == GroupViewModel) {
          response = (await cvRepository.fetchGroup(event.id)) as T;
        } else if (T == EntryViewModel) {
          response = (await cvRepository.fetchEntry(event.id)) as T;
        }
        // TODO : Remove delay
        Future.delayed(Duration(seconds: 5));
        yield ElementLoaded<T>(element: response);
      }
    } catch (error) {
      yield ElementFailure(error: error);
    }
  }
}
