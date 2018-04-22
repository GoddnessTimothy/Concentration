import UIKit

//Be careful when copying and pasting buttons. Right-click button (on storyboard) to disconnect any unnecessary links (in 'touch up inside')
class ViewController: UIViewController {
    /*
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
        //Property observer
        //Everytime flipCount is changed, the label will be updated.
        //Keeps UI in sync with instance variables.
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)";
        }
    }
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
    
    //Not necessary to put data_type of array but I am keeping it
    var emoijiChoices : Array<String> = ["👻", "🎃", "🐝", "🐴", "🐙", "🐎"];
    
    //This method is connected to first button on the storyboard
    @IBAction func touchButton(_ sender: UIButton) {
        //print("Arg, a ghost!");
        flipCount += 1;
        //Let defines constant.
        //Putting '!' at end of an unset optional will crash app
        //let cardNumber = touchCards.index(of: sender)!;
        if let cardNumber : Int = touchCards.index(of: sender) {
            game.chooseCard(at: cardNumber);
            //Update view to be in sync with model
            updateViewFromModel();
            //print("CardNumber: = \(cardNumber)");
        } else {
            print("Chosen card is not in collection.");
        }
    }
    func updateViewFromModel() {
        for index in touchCards.indices {
            let button = touchCards[index];
            let card = game.cards[index];
            if card.isFaceUp {
                button.setTitle(emojiRandomGenerator(for: card), for: UIControlState.normal);
                button.backgroundColor = UIColor.white;
            } else {
                button.setTitle("", for: UIControlState.normal);
                //If card is matched, make it black so that you can no longer see it.  Otherwise, flip it back face down.
                button.backgroundColor = card.isMatched ? UIColor.black : UIColor.orange;
            }
        }
    }
    var emoji = [Int:String]();
 
    func emojiRandomGenerator(for card: Card) -> String {
        /*
             if (emoji[card.identifier] != nil) {
                return emoji[card.identifier]!
             } else {
                return "?";
             }
             Alternative syntax
         */
        if (emoji[card.identifier] == nil) {
            //Swift NEVER does automatic type-conversion.  As a result, you cannot go from a unsigned_int to an int.
            //let randomIndex = arc4random_uniform(emoijiChoices.count); gives an error.
            //randomIndex needs to be an Int not an unsigned int.  Luckily, Int(), exists where Int is a struct and takes an unsigned int as an arguement.
            //As long as there are still emojis to choose from... (choosing from an empty array will cause a problem.
            if (emoijiChoices.count > 0) {
                //Generates a random integer where max is emojiChoices.length()-1.
                let randomIndex = Int(arc4random_uniform(UInt32(emoijiChoices.count)));
                //remove any used emoji so there is never any duplicating random cards
                emoji[card.identifier] = emoijiChoices.remove(at: randomIndex);
            }
        }
        return emoji[card.identifier] ?? "?";
    }
}
