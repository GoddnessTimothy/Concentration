import Foundation
//This is our Model. (UI Independent).

/*
    Difference between struct and class
    Two major differences:
        Struct does not have inheritence.
        Struct are value types and classes are reference types.
    Value-types are copied (Int, Array, String)
    Reference types lives in heap.  are passing pointers around
 
    Struct gets free initializer, initializes all vars, so Card() takes 3 arguements: isFaceUp, isMatched and identifier.
    Classes do not get this free initializer.
    Inits tend to have same external and internal name.
 
    When creating a class, think about what its public API will be.
 */

class Concentration {
    /*
        Read about init()
        Array of Cards
        Array has an init().  This creates an empty Array.
     */
    var cards = Array<Card>();
    
    //We do not know which card is one and only face-up
    var indexOfOneAndOnlyFaceUpCard: Int?
    
    /*
        Flips card initially face-down.
        if card is face-up, flips card back face-down.
    
        3 possible cases:
            1.  No cards are faced-up. when another card is chosen,  just flip over the card.
            2.  2 cards are faced-up. when another card is chosen, both cards have to be flipped over.
            3.  1 card is faced-up. We choose another card. Check if the card is matched.
    */
    func chooseCard(at index: Int) {
        if (!cards[index].isMatched) {
            //Player must choose two different cards.  Cannot choose card already face-up
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                //check if cards matched
                if(cards[matchIndex].identifier == cards[index].identifier) {
                    cards[matchIndex].isMatched = true;
                    cards[index].isMatched = true;
                }
                cards[index].isFaceUp = true;
                //now there are two different face-up cards, so indexOfOneAndOnlyFaceUpCard doesn't exist yet.
                indexOfOneAndOnlyFaceUpCard = nil;
            } else {
                //either 2 cards or no cards are face up.
                //Turn all cards face-down
                for flipDownIndex in cards.indices {
                    //Turn any face-up cards, face-down.
                    cards[flipDownIndex].isFaceUp = false;
                }
                cards[index].isFaceUp = true;
                indexOfOneAndOnlyFaceUpCard = index;
            }
        }
    }
    
    //Determines how many pairs of cards to create.
    init(numberOfPairOfCards: Int) {
        /*
            Swift for-loop syntax
            for startVal in 0..<endVal (0 to endVal, not including endVal).
            for startVal in 1...endVal (1 to endVal, including endVal).
            We are using an underscore instead of an index, because index will never be used in the code.
            for intdex in 0..<numberOfPairsOfCards works but index is never used
            This is called a countable range.
         */
        for _ in 0..<numberOfPairOfCards {
            let card = Card();
            //matchingCard is a copy of card.
            let matchingCard = card;
            /*
                Create 2 pairs of cards, numberOfPairOfCards times.
                E.g: if 6 is passed in, there will be 3 pairs of cards.
                Append matching cards into Array.
            */
            cards += [card, matchingCard];
        }
    }
}
