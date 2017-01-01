//
//  MixedTokenTests.swift
//  Mustard
//
//  Created by Mathew Sanders on 12/30/16.
//  Copyright © 2016 Mathew Sanders. All rights reserved.
//

import XCTest
import Mustard

enum MixedToken: TokenType {
    
    case word
    case number
    case emoji
    case none
    
    init() {
        self = .none
    }
    
    static let wordToken = WordToken()
    static let numberToken = NumberToken()
    static let emojiToken = EmojiToken()
    
    func canTake(_ scalar: UnicodeScalar) -> Bool {
        switch self {
        case .word: return MixedToken.wordToken.canTake(scalar)
        case .number: return MixedToken.numberToken.canTake(scalar)
        case .emoji: return MixedToken.emojiToken.canTake(scalar)
        case .none:
            return false
        }
    }
    
    func token(startingWith scalar: UnicodeScalar) -> TokenType? {
        
        if let _ = MixedToken.wordToken.token(startingWith: scalar) {
            return MixedToken.word
        }
        else if let _ = MixedToken.numberToken.token(startingWith: scalar) {
            return MixedToken.number
        }
        else if let _ = MixedToken.emojiToken.token(startingWith: scalar) {
            return MixedToken.emoji
        }
        else {
            return nil
        }
    }
}

class MixedTokenTests: XCTestCase {
    
    func testMixedTokens() {
        
        let tokens: [MixedToken.Token] = "123👩‍👩‍👦‍👦Hello world👶again👶🏿45.67".tokens()
        
        XCTAssert(tokens.count == 8, "Unexpected number of tokens [\(tokens.count)]")
        
        XCTAssert(tokens[0].tokenizer == .number)
        XCTAssert(tokens[0].text == "123")
        
        XCTAssert(tokens[1].tokenizer == .emoji)
        XCTAssert(tokens[1].text == "👩‍👩‍👦‍👦")
        
        XCTAssert(tokens[2].tokenizer == .word)
        XCTAssert(tokens[2].text == "Hello")
        
        XCTAssert(tokens[3].tokenizer == .word)
        XCTAssert(tokens[3].text == "world")
    
        XCTAssert(tokens[4].tokenizer == .emoji)
        XCTAssert(tokens[4].text == "👶")
        
        XCTAssert(tokens[5].tokenizer == .word)
        XCTAssert(tokens[5].text == "again")
        
        XCTAssert(tokens[6].tokenizer == .emoji)
        XCTAssert(tokens[6].text == "👶🏿")
        
        XCTAssert(tokens[7].tokenizer == .number)
        XCTAssert(tokens[7].text == "45.67")
        
    }
}
