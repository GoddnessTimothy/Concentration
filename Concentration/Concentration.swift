import Foundation
//This is our Model. (UI Independent).

class Concentration {
    //Determines how many pairs of cards to create.
    init(numberOfPairOfCards: Int) {
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
    
    /*
        Read about init()
        Array of Cards
        Array has an init().  This creates an empty Array.
     */
    var cards = Array<Card>();

    //We do not know which card is one and only face-up
    var indexOfOneAndOnlyFaceUpCard: Int?
    
    //Keep count of matched cards.
    var matchedCount: Int = 0;

    /*
        Flips card initially face-down.
        if card is face-up, flips card back face-down.
    
        3 possible cases:
            1.  No cards are faced-up. when another card is chosen,  just flip over the card.
            2.  2 cards are faced-up. when another card is chosen, both cards have to be flipped over.
            3.  1 card is faced-up. We choose another card. Check if the card is matched.
    */
    func chooseCard(at index: Int) {
        print(cards[index].isMatched);
        if (!cards[index].isMatched) {
            //Player must choose two different cards.  Cannot choose card already face-up.
            if let matchIndex = indexOfOneAndOnlyFaceUpCard {
                if (matchIndex != index) {
                    //check if cards matched
                    if(cards[matchIndex].identifier == cards[index].identifier) {
                        cards[matchIndex].isMatched = true;
                        cards[index].isMatched = true;
                        //count the number of matched pairs in order to determine when to reset game.
                        matchedCount+=1;
                    }
                    cards[index].isFaceUp = true;
                    //now there are two different face-up cards, so indexOfOneAndOnlyFaceUpCard doesn't exist yet.
                    indexOfOneAndOnlyFaceUpCard = nil;
                    }
                } else {
                    //either 2 cards or no cards are face up.
                    //Turn all cards face-down
//                    print("Im here");
                    for flipDownIndex in cards.indices {
                        //Turn any face-up cards, face-down.
                        cards[flipDownIndex].isFaceUp = false;
                    }
                    //Make next card selected face-up
                    cards[index].isFaceUp = true;
                    //After a mis-match attempt, when you flip a new card over.  That card will be the only face-up card.
                    indexOfOneAndOnlyFaceUpCard = index;
                }
        }
        
    }
   
}
