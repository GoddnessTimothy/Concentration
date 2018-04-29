import Foundation
//Model

//This card is UI independent.  Does not need emojis.  Just how the game functions.
struct Card {
    var isFaceUp: Bool = false;
    var isMatched: Bool = false;
    var identifier: Int = 0;
    
    static var identifierFactory: Int = 0;
    
    static func getUniqueIdentifier() -> Int {
        identifierFactory += 1;
        return identifierFactory;
    }
    
    //init() is like a constructor.
    init() {
        self.identifier = Card.getUniqueIdentifier();
    }
    
    //This init() takes one arguement, an identifier.
    init(identifier: Int) {
        //'My identifier'
        //this.identifier = identifier
        self.identifier = identifier;
    }
}
