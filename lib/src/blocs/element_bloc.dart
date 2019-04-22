import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:social_cv_client_dart_common/src/events/element_event.dart';
import 'package:social_cv_client_dart_common/src/models/element_data_model.dart';
import 'package:social_cv_client_dart_common/src/models/entry_data_model.dart';
import 'package:social_cv_client_dart_common/src/models/group_data_model.dart';
import 'package:social_cv_client_dart_common/src/models/part_data_model.dart';
import 'package:social_cv_client_dart_common/src/models/profile_data_model.dart';
import 'package:social_cv_client_dart_common/src/models/user_data_model.dart';
import 'package:social_cv_client_dart_common/src/repositories/cv_repository.dart';
import 'package:social_cv_client_dart_common/src/states/element_state.dart';

class ElementBloc<T extends ElementDataModel>
    extends Bloc<ElementEvent, ElementState> {
  final String _TAG = 'ElementBloc<$T>';

  ElementBloc({@required this.cvRepository}) : super();

  final CVRepository cvRepository;

  @override
  ElementState get initialState => ElementUninitialized();

  @override
  Stream<ElementState> mapEventToState(ElementEvent event) async* {
    print('$_TAG:mapEventToState($event)');
    try {
      if (event is ElementFetch<T>) {
        yield ElementLoading();

        T response;

        if (T == UserDataModel) {
          //response = await cvRepository.fetchUser(event.id) as T;
        } else if (T == ProfileDataModel) {
          response = (await cvRepository.fetchProfile(event.id)) as T;
        } else if (T == PartDataModel) {
          response = (await cvRepository.fetchPart(event.id)) as T;
        } else if (T == GroupDataModel) {
          response = (await cvRepository.fetchGroup(event.id)) as T;
        } else if (T == EntryDataModel) {
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
