import UIKit

//Be careful when copying and pasting buttons. Right-click button (on storyboard) to disconnect any unnecessary links (in 'touch up inside')
class ViewController: UIViewController {
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
    var emoijiChoices : Array<String> = ["👻", "🎃", "🐝", "🐴"];
    
    //This method is connected to first button on the storyboard
    @IBAction func touchButton(_ sender: UIButton) {
        //print("Arg, a ghost!");
        flipCount += 1;
        //Let defines constant.
        //Putting '!' at end of an unset optional will crash app
        //let cardNumber = touchCards.index(of: sender)!;
        if let cardNumber : Int = touchCards.index(of: sender) {
            flipCard(WithEmoji: emoijiChoices[cardNumber], on: sender)
            print("CardNumber: = \(cardNumber)");
        } else {
            print("Chosen card is not in collection.");
        }
    }
    
    /*
        A method that has a string and a sender as parameters.
        Initially button has a white background and a ghost emoji.
        When button is clicked, background turns orange and ghost emoji disappears.
        When button is clicked again, reverts back to a white background with ghost emoji.
    */
    func flipCard(WithEmoji emoji: String, on button: UIButton) {
        //\() is similar to printf(%s, name);
        print("flipCad(withEmoji): \(emoji)");
        if(button.currentTitle == emoji) {
            button.setTitle("", for: UIControlState.normal);
            button.backgroundColor = UIColor.orange;
        } else {
            button.setTitle(emoji, for: UIControlState.normal);
            button.backgroundColor = UIColor.white;
        }
    }
}
