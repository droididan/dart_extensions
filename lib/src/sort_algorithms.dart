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
extension SearchAlgorithmExtensions on List<int> {
  List<int> quickSort([int? left, int? right]) {
    var list = this;
    if ((left??0) >= (right??0)) return [-1];
    int pivot = left!, i = left, j = right!, direction = -1, temp = 0;
    while (i < j) {
      if (direction == -1) {
        if (list[j] < list[pivot]) {
          temp = list[j];
          list[j] = list[pivot];
          list[pivot] = temp;
          pivot = j;
          direction = 1;
        } else
          j--;
      }
      if (direction == 1) {
        if (list[i] > list[pivot]) {
          temp = list[i];
          list[i] = list[pivot];
          list[pivot] = temp;
          pivot = i;
          direction = -1;
        } else
          i++;
      }
    }
    quickSort(left, i);
    quickSort(i + 1, right);

    return list;
  }
}
