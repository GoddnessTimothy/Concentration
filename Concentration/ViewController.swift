import UIKit
/*
    The model is in Concentration.swift
    The storyboard is our View.
    This is our Controller.
 */

//Be careful when copying and pasting buttons. Right-click button (on storyboard) to disconnect any unnecessary links (in 'touch up inside').
class ViewController: UIViewController {
    /*
         Struct gets free initializer, but we have to specify how many cards pairs of cards to show.  Create our own in Concentration class, that takes a numOfPairOfCards:Int as a arguement.
         This creates the connection between Controller and Model.
         not initialized until game is used.
         lazy makes a var not initialized until someone actually uses it.
         lazy vars counts as being initialized.
         lazy vars cannot have a didSet{} (property observers).
     */
    lazy var game = Concentration(numberOfPairOfCards: (touchCards.count+1)/2);
    
    /*
         Declaring variables:
         var nameofvar: return_type
         Swift require all instance variables (properties) HAS to be initialized.
         Swift is STRONGLY typed but has STRONG type inference.
         Swift knows that flipCard is initialized to an Int.
         var flipCount: Int = 0;
         Hold option and click on flipCard to verify data_type
         var flipCard1 = "HELLO";
         var flipCount = 0;
     */
    var flipCount: Int = 0 {
        /*
            Property observer
            Everytime flipCount is changed, the label will be updated.
            Keeps UI in sync with instance variables.
        */
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)";
        }
    }
    
    //Not necessary to put data_type of array but I am keeping it.
    //Emojis can be added at Edit->emoji and symbols.
    var emoijiChoices : Array<String> = ["👻", "🎃", "🐝", "🐴", "🐙", "🐎", "🦆", "👩‍👩‍👦‍👦", "💂🏻‍♀️", "👪", "👩‍👧‍👦", "👫", "🌈"];
   
    //Empty dictionary that takes a identifier(an int), and a String(the emoji) as a Key and Value pair.
    var emojiDict = Dictionary<Int, String>();
    
    /*
         Outlet creates an instance variable.
         UILabel cannot be inferred.  Has to be explicitly declared.
         Notice that there is no initialization and that there is no error.
     */
    @IBOutlet weak var flipCountLabel: UILabel!
    
    /*
         Outlet collection (An array of UIButton)
         Nil means an optional is not set
         An optional is indicated by a '!' and has 2 states: set and unset.
     */
    @IBOutlet var touchCards: [UIButton]!
    
    //This method is connected to first button on the storyboard
    @IBAction func touchButton(_ sender: UIButton) {
        //print("Arg, a ghost!");
        flipCount += 1;
        /*
            Let defines constant.
            Putting '!' at end of an unset optional will crash app
        */
        if let cardNumber : Int = touchCards.index(of: sender) {
            //sends index of card flipped(tapped) to choseCard() which will flip the boolean isFaceUp to true.  isFaceUp is initialized to false.
            game.chooseCard(at: cardNumber);
            //Update view to be in sync with model
            updateViewFromModel();
            //print("CardNumber: = \(cardNumber)");
        } else {
            print("Chosen card is not in collection.");
        }
    }
    
    //This method keeps View and Model in sync so that model reflects whatever changes are made in View (storyboard).
    func updateViewFromModel() {
        //Iterate through touchCard array
        for index in touchCards.indices {
            //Set buttons on storyboard to be button at current index.
            //button is of type UIButton.
            //card is of type Card (struct Card).
            //Takes card at Index index from Card array and sets it to card.
            let card = game.cards[index];
            //checks if Card card isFaceUp.
            let button = touchCards[index];
            if (card.isFaceUp) {
                //emojiRandomGenerator() will return a random emoji (a string) and button will be set to that emoji.
                //setTitle() takes a string(emoji),and UIControlState.
                button.setTitle(emojiRandomGenerator(for: card), for: UIControlState.normal);
                button.backgroundColor = UIColor.white;
            } else {
                button.setTitle("", for: UIControlState.normal);
                //If card is matched, make it black so that you can no longer see it.  Otherwise, flip it back face down.  (isMatched is initially false and isn't changed to true yet.  That's why faced-down card will have an orange background, not purple).
                button.backgroundColor = card.isMatched ? UIColor.clear : UIColor.orange;
            }
        }
        print(game.matchedCount);
        if(game.matchedCount == (game.cards.count/2)) {
            print("last pair");
            for indexes in touchCards.indices {
                let button = touchCards[indexes];
                button.backgroundColor = UIColor.orange;
                button.setTitle("", for: UIControlState.normal);
                var card = game.cards[indexes];
                card.isFaceUp = true;
                card.isMatched = false;
            }
            //reset flipcount
            flipCount = 0;
            flipCountLabel.text = "Flips: \(flipCount)";
        }
    }
    
    /*
         Randomly generate and return an emoji String.
         Swift NEVER does automatic type-conversion.  As a result, you cannot go from a unsigned_int to an int.
         let randomIndex = arc4random_uniform(emoijiChoices.count); gives an error.
         randomIndex needs to be an Int not an unsigned int.  Luckily, Int(), exists where Int is a struct and takes an unsigned int as an arguement.
     
        //Alternative (Swift) syntax
        if (emojiDict[card.identifier] == nil), (emoijiChoices.count > 0) {
            //Generates a random integer where max is emojiChoices.length()-1.
            let randomIndex = Int(arc4random_uniform(UInt32(emoijiChoices.count)));
            //remove any used emoji so there is never any duplicating random cards.
            emojiDict[card.identifier] = emoijiChoices.remove(at: randomIndex);
        }
     
        //Alternatie (Swift) syntax for line 143
        if (emoji[card.identifier] != nil) {
            return emoji[card.identifier]!
         } else {
            return "?";
         }
     
         //Alternative short-hand syntax below.  If val at [card.identifier] is not nil, return val.  Otherwise, return "?". ('??' is not a typo).
            return emojiDict[card.identifier] ?? "?";
    */
    func emojiRandomGenerator(for card: Card) -> String {
        if (emojiDict[card.identifier] == nil) {
            //IF there are still emojis to choose from... (choosing from an empty array will cause a problem.
            if (emoijiChoices.count > 0) {
                //Generates a random integer where max is emojiChoices.length()-1.
                let randomIndex = Int(arc4random_uniform(UInt32(emoijiChoices.count)));
                //remove any used emoji so there is never any duplicating random cards.
                emojiDict[card.identifier] = emoijiChoices.remove(at: randomIndex);
            }
        }
        return emojiDict[card.identifier] ?? "?";
    }
}
