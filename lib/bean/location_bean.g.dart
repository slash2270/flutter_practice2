// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LatLngBean _$LatLngFromJson(Map<String, dynamic> json) => LatLngBean(
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
    );

Map<String, dynamic> _$LatLngToJson(LatLngBean instance) => <String, dynamic>{
      'lat': instance.lat,
      'lng': instance.lng,
    };

RegionBean _$RegionFromJson(Map<String, dynamic> json) => RegionBean(
      coords: LatLngBean.fromJson(json['coords'] as Map<String, dynamic>),
      id: json['id'] as String,
      name: json['name'] as String,
      zoom: (json['zoom'] as num).toDouble(),
    );

Map<String, dynamic> _$RegionToJson(RegionBean instance) => <String, dynamic>{
      'coords': instance.coords,
      'id': instance.id,
      'name': instance.name,
      'zoom': instance.zoom,
    };

Office _$OfficeFromJson(Map<String, dynamic> json) => Office(
      address: json['address'] as String,
      id: json['id'] as String,
      image: json['image'] as String,
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
      name: json['name'] as String,
      phone: json['phone'] as String,
      region: json['region'] as String,
    );

Map<String, dynamic> _$OfficeToJson(Office instance) => <String, dynamic>{
      'address': instance.address,
      'id': instance.id,
      'image': instance.image,
      'lat': instance.lat,
      'lng': instance.lng,
      'name': instance.name,
      'phone': instance.phone,
      'region': instance.region,
    };

LocationsBean _$LocationsFromJson(Map<String, dynamic> json) => LocationsBean(
      offices: (json['offices'] as List<dynamic>)
          .map((e) => Office.fromJson(e as Map<String, dynamic>))
          .toList(),
      regions: (json['regions'] as List<dynamic>)
          .map((e) => RegionBean.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LocationsToJson(LocationsBean instance) => <String, dynamic>{
      'offices': instance.offices,
      'regions': instance.regions,
    };
