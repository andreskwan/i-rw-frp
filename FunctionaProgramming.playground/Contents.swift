//: Playground - noun: a place where people can play

import UIKit

var evens = [Int]()
for i in 1...10 {
    if i % 2 == 0 {
        evens.append(i)
    }
}
print(evens)

//
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
evens = Array(1...10).filter { (number) in number % 2 == 0 }
print(evens)

evens = Array(1...10).filter{$0 % 2 == 0}
print(evens)
