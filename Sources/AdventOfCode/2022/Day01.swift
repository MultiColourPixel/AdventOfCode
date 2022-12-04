//
//  Created by Eddy Gammon on 04/12/2022.
//

extension AdventOfCode2022 {
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
}
