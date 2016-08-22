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
let evens1 = Array(1...10).filter(isEven)
let evens2 = Array(1...10).filter{$0 % 2 == 0}
let evens3 = Array(1...10).map{$0 % 2}

print(evens1)
print(evens2)
print(evens3)
    
