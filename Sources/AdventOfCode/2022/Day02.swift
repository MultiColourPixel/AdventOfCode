//
//  Created by Eddy Gammon on 04/12/2022.
//

extension AdventOfCode2022 {
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
}

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
