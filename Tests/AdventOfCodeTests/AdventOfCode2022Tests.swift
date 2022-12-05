//
//  Created by Eddy Gammon on 01/12/2022.
//

import XCTest

@testable import AdventOfCode

final class AdventOfCode2022Tests: XCTestCase {
    let advent = AdventOfCode2022()
    
    func testDay1_part1() {
        var result: Int = 0
        measure {
            result = advent.day1_1()
        }
        XCTAssertEqual(result, 69289)
        print(#function + ": \(result)")
    }
    
    func testDay1_part2() {
        var result: Int = 0
        measure {
            result = advent.day1_2()
        }
        XCTAssertEqual(result, 205615)
        print(#function + ": \(result)")
    }
    
    func testDay2_part1() {
        var result: Int = 0
        measure {
            result = advent.day2_1()
        }
        XCTAssertEqual(result, 11475)
        print(#function + ": \(advent.day2_1())")
    }
    
    func testDay2_part2() {
        var result: Int = 0
        measure {
            result = advent.day2_2()
        }
        XCTAssertEqual(result, 16862)
        print(#function + ": \(result)")
    }
    
    func testDay3_part1() {
        var result: Int = 0
        measure {
            result = advent.day3_1()
        }
        XCTAssertEqual(result, 8088)
        print(#function + ": \(result)")
    }
    
    func testDay3_part2() {
        var result: Int = 0
        measure {
            result = advent.day3_2()
        }
        XCTAssertEqual(result, 2522)
        print(#function + ": \(result)")
    }
    
    func testDay4_part1() {
        var result = 0
        measure {
            result = advent.day4_1()
        }
        XCTAssertEqual(result, 496)
        print(#function + ": \(result)")
    }
    
    func testDay4_part2() {
        var result: Int = 0
        measure {
            result = advent.day4_2()
        }
        XCTAssertEqual(result, 847)
        print(#function + ": \(result)")
    }
    
    func testDay5_part1() {
        var result: String = ""
        measure {
            result = advent.day5_1()
        }
        XCTAssertEqual(result, "TGWSMRBPN")
        print(#function + ": \(result)")
    }
}
