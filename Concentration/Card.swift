import Foundation

/*
    Difference between struct and class
    Two major differences:
    Struct does not have inheritence.
    Struct are value types and classes are reference types.
    Value-types are copied (Int, Array, String).
    Reference types lives in heap.  are passing pointers around.
*/

//This card is UI independent.  Does not need emojis.  Just how the game functions.
struct Card {
    var isFaceUp = false;
    var isMatched = false;
    var identifier: Int;
    
    static var identifierFactory = 0;
    
    static func getUniqueIdentifier() -> Int {
        identifierFactory += 1;
        return identifierFactory;
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier();
    }
    
    init(identifier: Int) {
        //'My identifier'
        self.identifier = identifier;
    }
    
    
    
}
