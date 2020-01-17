  
[![](https://img.shields.io/badge/Dart%20Extensions-v0.0.6-green)](https://github.com/droididan/dart_extentions)   ![](https://img.shields.io/badge/Code%20Coverage-96%25-green) ![](https://img.shields.io/badge/Bitrise-Pass-green)  
  
### Resources:  
- [Extetsions Full List](https://github.com/droididan/dart_extensions/blob/master/FEATURELIST.md)  

  
Why I need this? When you’re using someone else’s API or when you implement a library that’s widely used, it’s often impractical or impossible to change the API. But you might still want to add some functionality.  
  
  *let me know if you want something specific or you found a bug at bar.idan@gmail.com*  
## Let get started 💪🏻  
  
1. Go to `pubspec.yaml` 
2. add a dart_extentions and replace `[version]` with the latest version:  
  
```dart  
dependencies:  
 dart_extentions: ^[version]
 ```
  
3. click the packages get button or *flutter pub get*  

  
## Iterable Extensions
`import 'package:flutter_extentions/iterable.dart';`

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
final users = []  
  ..add(User(33, "Miki"))  
  ..add(User(45, "Anna"))  
  ..add(User(19, "Amit"));  
  
final aboveAgeTwenty = users.count((user) => user.age > 20);  
print(aboveAgeTwenty); // 2
```  
  
### .distinctBy()  
Returns a list containing only the elements from given collection having distinct keys.
```dart  
// example 1
final users = ["Idan", "Ian", "Ronit"];  
users.distinctBy((u) => u.toLowerCase().startsWith("I")); // Idan 

// example 2
final users = <User>[]
	..add(User(11, 'idan'))
	..add(User(12, 'ronit'))
	..add(User(11, 'asaf'));  

final dist = users.distinctBy((u) => u.age);    
dist.forEach((u) => print(u.age)); //  11, 12
```  
  
### .zip()  
Zip is used to combine multiple iterables into a single list that contains  the combination of them two.
```dart  

final soldThisMonth = <Motorcycle>[]  
  ..add(Motorcycle(2020, 'BMW R1200GS'))  
  ..add(Motorcycle(1967, 'Honda GoldWing'))  

final soldLastMonth = <Motorcycle>[]  
  ..add(Motorcycle(2014, 'Honda Transalp'))  
  ..add(Motorcycle(2019, 'Ducati Multistrada'))  
  
final sales = soldThisMonth.zip(soldLastMonth).toList();  
  
				    (this from soldThisMonth)      (this from so	ldLastMonth)
print(sales); // [[brand: BMW R1200GS year: 2020, brand: Honda Transalp year: 2014],
				  [brand: Honda GoldWing year: 1967, brand: Ducati Multistrada year: 2019]]
```  
  See [iterable.dart](https://github.com/droididan/dart_extentions/blob/master/lib/iterable.dart) for more  examples.  
  
## String  Extensions
`import 'package:flutter_extentions/strings.dart';
  
### .replaceAfter
Replace part of string after the first occurrence of given delimiter.
```dart  
print("myemail@".replaceAfter("@", "gmail.com")); // myemail@gmail.com 
```  
  
### .ifEmpty
if the string is empty perform an action.
```dart  
"".ifEmpty(() => print("do any action here")); // do any action here
```  
  
### .toDoubleOrNull()  
Parses the string as an ineger or returns `null` if it is not a number.  
```dart  
var number = '12345'.toIntOrNull(); // 12345  
var notANumber = '123-45'.toIntOrNull(); // null  
```  

  
  
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