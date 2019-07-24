import 'package:meta/meta.dart';
import 'package:social_cv_client_dart_common/domain.dart';
import 'package:social_cv_client_dart_common/src/data/models/base_model.dart';

abstract class ElementDataModel extends BaseDataModel implements ElementEntity {
  ElementDataModel({
    @required String id,
    DateTime createdAt,
    DateTime updatedAt,
    int version,
  }) : super(
          id: id,
          createdAt: createdAt,
          updatedAt: updatedAt,
          version: version,
        );
}
