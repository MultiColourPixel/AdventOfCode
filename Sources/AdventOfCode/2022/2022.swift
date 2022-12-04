//
//  Created by Eddy Gammon on 01/12/2022.
//

import Algorithms
import Foundation

struct AdventOfCode2022 {
    func day1_1() -> Int {
        let input: [Int?] = loadFile(omittingEmptySubsequences: false)
        
        var maxCalories = 0
        var currentElfCalories = 0
        for calorie in input {
            guard let calorie else {
                maxCalories = max(maxCalories, currentElfCalories)
                currentElfCalories = 0
                continue
            }

            currentElfCalories += calorie
        }

        return maxCalories
    }
    
    func day1_2() -> Int {
        let input: [Int?] = loadFile(omittingEmptySubsequences: false)
        
        var currentElfCalories = 0
        var topElf = 0
        var secondElf = 0
        var thirdElf = 0
        
        for calorie in input {
            guard let calorie else {
                defer { currentElfCalories = 0 }
                
                let minElf = min(topElf, secondElf, thirdElf)
                guard currentElfCalories > minElf else { continue }
                
                if topElf == minElf {
                    topElf = currentElfCalories
                    continue
                }
                if secondElf == minElf {
                    secondElf = currentElfCalories
                    continue
                }
                if thirdElf == minElf {
                    thirdElf = currentElfCalories
                    continue
                }
                continue
            }
            
            currentElfCalories += calorie
        }
        
        let maxCalories = topElf + secondElf + thirdElf
        
        return maxCalories
    }
    
    func day2_1() -> Int {
        let allRounds: [String] = loadFile()
        return allRounds.map { game in
            let round = game.split(separator: " ")
                .compactMap(RockPaperScissors.init)
            
            return RockPaperScissors.matchResult(round[0], me: round[1]) + round[1].points
        }
        .reduce(0, +)
    }
    
    func day2_2() -> Int {
        let allRounds: [String] = loadFile()
        return allRounds.map { game in
            let splits = game.split(separator: " ")
            
            let opponentMove = RockPaperScissors(rawValue: splits[0])!
            let desiredOutcome = RockPaperScissors.DesiredOutcome(rawValue: splits[1])!
            let outcomeMove = opponentMove.moveForDesiredOutcome(desiredOutcome)
            
            return RockPaperScissors.matchResult(opponentMove, me: outcomeMove) + outcomeMove.points
        }
        .reduce(0, +)
    }
    
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
    
    func day4_1() -> Int {
        let input: [String] = loadFile()
    
        let result = input.map { value -> Bool in
            let pairs = value.split(separator: ",")
                .map { value -> [String.SubSequence] in
                    value.split(separator: "-")
                }
                .map { values -> ClosedRange<Int> in
                    Int(values[0])!...Int(values[1])!
                }
                
            let firstElf = pairs[0]
            let secondElf = pairs[1]
            
            if firstElf.contains(secondElf.lowerBound) && firstElf.contains(secondElf.upperBound) ||
                secondElf.contains(firstElf.lowerBound) && secondElf.contains(firstElf.upperBound)
            {
                return true
            }
            return false
        }
            .filter { $0 }
            .count
        
        return result
    }
    
    func day4_2() -> Int {
        let input: [String] = loadFile()
        
        let result = input.map { value -> Bool in
            let pairs = value.split(separator: ",")
                .map { value -> [String.SubSequence] in
                    value.split(separator: "-")
                }
                .map { values -> ClosedRange<Int> in
                    Int(values[0])!...Int(values[1])!
                }
                
            let firstElf = pairs[0]
            let secondElf = pairs[1]
            
            if firstElf.contains(secondElf.lowerBound) || firstElf.contains(secondElf.upperBound) ||
                secondElf.contains(firstElf.lowerBound) || secondElf.contains(firstElf.upperBound)
            {
                return true
            }
            return false
        }
            .filter { $0 }
            .count
        
        return result
    }
}

extension AdventOfCode2022: FileLoading { }

// MARK: Day 2
private extension AdventOfCode2022 {
    enum RockPaperScissors: Substring {
        enum DesiredOutcome: Substring {
            case lose = "X"
            case draw = "Y"
            case win = "Z"
        }
        
        case rock
        case paper
        case scissors
        
        var points: Int {
            switch self {
            case .rock: return 1
            case .paper: return 2
            case .scissors: return 3
            }
        }
        
        init?(rawValue: Substring) {
            if rawValue == "A" || rawValue == "X" {
                self = .rock
            }
            else if rawValue == "B" || rawValue == "Y" {
                self = .paper
            }
            else if rawValue == "C" || rawValue == "Z" {
                self = .scissors
            }
            else {
                return nil
            }
        }
        
        static func matchResult(_ opponent: Self, me: Self) -> Int {
            switch (opponent, me) {
            case (.rock, .rock): return 3
            case (.rock, .paper): return 6
            case (.paper, .paper): return 3
            case (.paper, .scissors): return 6
            case (.scissors, .scissors): return 3
            case (.scissors, .rock): return 6
            default: return 0
            }
        }
        
        func moveForDesiredOutcome(_ desiredOutcome: DesiredOutcome) -> Self {
            switch (self, desiredOutcome) {
            case (.rock, .win): return .paper
            case (.rock, .lose): return .scissors
            case (.paper, .win): return .scissors
            case (.paper, .lose): return .rock
            case (.scissors, .win): return .rock
            case (.scissors, .lose): return .paper
            default: return self
            }
        }
    }
}

// MARK: Day 3
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
