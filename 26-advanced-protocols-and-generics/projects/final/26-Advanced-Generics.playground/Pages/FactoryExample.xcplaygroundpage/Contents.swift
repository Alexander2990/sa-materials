/// Copyright (c) 2020 Razeware LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import Foundation


//protocol Product {}
//
//protocol ProductionLine  {
//  func produce() -> Product
//}
//
//protocol Factory {
//  var productionLines: [ProductionLine] {get}
//}
//
//extension Factory {
//  func produce() -> [Product] {
//  var items: [Product] = []
//  productionLines.forEach { items.append($0.produce()) }
//  print("Finished Production")
//  print("-------------------")
//  return items
//  }
//}
//
//struct Car: Product {
//  init() {
//  print("Producing one awesome Car 🚔")
//  }
//}
//
//struct CarProductionLine: ProductionLine {
//  func produce() -> Product {
//  Car()
//  }
//}
//
//struct CarFactory: Factory {
//  var productionLines: [ProductionLine] = []
//}
//
//var carFactory = CarFactory()
//carFactory.productionLines = [CarProductionLine(), CarProductionLine()]
//carFactory.produce()
//
//struct Chocolate: Product {
//  init() {
//  print("Producing one chocolate bar 🍫")
//  }
//}
//
//struct ChocolateProductionLine: ProductionLine {
//  func produce() -> Product {
//  Chocolate()
//  }
//}
//
//var oddCarFactory = CarFactory()
//oddCarFactory.productionLines = [CarProductionLine(), ChocolateProductionLine()]
//oddCarFactory.produce()

protocol Product {
  init()
}

protocol ProductionLine {
  associatedtype ProductType
  func produce() -> ProductType
}

protocol Factory {
  associatedtype ProductType
  func produce() -> [ProductType]
}

struct Car: Product {
  init() {
    print("Producing one awesome Car 🚔")
  }
}

struct Chocolate: Product{
  init() {
    print("Producing one Chocolate bar 🍫")
  }
}

struct GenericProductionLine<P: Product>: ProductionLine {
  func produce() -> P {
    P()
  }
}

struct GenericFactory<P: Product>: Factory {
  var productionLines: [GenericProductionLine<P>] = []

  func produce() -> [P] {
    var newItems: [P] = []
    productionLines.forEach { newItems.append($0.produce()) }
    print("Finished Production")
    print("-------------------")
    return newItems
  }
}

var carFactory = GenericFactory<Car>()
carFactory.productionLines = [GenericProductionLine<Car>(), GenericProductionLine<Car>()]
carFactory.produce()

var chocolateFactory = GenericFactory<Chocolate>()
chocolateFactory.productionLines = [GenericProductionLine<Chocolate>(), GenericProductionLine<Chocolate>()]
chocolateFactory.produce()


func makeFactory(numberOfLines: Int) -> some Factory {
  var factory = GenericFactory<Car>()
  for _ in 0..<numberOfLines {
    factory.productionLines.append(GenericProductionLine<Car>())
  }
  return factory
}

func makeEquatableNumeric() -> some Numeric & Equatable {
  return 1
}

let someVar = makeEquatableNumeric()
let someVar2 = makeEquatableNumeric()

print(someVar == someVar2)
print(someVar + someVar2)
//print(someVar > someVar2) // error
