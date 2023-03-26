//
//  CommandParserTest.swift
//  Transactional-Key-Value-StoreTests
//
//  Created by Damian Smakulski on 26/03/2023.
//

import XCTest
@testable import Transactional_Key_Value_Store

final class CommandParserTests: XCTestCase {
    static let testCommandText = "testCommand"
    static let testCommandExecutionText = "testCommandRun"
    
    private struct TestCommand: Command {
        let baseArg: String = CommandParserTests.testCommandText
        
        mutating func run(parameters: [String]) throws -> String? {
            return CommandParserTests.testCommandExecutionText + parameters.joined(separator: ",")
        }
    }
    
    override func setUpWithError() throws {
    }

    func testCommandParserBuilderCanBuildAndExecuteOnlyThisCommand() throws {
        let testParam = "testParam"
        let commandParser = CommandParserBuilder()
            .with(TestCommand())
            .build()
        
        let result = try commandParser.parse(command: CommandParserTests.testCommandText + " " + testParam )
        
        XCTAssertEqual(result, CommandParserTests.testCommandExecutionText + testParam)
        
        
    }
}
