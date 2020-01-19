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

import 'dart:collection';

class Stack<T> {
  final _list = ListQueue<T>();

  bool get isEmpty => _list.isEmpty;

  bool get isNotEmpty => _list.isNotEmpty;

  push(T element) => _list.addLast(element);

  T pop() {
    final T element = _list.last;
    _list.removeLast();
    return element;
  }

  top() => _list.last;

  List<T> addAll(Iterable elements) {
    _list.addAll(elements);
    return _list.toList();
  }
}
