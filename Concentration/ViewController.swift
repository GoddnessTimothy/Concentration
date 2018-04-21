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
    var flipCount = 0 {
        //Property observer
        //Everytime flipCount is changed, the label will be updated.
        //Keeps UI in sync with instance variables.
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)";
        }
    }
 
    //Outlet creates an instance variable.
    //UILabel cannot be inferred.  Has to be explicitly declared.
    //Notice that there is no initialization and that there is no error.
    @IBOutlet weak var flipCountLabel: UILabel!

    //This method is connected to first button on the storyboard
    @IBAction func touchButton(_ sender: UIButton) {
        //print("Arg, a ghost!");
        flipCount += 1;
        flipCard(WithEmoji: "👻", on: sender);
    }
    
    //This method is connected to second button on storyboard.
    @IBAction func touchSecondButton(_ sender: UIButton) {
        flipCount += 1;
        flipCard(WithEmoji: "🎃", on: sender);
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

