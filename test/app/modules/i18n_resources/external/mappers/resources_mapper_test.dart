import 'package:flutter_test/flutter_test.dart';
import 'package:pixlog_challenge/app/modules/i18n_resources/domain/entity/resource_entity.dart';
import 'package:pixlog_challenge/app/modules/i18n_resources/external/mappers/resources_mapper.dart';

import '../../../../../stubs/resources_response.dart';

void main() async {
  test('Should return a list with 1 resource', () async {
    final list = [
      {
        "resource": {
          "created_at": "2021-08-14T20:49:32Z",
          "updated_at": "2021-08-14T20:49:32Z",
          "resource_id": "textfile.combineOrders",
          "module_id": "GreenMileTrack",
          "value": "Merge orders in the same stop",
          "language_id": "en-g"
        }
      },
    ];

    final result = ResourcesMapper.fromList(list);
    expect(result, [
      ResourceEntity(
        createdAt: DateTime.parse("2021-08-14T20:49:32Z"),
        updatedAt: DateTime.parse("2021-08-14T20:49:32Z"),
        resourceId: "textfile.combineOrders",
        moduleId: "GreenMileTrack",
        value: "Merge orders in the same stop",
        languageId: "en-g",
      ),
    ]);
  });

  test('Should return a list with all resouces entities', () async {
    final result = ResourcesMapper.fromList(resourcesResponse);
    expect(result.length, resourcesResponse.length);
  });

  test('Should return default date when resource map createdAt key is null', () async {
    final list = [
      {
        "resource": {
          /* "created_at": "2021-08-14T20:49:32Z", */
          "updated_at": "2021-08-14T20:49:32Z",
          "resource_id": "textfile.combineOrders",
          "module_id": "GreenMileTrack",
          "value": "Merge orders in the same stop",
          "language_id": "en-g"
        }
      },
    ];
    final result = ResourcesMapper.fromList(list);
    expect(result[0].createdAt, DateTime.parse("1900-01-01T00:00:00Z"));
  });

  test('Should return default date when resource map updatedAt key is null', () async {
    final list = [
      {
        "resource": {
          "created_at": "2021-08-14T20:49:32Z",
          /* "updated_at": "2021-08-14T20:49:32Z", */
          "resource_id": "textfile.combineOrders",
          "module_id": "GreenMileTrack",
          "value": "Merge orders in the same stop",
          "language_id": "en-g"
        }
      },
    ];
    final result = ResourcesMapper.fromList(list);
    expect(result[0].updatedAt, DateTime.parse("1900-01-01T00:00:00Z"));
  });
}
