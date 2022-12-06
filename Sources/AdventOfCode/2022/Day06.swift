//
//  Created by Eddy Gammon on 04/12/2022.
//

extension AdventOfCode2022 {
    func day6_1() -> Int {
        let input: String = loadFileAsString().trimmingCharacters(in: .whitespacesAndNewlines)
        let array = Array(input)
        
        var lastFourCharacters = array[0..<4]
        var uniqueIndex = 0
        
        // assuming we don't have the initial four characters as the marker
        for index in 4..<array.count {
            let char = array[index]
            
            lastFourCharacters.append(char)
            lastFourCharacters.removeFirst()
            
            if Set(lastFourCharacters).count == 4 {
                uniqueIndex = index
                break
            }
        }
        
        return uniqueIndex + 1
    }
    
    func day6_2() -> Int {
        let input: String = loadFileAsString().trimmingCharacters(in: .whitespacesAndNewlines)
        let array = Array(input)
        
        var lastFourCharacters = array[0..<14]
        var uniqueIndex = 0
        
        // assuming we don't have the initial unique characters at the beginning of the message
        for index in 14..<array.count {
            let char = array[index]
            
            lastFourCharacters.append(char)
            lastFourCharacters.removeFirst()
            
            if Set(lastFourCharacters).count == 14 {
                uniqueIndex = index
                break
            }
        }
        
        return uniqueIndex + 1
    }
}
