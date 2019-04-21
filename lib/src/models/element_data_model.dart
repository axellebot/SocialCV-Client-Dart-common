import 'package:meta/meta.dart';
import 'package:social_cv_client_dart_common/src/models/base_data_model.dart';

abstract class ElementDataModel extends BaseDataModel {
  ElementDataModel({
    @required id,
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
