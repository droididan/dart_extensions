  
[![](https://img.shields.io/badge/build-1.0.0-brightgreen)](https://github.com/droididan/dart_extentions)   ![](https://img.shields.io/badge/Code%20Coverage-96%25-green) ![](https://img.shields.io/badge/Bitrise-Pass-green)  
  
 
## What New 
* `BuildContext` extensions 💪🏻
* `List<Widget>` extensions 💪🏻
* `Text` extensions 💪🏻
* `Icon` extensions 💪🏻
* `.sortBy` [0.3.5] Sorts elements in the array in-place according to natural sort order of the value returned by specified selector function.
* `.withTooltip` Tooltips improve the accessibility of visual widgets by proving a textual representation of the widget

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


## Iterable Extensions

### .any()
Returns `true` if at least one element matches the given predicate.
```dart
final users = [User(22, "Kasey"), User(23, "Jadn")]; 
users.any((u) => u.name == 'Kasey') // true
```

### .groupBy()
Groups the elements in values by the value returned by key.
```dart
final users = [User(22, "Kasey"), User(23, "Jadn"), User(22, "Rene"), User(32, "Aden")]; 

users.groupBy((u) => u.age); 
```
Sort the users by age:
```dart
{  
  22: [User:22, Kasey, User:22, Rene], 
  23: [User:23, Jadn], 
  32: [User:32, Aden]
}
```

### .sortBy()
Sorts elements in the array in-place according to natural sort order of the value returned by specified selector function.
```dart
final users = [User(22, "Kasey"), User(16, "Roni"), User(23, "Jadn")]; 
users.sortBy((u) => u.age) ///  [User(16, "Roni"), [User(22, "Kasey"), User(23, "Jadn")]
```

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

### .intersect()
Returns a set containing all elements that are contained by both this set and the specified collection.
```dart
Set.from([1, 2, 3, 4]).intersect(Set.from([3, 4, 5, 6]) // 1,2,3,4,5,6
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

## Flutter Extensions

### Context extensions
Are you not tired from typing `MediaQuery.of(context).size...` to get height or width? here's a cool extension
```dart
  context.mq  // returns the MediaQuery
```

```dart
  context isLandscape // returns if Orientation is landscape
```

```dart
context.sizePx // returns same as MediaQuery.of(context).size
```

```dart
context.widthPx // returns same as MediaQuery.of(context).size.width
```

```dart
context.heightPx // returns same as MediaQuery.of(context).height
```

### Text Extensions
```dart
final text = Text('hello')
     .bold()
     .fontSize(25)
     .italic();
```

### List<Widget> Extensions
```dart
    final someWidgetList = [
      Text('hello'),
      Text('world'),
    ].toColumnWidget();  // toRowWidget(), toStackWidget()
```

### Widget extensions
So now we can just add round corners, shadows, align, and added gestures to our `Widgets` without the crazy water-fall effect. awesome!
That's just the tip of the iceberg, expect to see very cool stuff soon.
```dart
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: <Widget>[
            Container(
              height: 100,
              width: 100,
            )   .withRoundCorners(backgroundColor: Colors.grey)
                .withShadow()
                .alignAtCenter()
                .toCenter()
                .withTooltip('just a tooltip')
                .paddingOnly(left: 10)
                .paddingAll(20)
                .onTap(() => print('tap'))
                .onLongPress(() => print('long press'))
          ],
        ),
      ),
    );
  }
}
```

### Navigation
We can navigate from every widget by calling these methods
```dart
    navigateTo(route: MaterialPageRoute(builder: (c) => Login()));
    navigateByRouteName(Routes.home, );
    final result = navigateBack();
```


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


### .asBool()
Returns true if this string is any of these values: "true", "yes", "1", or if the string is a number and greater than 0, false if less than 1. This is also case insensitive.
```dart
'true'.asBool  // true
'True'.asBool  // true
'false'.asBool //  false
'False'.asBool //  false
'yes'.asBool   // true
'YES'.asBool   // true
'no'.asBool    // false
'NO'.asBool    // false
```


### .insert()
Returns a new string in which a specified string is inserted at a specified index position in this instance.
```dart
'test'.insert(1, 't') // 'ttest'
'123456890'.insert(6, '7') // '1234567890'
'dart cool'.insert(4, ' is') // 'dart is cool'
```

### .isNullOrWhiteSpace()
Indicates whether a specified string is `null`, `empty`, or consists only of `white-space` characters.
```dart
'test'.isNullOrWhiteSpace // false
'   '.isNullOrWhiteSpace, // true
null.isNullOrWhiteSpace, // true
'  te  st  '.isNullOrWhiteSpace // false
```

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

### .limitFromEnd()
Limit the string to a maximum length, taking from the end of the string.
```dart
var longString = "0123456789";
var noMoreThanThree = longString.limitFromEnd(3); // "789"
```

### .limitFromStart()
Limit the string to a maximum length, taking from the start of the string.
```dart
var longString = "0123456789";
var noMoreThanThree = longString.limitFromStart(3); // "012"
```

## int Extensions

### .inRangeOf()  
Return the min if this number is smaller then minimum
Return the max if this number is bigger the the maximum
Return this number if it's between the range
```dart
1.inRangeOf(0, 3) // 1 number in range so will return the number
2.inRangeOf(3, 4) // 3 number is smaller then the range so will return min
5.inRangeOf(3, 4) // 4 number is bigger then the range so will return max
```

# Flutter Extensions Full List

## Flutter
- `Tooltip`
- `algin`
- `center`
- `container`
- `padding`
- `navigation`
- `Context`
- `Text`
- `List<Widget>`
- `Icon`

## Http Extensions
- `httpGet`
- `httpPost`
- `httpPut`
- `httpDelete`

## Iterables Extensions
- `sortBy`
- `toMutableSet`
- `intersect`
- `groupBy`
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
- `asBool`

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
- `limitFromEnd`
- `limitFromStart`

## Integers Extensions
- `inRangeOf`
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
- `asBool`

## Contributing

If you have read up till here, then 🎉🎉🎉. There are couple of ways in which you can contribute to
the growing community of `dart_extensions.dart`.


- Propose any feature, enhancement
- Report a bug
- Fix a bug
- Participate in a discussion and help in decision making
- Write and improve some **documentation**. Documentation is super critical and its importance
  cannot be overstated!
- Send in a Pull Request :-)


## Contributors ✨
<table>
  <tr>
      <td align="center"><a href="https://github.com/droididan"><img src="https://avatars2.githubusercontent.com/u/10584019?s=460&v=4" width="64px;" alt=""/><br /><sub><b>Idan Ayalon</b></sub></a><br /><a href="" title="Code">💻</a> <a href="" title="Documentation">📖</a> <a href="" title="Reviewed Pull Requests">👀</a></td>
    </a></td>
    </tr>
  <tr>
    <td align="center"><a href="https://github.com/xamantra"><img src="https://avatars0.githubusercontent.com/u/37391380?s=400&v=4" width="64px;" alt=""/><br /><sub><b>Xamantra</b></sub></a><br /><a href="" title="Code">💻</a> <a href="" title="Documentation">📖</a> <a href="" title="Reviewed Pull Requests">👀</a></td>
  </a></td>
  </tr>
</table>



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