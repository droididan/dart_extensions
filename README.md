  
[![](https://img.shields.io/badge/build-0.1.7-green)](https://github.com/droididan/dart_extentions)   ![](https://img.shields.io/badge/Code%20Coverage-96%25-green) ![](https://img.shields.io/badge/Bitrise-Pass-green)  
  
### Resources:  
- [Extensions Full List](https://github.com/droididan/dart_extensions/blob/master/FEATURELIST.md)  
- [Change Log](https://github.com/droididan/dart_extensions/blob/master/CHANGELOG.md)  

  
Why Method Extensions? When you’re using someone else’s API or when you implement a library that’s widely used, it’s often impractical or impossible to change the API. But you might still want to add some functionality.  
  
  *let me know if you want something specific or you found a bug at bar.idan@gmail.com*  
## Let get started 💪🏻  
  
1. Go to `pubspec.yaml` 
2. add a dart_extensions and replace `[version]` with the latest version:  
  
```dart  
dependencies:  
 dart_extensions: ^[version]
 ```
  
3. click the packages get button or *flutter pub get*  

## Http Extensions

### .httpGet()
Sends an HTTP GET request with the given headers to the given URL
```dart
final json = await "https://jsonplaceholder.typicode.com/posts".httpGet();
```
*result:*
```json
[
  {
    "userId": 1,
    "id": 1,
    "title": "sunt aut facere",
    "body": "quia et suscipit"
  },
  {
    "userId": 1,
    "id": 2,
    "title": "qui est esse",
    "body": "dolor beatae ea dolores neque"
  },
]
```

*usage with then:*
```dart
"https://jsonplaceholder.typicode.com/posts".httpGet().then((result) {
          print(result);
       }).catchError((e) => print(e));
```

### .httpPost()
Sends an HTTP POST request with the given headers and body to the given URL which can be a [Uri] or a [String].
```dart
String json = '{"title": "Hello", "body": "body text", "userId": 1}';
final json = await "https://jsonplaceholder.typicode.com/posts".httpPost(json);
```

for more examples (put, delete) See [http.dart](https://github.com/droididan/dart_extentions/blob/master/lib/http.dart) 

## Iterable Extensions

### .find()
Returns the first element matching the given predicate, or `null` if element wasn't found.
```dart
final users = [User(22, "Kasey"), User(23, "Jadn"), User(22, "Rene"), User(32, "Aden")]; 

users.find((u) => u.name == "Rene") // User(22, "Rene")
```

### .chunks()
Splits the Iterable into chunks of the specified `size`
```dart
[1, 2, 3, 4, 5, 6, 7, 8, 9, 10].chunks(3)) 
```
*result*
```dart
([1, 2, 3], [4, 5, 6], [7, 8, 9], [10])
```

### .filter() 
 Returns a list containing only elements matching the given predicate, the return type will be `List`,
 unlike the `where` operator that return `Iterator`,  also it filters null.
```dart
final users = [User(22, "Kasey"), User(23, "Jadn"), User(22, "Rene"), User(32, "Aden")]; 
final filtered = users.filter((u) => u.name == "Kasey"); // [User(22, "Kasey")] <- Type List<User>

final listWithNull = [null, User(23, "Jadn"), User(22, "Rene"), User(32, "Aden")];
final filtered = listWithNull.filter((u) => u.name == "Jadn"); // [User(23, "Jadn")]
```

### .filterNot() 
 Returns a list containing only not the elements matching the given predicate, the return type will be `List`,
 unlike the `where` operator that return `Iterator`,  also it filters null.
```dart
final users = [User(22, "Kasey"), User(23, "Jadn"), User(22, "Rene"), User(32, "Aden")]; 
final filtered = users.filterNot((u) => u.name == "Kasey"); // [User(23, "Jadn"), User(22, "Rene"), User(32, "Aden")] <- Type List<User>

final listWithNull = [null, User(23, "Jadn"), User(22, "Rene"), User(32, "Aden")];
final filtered = listWithNull.filterNot((u) => u.name == "Jadn"); // [User(22, "Rene"), User(32, "Aden")]
```

### .takeOnly() 
Returns a list containing first [n] elements.
```dart
[1, 2, 3, 4].takeOnly(1) // [1]
```

### .drop() 
Returns a list containing all elements except first [n] elements.
```dart
[1, 2, 3, 4].drop(1) // [2, 3, 4]
```



### .forEachIndexed()
Performs the given action on each element on iterable, providing sequential `index` with the `element`.
```dart
["red","green","blue"].forEachIndexed((item, index) { 
	print("$item, $index"); 
}); // 0: red // 1: green // 2: blue```  
```

### .sortedDescending()  
Returns a new list with all elements sorted according to descending natural sort order.
```dart  
var list = [1,2,3,4,5];  
final descendingList = list.sortedDescending();  
print(descendingList); // [5, 4, 3, 2, 1]
```  
  
### .count()  
Return a number of the existing elements by a specific predicate
```dart  
final users = [User(33, "Miki"), User(45, "Anna"), User(19, "Amit")];  
  
final aboveAgeTwenty = users.count((user) => user.age > 20);  
print(aboveAgeTwenty); // 2
```

### .associate()  
Creates a Map instance in which the keys and values are computed from the iterable.
```dart  
final users = [User(33, "Miki"), User(45, "Anna"), User(19, "Amit")];  

users.associate((k) => k.name, (e) => e.age) // 'Miki': 33, 'Anna': 45, 'Amit': 19}
```

### .concatWithMultipleList()  
Return a list concatenates the output of the current list and multiple iterables.
```dart  
  final listOfLists = [
        [5, 6, 7],
        [8, 9, 10]
      ];
  [1, 2, 3, 4].concatWithMultipleList(listOfLists); 
  
  // [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
```
  
### .distinctBy()  
Returns a list containing only the elements from given collection having distinct keys.
```dart  
// example 1
final users = ["Zack", "Ian", "Ronit"];  
users.distinctBy((u) => u.toLowerCase().startsWith("z")); // Zack 

// example 2
final users = [User(11, 'idan'), User(12, 'ronit'), User(11, 'asaf')];
	
final dist = users.distinctBy((u) => u.age);    
dist.forEach((u) => print(u.age)); //  11, 12
```  
  
### .zip()  
Zip is used to combine multiple iterables into a single list that contains  the combination of them two.
```dart  

final soldThisMonth = [Motorcycle(2020, 'BMW R1200GS'), Motorcycle(1967, 'Honda GoldWing')];
final soldLastMonth = [Motorcycle(2014, 'Honda Transalp'), Motorcycle(2019, 'Ducati Multistrada')];    
  
final sales = soldThisMonth.zip(soldLastMonth).toList();  
  				
print(sales); // [
  [brand: BMW R1200GS year: 2020, brand: Honda Transalp year: 2014], // first pair from this month and last
  [brand: Honda GoldWing year: 1967, brand: Ducati Multistrada year: 2019] // second pair from last month 
]
```  
See [iterable.dart](https://github.com/droididan/dart_extentions/blob/master/lib/iterable.dart) for more  examples.  

## Range Extensions
### .until()
Returns a sequence of integer, starting from the current number until the [end] number. [step] is optional, it will step number if given
```dart
for(final num in 1.until(10)) {
  numbers.add(num); 
}
```
*result*
```dart
[1, 2, 3, 4, 5, 6, 7, 8, 9]
```
with step:
```dart
for(final num in 1.until(10, step: 2)) {
  numbers.add(num); 
}
```
*result*
```dart
[1, 3, 5, 7, 9]
```

## String Extensions
  
### .replaceAfter()
Replace part of string after the first occurrence of given delimiter.
```dart  
print("myemail@".replaceAfter("@", "gmail.com")); // myemail@gmail.com 
```  
### .replaceBefore()
Replace part of string before the first occurrence of given delimiter.
```dart  
print('@domain.com'.replaceBefore('@', "name")); // "name@domain.com"
```

### .anyChar()
Returns `true` if at least one element matches the given predicate
```dart  
'test'.anyChar((c) => c == 't'); // true;
'test'.anyChar((c) => c == 'd'); // false;
```

### .ifEmpty()
If the string is empty perform an action.
```dart  
"".ifEmpty(() => print("do any action here")); // do any action here
```  
  
### .toDoubleOrNull()  
Parses the string as an integer or returns `null` if it is not a number.  
```dart  
var number = '12345'.toDoubleOrNull(); // 12345  
var notANumber = '123-45'.toDoubleOrNull(); // null  
```  


# Flutter Extensions Full List

## Http Extensions
- `httpGet`
- `httpPost`
- `httpPut`
- `httpDelete`

## Iterables Extensions
- `find`
- `filter`
- `filterNot`
- `isEmptyOrNull`
- `chunks`
- `zip`
- `half`
- `takeOnly`
- `drop`
- `firstHalf`
- `secondHalf`
- `swap`
- `getRandom`
- `firstOrNull`
- `firstOrNullWhere`
- `firstOrDefault`
- `lastOrNull`
- `lastOrDefault`
- `forEachIndexed`
- `sortedDescending`
- `containsAll`
- `count`
- `distinctBy`
- `subtract`
- `concatWithSingleList`
- `concatWithMultipleList`
- `associate`

## Range Extensions
- `until`


## Strings Extensions
- `validateEmail`
- `removeSurrounding`
- `isNullOrEmpty`
- `replaceAfter`
- `replaceBefore`
- `orEmpty`
- `ifEmpty`
- `lastIndex`
- `printThis`
- `equalsIgnoreCase`
- `toDoubleOrNull`
- `toIntOrNull`
- `anyChar`
- `removeAllWhiteSpace`
- `isNotBlank`
- `toCharArray`
- `insert`
- `isNullOrWhiteSpace`

## DateTime Extensions
- `toMilliseconds`
- `toSeconds`
- `toMinutes`
- `toHours`
- `toDays`
- `isToday`
- `addOrRemoveYears`
- `addOrRemoveMonth`
- `addOrRemoveDay`
- `addOrRemoveMinutes`
- `addOrRemoveSeconds`
- `startOfDay`
- `startOfMonth`
- `startOfYear`
- `operator to add dates`
- `operator to subtract dates`
- `tomorrow`
- `yesterday`
- `min`
- `max`
- `isLeapYear`

## Integers Extensions
- `absolute`
- `isEven`
- `isOdd`
- `isPositive`
- `isNegative`
- `tenth`
- `fourth`
- `third`
- `half`
- `doubled`
- `tripled`
- `quadrupled`
- `squared`


## License  
```  
Copyright 2020 Idan Ayalon
  
Licensed under the Apache License, Version 2.0 (the "License");  
you may not use this file except in compliance with the License.  
You may obtain a copy of the License at  
  
 http://www.apache.org/licenses/LICENSE-2.0  
Unless required by applicable law or agreed to in writing, software  
distributed under the License is distributed on an "AS IS" BASIS,  
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  
See the License for the specific language governing permissions and  
limitations under the License.  
```