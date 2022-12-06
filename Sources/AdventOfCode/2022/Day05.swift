//
//  Created by Eddy Gammon on 04/12/2022.
//

import Algorithms
import RegexBuilder
import Foundation

extension AdventOfCode2022 {
    func day5_1() -> String {
        var (instructions, stacks) = input()

        for instruction in instructions {
            var toStack = stacks[instruction.to]!
            var fromStack = stacks[instruction.from]!
            for _ in 0 ..< instruction.amount {
                let drop = fromStack.removeLast()
                toStack.append(drop)
            }
            stacks[instruction.to] = toStack
            stacks[instruction.from] = fromStack
        }
        
        var result = ""
        let keys = stacks.keys.sorted()
        for key in keys {
            result += stacks[key, default: []].last ?? ""
        }
        
        return result
    }
        
}

private extension AdventOfCode2022 {
    func input() -> ([Instruction], [Int: [String]]) {
        let input: [String] = loadFile(name: "day5", omittingEmptySubsequences: false).dropLast()
        
        guard let inputSplitIndex = input.firstIndex(where: \String.isEmpty) else { return ([],[:]) }
        let instructions = input.dropFirst(inputSplitIndex + 1)
            .compactMap { rawInstructions in
                rawInstructions.wholeMatch(of: Self.instructionRegex).map { match in
                    Instruction(amount: match.output.1, from: match.output.2, to: match.output.3)
                }
            }
        
        let rawStacks = input[0..<inputSplitIndex].dropLast()
        let stacks = rawStacks
            .map {
                $0.chunks(ofCount: 4)
            }
            .reduce([Int: String](), { partialResult, chunk in
                var partial = partialResult
                var desiredIndex = chunk.startIndex
                for index in 0..<chunk.count {
                    if index > 0 {
                        desiredIndex = chunk.index(after: desiredIndex)
                    }
                    partial[index+1, default: ""] += String(chunk[desiredIndex])
                }
                return partial
            })
            .reduce([Int: [String]](), { partialResult, keyValue in
                var partial = partialResult
                let cleaned = keyValue.value
                    .compactMap { character -> String? in
                        if character.isWhitespace || character == "[" || character == "]" {
                            return nil
                        }
                        return String(character)
                    }
                    .joined()
                    .reversed()
                    .map(String.init)
                
                partial[keyValue.key] = cleaned
                
                return partial
            })
        
        return (instructions, stacks)
    }
}

private extension AdventOfCode2022 {
    struct Instruction {
        let amount: Int
        let from: Int
        let to: Int
    }
    
    private static let filler = Regex {
        Optionally {
            ChoiceOf {
                CharacterClass.whitespace
                "["
                "]"
            }
        }
    }
    private static let detail = Regex {
        Optionally {
            Capture {
                One(.word)
            }
        }
    }
    
    private static let instructionRegex = Regex {
        OneOrMore(.word) // move
        
        OneOrMore(.whitespace)
        
        TryCapture {
            OneOrMore(.digit) // amount
        } transform: {
            Int($0)
        }
        
        OneOrMore(.whitespace)
        
        OneOrMore(.word) // from
        
        OneOrMore(.whitespace)
        
        TryCapture {
            OneOrMore(.digit)
        } transform: {
            Int($0)
        }
        
        OneOrMore(.whitespace)
        
        OneOrMore(.word) // to
        
        OneOrMore(.whitespace)
        
        TryCapture {
            OneOrMore(.digit)
        } transform: {
            Int($0)
        }
    }
}
