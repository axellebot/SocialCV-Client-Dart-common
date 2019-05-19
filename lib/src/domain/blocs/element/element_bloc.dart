import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:social_cv_client_dart_common/models.dart';
import 'package:social_cv_client_dart_common/repositories.dart';

/// Business Logic Component for profile elements
abstract class ElementBloc<T extends ElementViewModel, E, S>
    extends Bloc<E, S> {
  final String _tag = '$ElementBloc<$T>';

  final CVRepository cvRepository;

  T element;

  ElementBloc({@required this.cvRepository})
      : assert(cvRepository != null, 'No $CVRepository given'),
        super();
}
