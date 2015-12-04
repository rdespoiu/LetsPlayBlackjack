//
//  Cards.swift
//  War-CardGame
//
//  Created by Roberto Despoiu on 11/23/15.
//  Copyright © 2015 Roberto Despoiu. All rights reserved.
//

import Foundation

class Cards {
    private var _suits = ["C","D","H","S"]
    private var _values = ["2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14"]
    
    /*
    var dealerCardOne: String!
    var dealerCardTwo: String!
    
    var playerCardOne: String!
    var playerCardTwo: String!
    */
    
    var currentDeal: Array<String>!
    
    
    init() {
        
    }
    
    func makeDeck() -> Array<String> {
        //Makes a deck built of 4 decks of cards
        
        var deckCount = 0
        var deck = [String]()
        var fourDecks = [String]()
        
        for suit in _suits {
            for value in _values {
                deck.append("\(value)\(suit)")
            }
        }
        
        while deckCount < 4 {
            for value in deck {
                fourDecks.append(value)
            }
            deckCount++
        }
        
        return fourDecks
        
    }
    
    func shuffleDeck(deckInput: Array<String>) -> Array<String> {
        
        var currentDeck = deckInput
        var newDeck = [String]()
        
        while newDeck.count < deckInput.count {
            let randomCard = arc4random_uniform(UInt32(currentDeck.count))
            newDeck.append(currentDeck[Int(randomCard)])
            currentDeck[Int(randomCard)...Int(randomCard)] = []
        }
        
        return newDeck
        
    }
    
    func dealCards(var fromDeck: Array<String>) -> Array<String> {
        var dealtCards: Array<String> = []
        dealtCards.append(fromDeck[0])
        dealtCards.append(fromDeck[1])
        dealtCards.append(fromDeck[2])
        dealtCards.append(fromDeck[3])
        return dealtCards
    }
    

    
    
    
    func cardValues(card: String) -> Int {
        var cardValue = 0
        
        if Int(String(card[card.startIndex.advancedBy(1)])) != nil {
            if Int(String(card[card.startIndex.advancedBy(1)]))! == 1 {
                cardValue = 11
            } else {
                cardValue = 10
            }
            
        } else {
            cardValue = Int(String(card[card.startIndex]))!
        }
        
        return cardValue
        
    }
    
    
    
    
}