//
//  CommandParserTest.swift
//  Transactional-Key-Value-StoreTests
//
//  Created by Damian Smakulski on 26/03/2023.
//

import XCTest
@testable import Transactional_Key_Value_Store

final class CommandParserTests: XCTestCase {

    static let testCommand1Text = "testCommand1"
    static let testCommand2Text = "testCommand2"
    static let testCommand1ExecutionText = "testCommand1Run"
    static let testCommand2ExecutionText = "testCommandRun"
    
    private struct TestCommand1: Command {
        let baseArg: String = CommandParserTests.testCommand1Text
        
        mutating func run(parameters: [String]) throws -> String? {
            return CommandParserTests.testCommand1ExecutionText + parameters.joined(separator: ",")
        }
    }
    
    private struct TestCommand2: Command {
        let baseArg: String = CommandParserTests.testCommand2Text
        
        mutating func run(parameters: [String]) throws -> String? {
            return CommandParserTests.testCommand2ExecutionText
            + parameters.joined(separator: ".")
        }
    }

    func testCommandParserBuilderWithOneCommandCanExecuteOnlyThisCommand() throws {
        let commandParser = CommandParserBuilder()
            .with(TestCommand1())
            .build()
        
        let _ = try commandParser.parse(command: CommandParserTests.testCommand1Text)
        
        XCTAssertThrowsError(try commandParser.parse(command: CommandParserTests.testCommand2Text)) { error in
            XCTAssertEqual(error as! CommandParser.ArgumentParserError, CommandParser.ArgumentParserError.invalidCommand)
        }
    }
    
    func testCommandParserBuilderWithCommands() throws {
        let commandParser = CommandParserBuilder()
            .with(TestCommand1())
            .with(TestCommand2())
            .build()
        
        let _ = try commandParser.parse(command: CommandParserTests.testCommand1Text)
        
        let _ = try commandParser.parse(command: CommandParserTests.testCommand2Text)
    }
    
    func testCommandParserBuilderDoNotAddThatSameCommand() throws {
        let commandParser = CommandParserBuilder()
            .with(TestCommand1())
            .with(TestCommand1())
            .with(TestCommand1())
            .with(TestCommand1())
            .build()
        
        XCTAssertEqual(commandParser.commands.count, 1)
    }
    
    func testCommandParserParseCommandsWithArgs() throws {
        let commandParser = CommandParserBuilder()
            .with(TestCommand1())
            .with(TestCommand2())
            .build()
        let args = ["test1", "test2"]
        
        let commandText1 = CommandParserTests.testCommand1Text + " " +  args.joined(separator: "  ")
        let resultCommand1 = CommandParserTests.testCommand1ExecutionText +  args.joined(separator: ",")
        let commandText2 = CommandParserTests.testCommand2Text + " " +  args.joined(separator: "  ")
        let resultCommand2 = CommandParserTests.testCommand2ExecutionText +  args.joined(separator: ".")
        
        var command1WithArgs = try commandParser.parse(command: commandText1)
        
        let result1 = try command1WithArgs.command.run(parameters: command1WithArgs.args)
        XCTAssertEqual(result1, resultCommand1)
        
        var command2WithArgs = try commandParser.parse(command: commandText2)
        
        let result2 = try command2WithArgs.command.run(parameters: command2WithArgs.args)
        XCTAssertEqual(result2, resultCommand2)
    }
}

