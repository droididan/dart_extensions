/*
 * Copyright 2020 Idan Ayalon. All rights reserved.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * http://www.apache.org/licenses/LICENSE-2.0
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import 'dart:convert' as convert;

import 'package:http/http.dart' as http;

import 'package:dart_extensions/src/strings.dart';

const _defaultHeaders = {"Content-type": "application/json"};

extension HttpExtensions on String {
  /// Sends an HTTP GET request with the given headers to the given URL, which can
  /// be a [Uri] or a [String].
  Future<dynamic> httpGet() async {
    if (this.isEmptyOrNull) return;

    try {
      final response = await http.get(this);
      return response.statusCode == 200
          ? convert.jsonDecode(response.body)
          : print('Request failed with status: ${response.statusCode}.');
    } on Exception catch (e) {
      return Future.error(e);
    }
  }

  /// Sends an HTTP POST request with the given headers and body to the given URL,
  /// which can be a [Uri] or a [String].
  Future<dynamic> httpPost(String json,
      [Map<String, String> headers = _defaultHeaders]) async {
    if (this.isEmptyOrNull) return;

    try {
      final response = await http.post(this, headers: headers, body: json);
      return response.statusCode == 200
          ? convert.jsonDecode(response.body)
          : print('Request failed with status: ${response.statusCode}.');
    } on Exception catch (e) {
      return Future.error(e);
    }
  }

  /// Sends an HTTP PUT request with the given headers and body to the given URL,
  /// which can be a [Uri] or a [String].
  Future<dynamic> httpPut(String json,
      [Map<String, String> headers = _defaultHeaders]) async {
    if (this.isEmptyOrNull) return;

    try {
      final response = await http.put(this, headers: headers, body: json);
      return response.statusCode == 200
          ? convert.jsonDecode(response.body)
          : print('Request failed with status: ${response.statusCode}.');
    } on Exception catch (e) {
      return Future.error(e);
    }
  }

  /// Sends an HTTP DELETE request with the given headers to the given URL, which
  /// can be a [Uri] or a [String].
  Future<dynamic> httpDelete({Map<String, String> headers}) async {
    if (this.isEmptyOrNull) return;

    try {
      final response = await http.delete(this, headers: headers);
      return response.statusCode == 200
          ? convert.jsonDecode(response.body)
          : print('Request failed with status: ${response.statusCode}.');
    } on Exception catch (e) {
      return Future.error(e);
    }
  }
}
