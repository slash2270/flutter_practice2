/*
 * Copyright 2019 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';

part 'location_bean.g.dart';

@JsonSerializable()
class LatLngBean {
  LatLngBean({
    this.lat,
    this.lng,
  });

  factory LatLngBean.fromJson(Map<String, dynamic> json) => _$LatLngBeanFromJson(json);
  Map<String, dynamic> toJson() => _$LatLngBeanToJson(this);

  final double? lat;
  final double? lng;
}

@JsonSerializable()
class RegionBean {
  RegionBean({
    required this.coords,
    required this.id,
    required this.name,
    required this.zoom,
  });

  factory RegionBean.fromJson(Map<String, dynamic> json) => _$RegionBeanFromJson(json);
  Map<String, dynamic> toJson() => _$RegionBeanToJson(this);

  final LatLngBean coords;
  final String id;
  final String name;
  final double zoom;
}

@JsonSerializable()
class Office {
  Office({
    required this.address,
    required this.id,
    required this.image,
    required this.lat,
    required this.lng,
    required this.name,
    required this.phone,
    required this.region,
  });

  factory Office.fromJson(Map<String, dynamic> json) => _$OfficeFromJson(json);
  Map<String, dynamic> toJson() => _$OfficeToJson(this);

  final String address;
  final String id;
  final String image;
  final double lat;
  final double lng;
  final String name;
  final String phone;
  final String region;
}

@JsonSerializable()
class LocationsBean {
  LocationsBean({
    required this.offices,
    required this.regions,
  });

  factory LocationsBean.fromJson(Map<String, dynamic> json) => _$LocationsBeanFromJson(json);
  Map<String, dynamic> toJson() => _$LocationsBeanToJson(this);

  final List<Office> offices;
  final List<RegionBean> regions;
}

Future<LocationsBean> getGoogleOffices() async {
  const googleLocationsURL = 'https://about.google/static/data/locations.json';

  // Retrieve the locations of Google offices
  try {
    final response = await http.get(Uri.parse(googleLocationsURL));
    if (response.statusCode == 200) {
      return LocationsBean.fromJson(
          json.decode(response.body) as Map<String, dynamic>);
    }
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
  }

  // Fallback for when the above HTTP request fails.
  return LocationsBean.fromJson(
    json.decode(
      await rootBundle.loadString('assets/locations.json'),
    ) as Map<String, dynamic>,
  );
}