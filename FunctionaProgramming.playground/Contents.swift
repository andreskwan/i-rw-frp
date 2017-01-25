//: Playground - noun: a place where people can play

import UIKit
//From RW FP link?
//https://www.raywenderlich.com/82599/swift-functional-programming-tutorial

print("================== Imperative Vs Functional ========================")
/*
 [exp1][Filtering]
 - [Imperative]
   [tell the computer HOW to do what I need done]
 - [functional]
   [describe WHAT I want done rather than specify how I want it to be done]
  */

/*
 Simple Array Filtering
    - Inmutability - do not change just extract,
 */

/*
 Imperative filtering 
     - the old Imperative way
     from an array extract/filter the even numbers into a new array
     http://stackoverflow.com/questions/602444/what-is-functional-declarative-and-imperative-programming
 */
//use of range operator - see Generics Doc 
//https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Generics.html
let evens = [Int](0...10)
print("Evens before modification: \n\(evens)")

var evens2 = [Int]()
//for i in 1...10 {
for i in evens {
    if i % 2 == 0 {
        evens2.append(i)
    }
}
print("Imperative way: \n\(evens2)")

/* 
 Functional filtering
    1 Higer-order function
    function that takes as argument other functions "filter()"
    2 First-class functions - functions just like any other variable

    isEven()
    is the function that I will pass as parametter to the filter(HOF)
    this is the functional programming function.
*/
func isEven(number: Int) -> Bool {
    return number % 2 == 0
}

// difference between map and filter 
// filter
// Inmutable - 
// creates and returns a new array that contains only the items for which the given function returns true.
/*
 FP way
 */
//evens = Array(1...10).filter(isEven)
evens2 = evens.filter(isEven)
print("filter(isEven): \n\(evens2)")

evens2 = evens.map{$0 % 2}
print("map{$0 % 2}: \n\(evens2)")

print("Evens after filter and map: \n\(evens)")

/* Output
 Evens before modification:
 [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
 Imperative way:
 [0, 2, 4, 6, 8, 10]
 filter(isEven):
 [0, 2, 4, 6, 8, 10]
 map{$0 % 2}:
 [0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0]
 */

print("\n================== functions are closures ========================")
// functions are closures
// instead to pass a isEven() function use a closure/block
// 3 Closures:
// anonymous functions you create in-place.
evens2 = evens.filter{ (number) in number % 2 == 0 }
print("evens.filter{ (number) in number % 2 == 0 }: \n\(evens2)")

evens2 = evens.filter{$0 % 2 == 0}
print("evens.filter{$0 % 2 == 0}: \n\(evens2)")

/* Output
evens.filter{ (number) in number % 2 == 0 }:
[0, 2, 4, 6, 8, 10]
evens.filter{$0 % 2 == 0}:
[0, 2, 4, 6, 8, 10]
*/

print("\n================== Generic function ========================")
// [HOF] [High order functions] [create my own HOF with generics]

// input source: array of type T
// predicate: function that takes an instance of T
// returns: a new array with the elements filtered using the predicate over [T]

func myFilter<T>(source: [T], predicate:(T) -> Bool) -> [T] {
    var result = [T]()
    for i in source {
        if predicate(i) {
            result.append(i)
        }
    }
    return result
}

evens2 = myFilter(source: evens, predicate: { number in number % 2 == 0})
print("myFilter(source: evens, predicate: { number in number % 2 == 0}) \n\(evens2)")

//Homogenety
extension Collection {
    func myFilter(predicate: (Self.Iterator.Element) -> Bool) -> [Self.Iterator.Element] {
        var result : [Self.Generator.Element] = []
        for element in self {
            if predicate(element) {
                result.append(element)
            }
        }
        return result
    }
}

evens2 = evens.myFilter(predicate: {$0 % 2 == 0})
print("evens.myFilter(predicate: {$0 % 2 == 0}) \n\(evens2)")

/* Output
 myFilter(source: evens, predicate: { number in number % 2 == 0})
 [0, 2, 4, 6, 8, 10]
 evens.myFilter(predicate: {$0 % 2 == 0})
 [0, 2, 4, 6, 8, 10]

 */
print("\n================== Reducing ========================")
/*
 - a reduce function, takes a set of inputs and generates a single output.
 */

