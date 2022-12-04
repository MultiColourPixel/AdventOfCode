//
//  Created by Eddy Gammon on 04/12/2022.
//

import Foundation

extension AdventOfCode2022 {
    func day3_1() -> Int {
        let input: [String] = loadFile()
        
        let result = input.map { Array($0) }
            .map { bag in
                let compartmentSize = bag.count / 2
                let firstHalf = Set(bag[0..<compartmentSize])
                let secondHalf = Set(bag[compartmentSize...])
                let difference = firstHalf.intersection(secondHalf)
                return difference.first!
            }
            .map(Day3_1.value(forCharacter:))
            .reduce(0, +)
        
        return result
    }
    
    func day3_2() -> Int {
        let input: [String] = loadFile()
        
        let result = input.chunks(ofCount: 3)
            .map { group in
                group.map(Set.init)
                    .reduce(into: [Character: Int]()) { partialResult, characters in
                        characters.forEach { character in
                            partialResult[character, default: 0] += 1
                        }
                    }
                    .filter { element in
                        element.value > 2
                    }
                    .map(\.key)
                    .map(Day3_1.value(forCharacter:))
            }
            .flatMap { $0 }
            .reduce(0, +)
        
        return result
    }
}

private extension AdventOfCode2022 {
    struct Day3_1 {
        static func value(forCharacter character: Character) -> Int {
            guard let ascii = character.asciiValue else { fatalError() }
            if character.isUppercase {
                return Int(ascii - 38)
            } else {
                return Int(ascii - 96)
            }
        }
    }
}
