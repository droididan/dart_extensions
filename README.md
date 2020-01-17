<img src="https://raw.githubusercontent.com/leisim/dartx/master/.github/logo.svg?sanitize=true" width="500px">

[![](https://img.shields.io/badge/dart%20extensions-v0.0.01-green)](https://github.com/droididan/dart_extentions)

*let me know if you miss a something specific and ill add it*

### Resources:
- [Documentation](https://pub.dev/documentation/dartx/latest/dartx/dartx-library.html)
- [Pub Package](https://pub.dev/packages/dartx)
- [GitHub Repository](https://github.com/leisim/dartx)

why I need this? When you’re using someone else’s API or when you implement a library that’s widely used, it’s often impractical or impossible to change the API. But you might still want to add some functionality.

## Let get started 💪🏻

1. go to `pubspec.yaml` 
2. add a dart_extentions and replace `[version]` with the latest version:

```dart
dependencies:
  dart_extentions: ^[version]
```

3. click the packages get button or *flutter pub get*

## Iterable

```dart
 ["red","green","blue"].forEachIndexed((item, index) {
    print("$item, $index");
  }); // 0: red
      // 1: green
      // 2: blue
```

### .slice()
Returns elements at indices between `start` (inclusive) and `end` (inclusive).
```dart
var list = [0, 1, 2, 3, 4, 5];
var last = list.slice(-1); // [5]
var lastHalf = list.slice(3); // [3, 4, 5]
var allButFirstAndLast = list.slice(1, -2); // [1, 2, 3, 4]
```

### .sortedBy() & .thenBy()
Sort lists by multiple properties.
```dart
var dogs = [
  Dog(name: "Tom", age: 3),
  Dog(name: "Charlie", age: 7),
  Dog(name: "Bark", age: 1),
  Dog(name: "Cookie", age: 4),
  Dog(name: "Charlie", age: 2),
];

var sorted = dogs
    .sortedBy((dog) => dog.name)
    .thenByDescending((dog) => dog.age);
// Bark, Cookie, Charlie (7), Charlie (2), Tom
```

### .distinctBy()
Get distinct elements from a list.
```dart
var list = ['this', 'is', 'a', 'test'];
var distinctByLength = list.distinctBy((it) => it.length); // ['this', 'is', 'a']
```

### .flatten()
Get a new lazy `Iterable` of all elements from all collections in a collection.
```dart
var nestedList = [[1, 2, 3], [4, 5, 6]];
var flattened = nestedList.flatten(); // [1, 2, 3, 4, 5, 6]
```

## String

### .chars
Get a list of single character strings from a string. Supports emojis.
```dart
var chars = 'family👨‍👨‍👧‍👦'.chars; // ['f', 'a', 'm', 'i', 'l', 'y', '👨‍👨‍👧‍👦']
```

### .isBlank
Returns `true` if this string is empty or consists solely of whitespace characters.
```dart
var notBlank = '   .'.isBlank; // false
var blank = '  '.isBlank; // true
```

### .toIntOrNull()
Parses the string as an ineger or returns `null` if it is not a number.
```dart
var number = '12345'.toIntOrNull(); // 12345
var notANumber = '123-45'.toIntOrNull(); // null
```

## Time utils
Dartx exports [@jogboms](https://github.com/jogboms) great [⏰ time.dart](https://github.com/jogboms/time.dart) package so you can do the following:

```dart
int secondsInADay = 1.days.inSeconds;

Duration totalTime = [12.5.seconds, 101.milliseconds, 2.5.minutes].sum();

DateTime oneWeekLater = DateTime.now() + 1.week;
```

Check out [⏰ time.dart](https://github.com/jogboms/time.dart) for more information and examples.

## num

### .coerceIn()
Ensures that this value lies in the specified range.
```dart
var numberInRange = 123.coerceIn(0, 1000); // 123
var numberOutOfRange = -123.coerceIn(0, 1000); // 0
```

### .toBytes()
Converts this value to binary form.

## range

### rangeTo

Creates a range between two ints (upwards, downwards and with custom steps)
```dart
// upwards with default step size 1
for (var i in 1.rangeTo(5)) {
  print(i); // 1, 2, 3, 4, 5
}
// downwards with custom step
for (var i in 10.rangeTo(2).step(2)) {
  print(i); // 10, 8, 6, 4, 2
}
```

## Function

### .invoke() - DEPRECATED
Use `call()` instead. This is very useful for `null` checks.
```dart
var func = (String value) {
  print(value);
}

func?.call('hello world');
```

### .partial(), .partial2() ...
Applies some of the required arguments to a function and returns a function which takes the remaining arguments.
```dart
void greet(String firstName, String lastName) {
  print('Hi $firstName $lastName!');
}

var greetStark = greet.partial('Stark');
greetStark('Sansa'); // Hi Sansa Stark!
greetStark('Tony'); // Hi Tony Stark!
```

## File

### .name
Get the name and extension of a file.
```dart
var file = File('some/path/testFile.dart');
print(file.name); // testFile.dart
print(file.nameWithoutExtension); // testFile
```

### .appendText()
Append text to a file.
```dart
await File('someFile.json').appendText('{test: true}');
```

### .isWithin()
Checks if a file is inside a directory.
```dart
var dir = Directory('some/path');
File('some/path/file.dart').isWithin(dir); // true
```


## License
```
Copyright 2019 Simon Leier

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
