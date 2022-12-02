//
//  Created by Eddy Gammon on 01/12/2022.
//

import XCTest

@testable import AdventOfCode

final class AdventOfCode2022Tests: XCTestCase {
    let advent = AdventOfCode2022()
    
    func testDay1_part1() {
        print(#function + ": \(advent.day1_1())")
    }
    
    func testDay1_part2() {
        print(#function + ": \(advent.day1_2())")
    }
    
    func testDay2_part1() {
        let result = advent.day2_1()
        XCTAssertEqual(result, 11475)
        print(#function + ": \(advent.day2_1())")
    }
    
    func testDay2_part2() {
        let result = advent.day2_2()
        XCTAssertEqual(result, 16862)
        print(#function + ": \(result)")
    }
}
