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
evens = Array(1...10).filter(isEven)
evens = Array(1...10).filter{$0 % 2 == 0}
print(evens)
