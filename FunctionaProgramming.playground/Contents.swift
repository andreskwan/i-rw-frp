//: Playground - noun: a place where people can play

import UIKit

/*
 Filtering 
 - do not change just extract
 */

/*
 Imperative OOP way
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
/*
 FP way
 */
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
 Reducing
 
 - a reduce function, takes a set of inputs and generates a single output.
 
 */

var sum = 0
let evenArray = Array(1...10).filter{ $0 % 2 == 0 }
for element in evenArray {
    sum += element
}
print(sum)

/*
 Reduce 
 - to understand reduce I use the signature of the reduce method

 func reduce<U>(initial: U, combine: (U, T) -> U) -> U

 */
sum = Array(0...10)
    .filter{ $0 % 2 == 0 }
    .reduce(0,combine: { (total, number) in total + number })

// simplification
// if last argument of a function is a block/closure
// can be outside the ()
sum = Array(0...10)
    .filter{ $0 % 2 == 0 }
    .reduce(0){ (total, number) in total + number }

print(sum)

/*
 Reduce - Max number
 */

let arrayOfNumbers = [2, 5, 3, 8, 16]

arrayOfNumbers.reduce(0){(total, number) in max(total, number) }

/*
 Reduce 
 - has two type parameters, U and T, 
 which can be different and certainly don’t have to be integers. 
 This means you can reduce an array of one type into a completely different type.
 */
// from [Int]() to String

let numbers = Array(1...10)
    .reduce("numbers: ") {(total, number) in total + "\(number) "}
print(numbers)

/*
 mapping - transformations
 
 */

/*
 map - example 1
 
 Building an Index the Functional Way
 */
let words = ["Cat", "Chicken", "fish", "Dog",
             "Mouse", "Guinea Pig", "monkey", "rat", "beard", "bird"]

//define a type alias for a dupla
typealias Entry = (Character, [String])

func distinct<T: Equatable>(source: [T]) -> [T] {
    var unique = [T]()
    
    for item in source {
        if !unique.contains(item) {
            unique.append(item)
        }
    }
    return unique
}

func buildIndex(words: [String]) -> [Entry] {
    func firstLetter(word: String) -> Character {
        return Character(word.substringToIndex(word.startIndex.advancedBy(1)).uppercaseString)
    }
    
    var letters = words.map{ (word) -> Character in
        return firstLetter(word)
    }
    print(letters)
    
    letters = words.map{ firstLetter($0) }
    print(letters)
    
    letters = words.map(firstLetter)
    print(letters)
    
    let distinctLetters = distinct(letters)
    print(distinctLetters)
    
    return distinctLetters.map{ (letter) -> Entry in
        return (letter, words.filter{ (word) -> Bool in
                return firstLetter(word) == letter
            }
        )
    }
}

print(buildIndex(words))

/*
 FP in swift book
 */

let oneToFour = [1,2,3,4]
let firstNumber = oneToFour.lazy.map{ $0 * 3 }.first!
print(firstNumber)


/*
 Function types - pass function as parameters - store them in parameters
 */
typealias SimpleOperator = (Int, Int) -> Int

var simpleMathOperator: SimpleOperator

func addTwoValues(a: Int, b: Int) -> Int {
    return a + b
}
func square(a: Int) -> Int {
    return a * a
}

simpleMathOperator = addTwoValues

print("\(simpleMathOperator(3, 4))")

// as parameter
func calculateResult(mathOperator: SimpleOperator, a: Int, b: Int) -> Int {
    return mathOperator(a,b)
}

let mathFunc = calculateResult(simpleMathOperator, a: 8, b: 10)

print("\(mathFunc)")



