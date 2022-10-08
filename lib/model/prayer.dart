import 'dart:ui';

class Prayer {
  late String name;
  late String time;
  late int id;

  Prayer({
    required this.name,
    required this.time,
    required this.id,
  });
}
  class Meta {
    final double? latitude;
    final double? longitude;
    final String? timezone;
    final String? latitudeAdjustmentMethod;
    final String? midnightMode;
    final String? school;

    Meta({
      this.latitude,
      this.longitude,
      this.timezone,
      this.latitudeAdjustmentMethod,
      this.midnightMode,
      this.school,
    });


    factory Meta.fromJson(Map<String, dynamic> json) =>
        Meta(
          latitude: json["latitude"],
          longitude: json["longitude"],
          timezone: json["timezone"],
          latitudeAdjustmentMethod: json["latitudeAdjustmentMethod"],
          midnightMode: json["midnightMode"],
          school: json["school"],
        );
//

  }