var sum = 0
let evenArray = evens.filter{ $0 % 2 == 0 }
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
    .reduce(0,{ (total, number) in total + number })

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
        return Character(word.substring(from: word.index(after: word.startIndex)).uppercased())
    }
    
    var letters = words.map{ (word) -> Character in
        return firstLetter(word: word)
    }
    print(letters)
    
    letters = words.map{ firstLetter(word: $0) }
    print(letters)
    
    letters = words.map(firstLetter)
    print(letters)
    
    let distinctLetters = distinct(source: letters)
    print(distinctLetters)
    
    return distinctLetters.map{ (letter) -> Entry in
        return (letter, words.filter{ (word) -> Bool in
            return firstLetter(word: word) == letter
            }
        )
    }
}

//pay attention to this
//print(buildIndex(words: words))

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

let mathFunc = calculateResult(mathOperator: simpleMathOperator, a: 8, b: 10)

print("\(mathFunc)")


/*
 Higher-order functions - accept other functions as parameters
 */
typealias AddSubstractOperator = (Int, Int) -> Int
typealias SquareTripleOperator = (Int) -> Int

func calculate(a: Int , b: Int, funcA: AddSubstractOperator, funcB: SquareTripleOperator) -> Int {
    return funcA(funcB(a), funcB(b))
}

print("The result of adding two squared values is: \(calculate(a: 2, b:2, funcA: addTwoValues, funcB: square))")

/*
 Function composition
 
 example:
 ineract with a backend
 - receive a string and
 - create and array of strings
 - append a "$" as a currency to each item
 */
// imperative way

let restfulResponse = "10,20,30,40,50,60"

func createArrayFromString(content: String) -> [String] {
    return content.characters.split(separator: ",").map{String($0)}
}

let elements = createArrayFromString(content: restfulResponse)

func formatWithCurrency(arrayString: [String]) -> [String] {
    return arrayString.map{"$\($0)"}
}

let formatElements = formatWithCurrency(arrayString: elements)

//functional approach
// 1 identify function types for each function
// createArrayFromString: (String) -> [String]
// formatWithCurrency: [String] -> [String]

// pipe these functions

// createArrayFromString: (String) -> [String] | formatWithCurrency: [String] -> [String]

// combine with functional composition
// String -> [String]

let composedFunction = { data in
    formatWithCurrency(arrayString: createArrayFromString(content: data))
}
composedFunction(restfulResponse)

//from Bond tutorial
// inline initialization
// executes the block inline, return a NSFormatter
// this is not lazy, takes place right away
var formatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    formatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale!
    return formatter
}()

//from apple developer enumerations
enum ofRawString: String {
    case Pepe
    case Papo
}

let enumValue = ofRawString.Pepe
print(enumValue)

enum ofAssociativeType {
    case FirstAssociative(String)
    case SecondAssociative(Int)
}

let first = ofAssociativeType.FirstAssociative("Home sweet home")
let second = ofAssociativeType.SecondAssociative(1009)
print(first)
print(second)

switch first {
case ofAssociativeType.FirstAssociative(let firstValue):
    print(firstValue)
case let ofAssociativeType.SecondAssociative(secondValue):
    print(secondValue)
}

//from SF
//.reduce(0,combine: { (total, number) in total + number })
let moreText = Array(arrayLiteral: "hola como estas")
let pepe = "hola como estas".characters.reduce("", { (resultString, inputChar) -> String in
    if inputChar != " " {
        return resultString + String(inputChar)
    }
    return resultString + "+"
})

//from https://developer.apple.com/reference/swift/closedrangeiterator/1781446-reduce
let extractSpace: (String, Character) -> String = {total, input in
    input != " " ? total + String(input) : total + "+"
}

let popo = "hola como estas".characters.reduce("", extractSpace)
popo

// flatMap vs map higher order funcitons also known as transformations
let possibleNumbers = ["1", "2", "three", "///4///", "5"]

let mapped: [Int?] = possibleNumbers.map { str in Int(str) }
// [1, 2, nil, nil, 5]
print("map transformation which returns an array of optionals: \n\(mapped)")

let flatMapped: [Int] = possibleNumbers.flatMap { str in Int(str) }
// [1, 2, 5]
print("flatMap transformation which returns an array with non-optionals: \n\(flatMapped)")

