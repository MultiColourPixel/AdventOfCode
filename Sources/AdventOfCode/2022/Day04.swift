//
//  Created by Eddy Gammon on 04/12/2022.
//

import Foundation

extension AdventOfCode2022 {
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
