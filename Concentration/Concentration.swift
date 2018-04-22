import Foundation
/*
    Difference between struct and class
    Two major differences:
    Struct does not have inheritence.
    Struct are value types and classes are reference types.
    Value-types are copied (Int, Array, String)
    Reference types lives in heap.  are passing pointers around
 
    Struct gets free initializer, initializes all vars, so Card() takes 3 arguements: isFaceUp, isMatched and identifier.
    Classes do not get this free initializer.
    Inits tend to have same external and internal name
 
 */
class Concentration {
    //Read about init()
    var cards = [Card]();
    
    func chooseCard(at index: Int) {
        if (cards[index].isFaceUp) {
            cards[index].isFaceUp = false;
        } else {
            cards[index].isFaceUp = true;
        }
    }
    
    init(numberOfPairOfCards: Int) {
        //Swift for-loop syntax
        //for startVal in 0..<endVal (0 to endVal, not including endVal).
        //for startVal in 1...endVal (1 to endVal, including endVal).
        //Do not care about the external nameca
        for _ in 0..<numberOfPairOfCards {
            let card = Card();
            //matchingCard is a copy of card
            let matchingCard = card;
//            cards.append(card);
//            cards.append(matchingCard);
            cards += [card, matchingCard];
        }
    }
}
