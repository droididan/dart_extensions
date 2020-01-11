# Flutter Extentions Methods

Extension methods, which allow you to pretend to add new members of existing types. An extension method can be invoked just like a normal method, o.extensionMethod(42), even though it really is just a static function.

In a simple word, it will get you rid of the Utility class with lots of static methods you are creating all along.

why I need this? When you’re using someone else’s API or when you implement a library that’s widely used, it’s often impractical or impossible to change the API. But you might still want to add some functionality.

The most basic example can be from this:
```
int.parse('42')
```

To this:
```
42'.parseInt()
```

## Extentions for Iterables

- firstOrNull
- firstOrNullWhere
- firstOrDefault
- lastOrNull
- lastOrDefault
- forEachIndexed
- sortedDescending
- containsAll
- count
- distinctBy

TBD - tests

## will release soon...
- Extentions for Date
- Extentions for Ranges
- Extentions for Files







