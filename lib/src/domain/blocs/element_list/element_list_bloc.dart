import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:social_cv_client_dart_common/models.dart';
import 'package:social_cv_client_dart_common/repositories.dart';
import 'package:social_cv_client_dart_common/src/ui/models/cursor_model.dart';

/// Business Logic Component for profile element list
abstract class ElementListBloc<T extends ElementViewModel, E, S>
    extends Bloc<E, S> {
  final String _tag = '$ElementListBloc<$T>';

  final CVRepository cvRepository;

  String parentId;
  List<T> elements;
  String ownerId;

  Cursor cursor;

  /// TODO: Add filter
  /// TODO: Add sort

  ElementListBloc({@required this.cvRepository})
      : assert(cvRepository != null, 'No $CVRepository given'),
        super();
}
