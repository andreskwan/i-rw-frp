//: Playground - noun: a place where people can play

import UIKit

/*
 Filtering - do not change just extract
 */
var evens = [Int]()
for i in 1...10 {
    if i % 2 == 0 {
        evens.append(i)
    }
}
print(evens)

// 1 Higer-order function
// function that I pass as argument to other functions "filter()"
// 2 First-class functions - functions just like any other variable
func isEven(number: Int) -> Bool {
    return number % 2 == 0
}

// difference between map and filter 
// filter
//creates and returns a new array that contains only the items for which the given function returns true.
evens = Array(1...10).filter(isEven)
print(evens)


evens = Array(1...10).map{$0 % 2}
print(evens)

// functions are closures 
// instead to pass a isEven() function use a closure/block
// 3 Closures:
// anonymous functions you create in-place.
evens = Array(1...10).filter { (number) in number % 2 == 0 }
print(evens)

evens = Array(1...10).filter{$0 % 2 == 0}
print(evens)

//Generic function 
// input source: array of type T
// predicate: function that takes an instance of T
// returns: Bool
func myFilter<T>(source: [T], predicate:(T) -> Bool) -> [T] {
    var result = [T]()
    for i in source {
        if predicate(i) {
            result.append(i)
        }
    }
    return result
}

evens = myFilter(Array(1...10), predicate: { number in number % 2 == 0})
print(evens)

extension CollectionType {
    func myFilter(predicate: (Self.Generator.Element) -> Bool) -> [Self.Generator.Element] {
        var result : [Self.Generator.Element] = []
        for element in self {
            if predicate(element) {
                result.append(element)
            }
        }
        return result
    }
}

evens = Array(1...20).myFilter({$0 % 2 == 0})
print(evens)

/*
 
 Reducing - a reduce function, takes a set of inputs and generates a single output.
 
 */

var sum = 0
let evenArray = Array(1...10).filter{ $0 % 2 == 0 }
for element in evenArray {
    sum += element
}
print(sum)

sum = Array(0...10)
    .filter{ $0 % 2 == 0 }
    .reduce(0,combine: { (total, number) in total + number })
print(sum)

