//Make sure to implement MVC and declutter the ViewController. Don't forget/release the app without doing this <---PORTFOLIO

import UIKit
import AVFoundation
import iAd

class GameController: UIViewController {
    
    //Nav Menu
    var navOpen: Bool = false
    
    
    // Colors
    
    var darkRed = UIColor(red: 155/255, green: 6/255, blue: 0/255, alpha: 1.0)
    var darkGreen = UIColor(red: 19/255, green: 150/255, blue: 13/255, alpha: 1.0)
    var grayTextColor = UIColor(red: 200/255, green: 200/255, blue: 200/255, alpha: 1.0)
 
    
    //More Money Timer
    var moneyTimer: NSTimer?
    let staticTime: Int = 3600 // CHANGE BACK TO 3600
    var secondsLeft: Int!
    var timerInProgress: Bool = false
    
    //NSDate and Calendar Variables
    
    let userCalendar = NSCalendar.currentCalendar()
    let todayComponents = NSDateComponents()
    var today: NSDate!
    
    //Bet Increment Timers
    
    var timer: NSTimer?
    var newTimer: NSTimer?
    var pressDuration = 0

    
    //Card/Deck Variables
    
    var deck: Array<String>!
    var playingDeck: Array<String>!
    
    
    //Balance/Bet Variables

    var playerBalance = 1000
    var currentBet = 0
    
    
    //Dealer Card Variables
    
    var dealerCards: Array<String>!
    var dealerCardValues: Array<Int>!
    var dealerHandValue = 0
    
    
    //Player Card Variables
    
    var playerCards: Array<String>!
    var playerCardValues: Array<Int>!
    var playerHandValue = 0
    
    
    //Other variables
    
    var playerStand = false
    var playerDouble = false
    var playerBust = false
    var roundIsOver = false
    var cardsOnScreen = false
    var replenishAmount = 1000
    
    //Sound Effects
    
    var sfxCardShuffle: AVAudioPlayer!
    var sfxDeal: AVAudioPlayer!
    var sfxDealTwo: AVAudioPlayer!
    
    var volumeOn: Bool = true
    
    //Card Flip Animation
    
    var defaultImage: UIImage!
    var cardFlipImageArray = [UIImage]()
    
    //Card Array
    
    var cardback = [CardFlipAnimation]()
    
    
    //Navigation Labels
    
    @IBOutlet weak var menuButtonLabel: UIButton!
    @IBOutlet weak var innerMenuButtonLabel: UIButton!
    @IBOutlet weak var navMenuLabel: UIView!
    
    @IBOutlet weak var soundToggleLabel: UIButton!
    @IBOutlet weak var addMoneyToggleLabel: UIButton!
    
    
    //More Money Timer
    
    @IBOutlet weak var moneyTimerLabel: UILabel!
    @IBOutlet weak var moreMoneyButton: UIButton!
    
    
    
    
    //Text Labels
    
    @IBOutlet weak var betAmountLabel: UILabel!
    @IBOutlet weak var balanceLabel: UILabel!
    
    
    
    //Game Message Label
    
    @IBOutlet weak var gameMessageLabel: UILabel!
    
    
    //Logo
    
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var playerScoreView: UIView!
    @IBOutlet weak var dealerScoreView: UIView!
    
    
    //Betting Chip Labels
    @IBOutlet weak var blackChipLabel: UIButton!
    @IBOutlet weak var blueChipLabel: UIButton!
    @IBOutlet weak var redChipLabel: UIButton!
    @IBOutlet weak var greenChipLabel: UIButton!
    
    //Dealer's Cards
    @IBOutlet weak var dealerCardOne: CardFlipAnimation!
    @IBOutlet weak var dealerCardTwo: CardFlipAnimation!
    
    @IBOutlet weak var dealerCardThree: CardFlipAnimation!
    @IBOutlet weak var dealerCardFour: CardFlipAnimation!
    @IBOutlet weak var dealerCardFive: CardFlipAnimation!
    @IBOutlet weak var dealerCardSix: CardFlipAnimation!
    @IBOutlet weak var dealerCardSeven: CardFlipAnimation!
    @IBOutlet weak var dealerCardEight: CardFlipAnimation!
    @IBOutlet weak var dealerCardNine: CardFlipAnimation!
    @IBOutlet weak var dealerCardTen: CardFlipAnimation!
    @IBOutlet weak var dealerCardEleven: CardFlipAnimation!
    @IBOutlet weak var dealerCardTwelve: CardFlipAnimation!
    
    //Player's Cards
    @IBOutlet weak var playerCardOne: CardFlipAnimation!
    @IBOutlet weak var playerCardTwo: CardFlipAnimation!
    
    @IBOutlet weak var playerCardThree: CardFlipAnimation!
    @IBOutlet weak var playerCardFour: CardFlipAnimation!
    @IBOutlet weak var playerCardFive: CardFlipAnimation!
    @IBOutlet weak var playerCardSix: CardFlipAnimation!
    @IBOutlet weak var playerCardSeven: CardFlipAnimation!
    @IBOutlet weak var playerCardEight: CardFlipAnimation!
    @IBOutlet weak var playerCardNine: CardFlipAnimation!
    @IBOutlet weak var playerCardTen: CardFlipAnimation!
    @IBOutlet weak var playerCardEleven: CardFlipAnimation!
    @IBOutlet weak var playerCardTwelve: CardFlipAnimation!
    
    //Playing Button Labels
    @IBOutlet weak var dealButtonLabel: UIButton!
    @IBOutlet weak var doubleButtonLabel: UIButton!
    @IBOutlet weak var hitButtonLabel: UIButton!
    @IBOutlet weak var standButtonLabel: UIButton!
    @IBOutlet weak var clearButtonLabel: UIButton!
    
    //Player Hand Value
    @IBOutlet weak var handValueLabel: UILabel!
    
    //Dealer Hand Value
    @IBOutlet weak var dealerHandValueLabel: UILabel!
    
    
    
    
    //FUNCTIONS AND IBACTIONS BELOW
    
    
    //Hide Status Bar
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    //ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TEST RUN
        
        
        
        //Save Data Methods
        if let savedBalance = NSUserDefaults.standardUserDefaults().valueForKey("balance") as? Int {
            playerBalance = savedBalance
        }
        if let savedBet = NSUserDefaults.standardUserDefaults().valueForKey("bet") as? Int {
            currentBet = savedBet
        }
        
        if let savedTimeLeft = NSUserDefaults.standardUserDefaults().valueForKey("seconds") as? Int {
            secondsLeft = savedTimeLeft
        }
        
        if let savedTimerInProgress = NSUserDefaults.standardUserDefaults().valueForKey("timerInProgress") as? Bool {
            timerInProgress = savedTimerInProgress
        }
        
        if let savedPickUpTime = NSUserDefaults.standardUserDefaults().objectForKey("pickUpTime") as! NSDate! {
            today = savedPickUpTime
            print("today variable was loaded")
        }
        
        //Future Banner Ad Implementation
        self.canDisplayBannerAds = false
        
        if today == nil {
            print("TODAY WAS NIL")
            testTime()
        } else {
            //if (staticTime - Int(floor(NSDate().timeIntervalSinceDate(today)))) <= 0 {
                //testTime()
            //}
        }
        
        //Initialize the Game
        gameInit()
        updateLabels()
        addCardsToArray()
        initBetAll()
        moneyTimerInit()
        moreMoneyButton.enabled = false
        moreMoneyButton.alpha = 0.3
        
        //Prepare for animations
        cardsInitialState()
        prepareForCardFlip()
        
        //Hide the message display
        gameMessageLabel.alpha = 0.0
        gameMessageLabel.text = ""
        
        //Hide The Nav Menu
        navMenuLabel.hidden = true

        
        
        //Initializer for sound effects. Sounds have not yet been implemented.
        
        
        do {
            try sfxCardShuffle = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("cardshuffling", ofType: "wav")!))
            try sfxDeal = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("deal", ofType: "wav")!))
            try sfxDealTwo = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("deal", ofType: "wav")!))
            
            sfxCardShuffle.prepareToPlay()
            sfxDeal.prepareToPlay()
            sfxDealTwo.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
        sfxDeal.volume = 0.3
        sfxDealTwo.volume = 0.3

    }
    

    
    //TESTING
    

    
    
    
    
    //Betting Chip Buttons
    
    @IBAction func blackChipTouchDown(sender: UIButton) {
        timer?.invalidate()
        newTimer?.invalidate()
        pressDuration = 0
        print("Black Chip Touch Began")
        timer = NSTimer.scheduledTimerWithTimeInterval(0.15, target: self, selector: "blackChipBet", userInfo: nil, repeats: true)
        newTimer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "chipPressDuration", userInfo: nil, repeats: true)
    }
    
    @IBAction func blackChipButtonPressed(sender: UIButton) {
        timer?.invalidate()
        newTimer?.invalidate()
        pressDuration = 0
        
        print("Black Chip Touch Ended")
        addBet(100)
    }
    
    @IBAction func blueChipTouchDown(sender: UIButton) {
        timer?.invalidate()
        newTimer?.invalidate()
        pressDuration = 0
        print("Blue Chip Touch Began")
        timer = NSTimer.scheduledTimerWithTimeInterval(0.15, target: self, selector: "blueChipBet", userInfo: nil, repeats: true)
        newTimer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "chipPressDuration", userInfo: nil, repeats: true)
    }
    
    @IBAction func blueChipButtonPressed(sender: UIButton) {
        timer?.invalidate()
        newTimer?.invalidate()
        print("Blue Chip Touch Ended")
        addBet(25)
    }
    
    @IBAction func redChipTouchDown(sender: UIButton) {
        timer?.invalidate()
        newTimer?.invalidate()
        pressDuration = 0
        print("Red Chip Touch Began")
        timer = NSTimer.scheduledTimerWithTimeInterval(0.15, target: self, selector: "redChipBet", userInfo: nil, repeats: true)
        newTimer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "chipPressDuration", userInfo: nil, repeats: true)
    }
    
    @IBAction func redChipButtonPressed(sender: UIButton) {
        timer?.invalidate()
        newTimer?.invalidate()
        print("Red Chip Touch Ended")
        addBet(10)
    }
    
    @IBAction func greenChipTouchDown(sender: UIButton) {
        timer?.invalidate()
        newTimer?.invalidate()
        pressDuration = 0
        print("Green Chip Touch Began")
        timer = NSTimer.scheduledTimerWithTimeInterval(0.15, target: self, selector: "greenChipBet", userInfo: nil, repeats: true)
        newTimer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "chipPressDuration", userInfo: nil, repeats: true)
    }
    
    @IBAction func greenChipTouchUp(sender: UIButton) {
        timer?.invalidate()
        newTimer?.invalidate()
        print("Green Chip Touch Ended")
        addBet(1)
    }

    
    //Playing Buttons
    
    @IBAction func dealButtonPressed(sender: UIButton? = nil) {
        balanceLabel.userInteractionEnabled = false
        handValueLabel.textColor = grayTextColor
        dealerHandValueLabel.textColor = grayTextColor
        
        dealButtonLabel.enabled = false
        dealButtonLabel.alpha = 0.5
        
        if currentBet <= 0 && playerBalance <= 0 {
            initialButtonState()
            balanceLabel.userInteractionEnabled = true
            return showGameMessage("You're out of money! Add some more.")
        }
        
        if cardsOnScreen == true {
            resetGameState()
            cardsLeaveScreen()
            NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: "extendedDeal", userInfo: nil, repeats: false)
        } else {
            extendedDeal()
        }

    }

    @IBAction func doubleButtonPressed(sender: UIButton) {
        if playerBalance < currentBet {
            showGameMessage("You don't have enough money to double down!")
        } else {
            doubleButtonLabel.fadeIn()
            disableGameButtons()
            reShuffle()
            doubleAction()
            updateHandLabel()
            NSTimer.scheduledTimerWithTimeInterval(0.3, target: self, selector: "checkResult", userInfo: nil, repeats: false)
            NSTimer.scheduledTimerWithTimeInterval(0.3, target: self, selector: "flipCardFour", userInfo: nil, repeats: false)
            NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "dealerPrepareToPlay", userInfo: nil, repeats: false)
            
        }
        
        print("Double button pressed")

    }
    
    @IBAction func hitButtonPressed(sender: UIButton) {
        hitButtonLabel.enabled = false
        hitButtonLabel.alpha = 0.5
        doubleButtonLabel.alpha = 0.5
        doubleButtonLabel.enabled = false
        hitButtonLabel.fadeIn()
        reShuffle()
        hitAction()
        updateHandLabel()
        NSTimer.scheduledTimerWithTimeInterval(0.3, target: self, selector: "checkResult", userInfo: nil, repeats: false)
    }
    
    @IBAction func standButtonPressed(sender: UIButton) {
        showDealerScore()
        standButtonLabel.fadeIn()
        flipCardFour()
        disableGameButtons()
        reShuffle()
        updateHandLabel()
        checkResult()
        playerStand = true
        NSTimer.scheduledTimerWithTimeInterval(0.35, target: self, selector: "dealerPrepareToPlay", userInfo: nil, repeats: false)
        print("Stand button pressed")
    }
    
    @IBAction func clearButtonPressed(sender: UIButton) {
        clearButtonLabel.fadeIn()
        playerBalance += currentBet
        currentBet -= currentBet
        updateLabels()
        
    }
    
    
    
    
    
    //Navigation
    
    @IBAction func menuButtonPressed(sender: AnyObject) {
        menuButtonLabel.fadeIn()
        menuSlideOut()
    }
    
    @IBAction func innerMenuButtonPressed(sender: UIButton) {
        innerMenuButtonLabel.fadeIn()
        menuSlideIn()
        
    }
    
    @IBAction func swipeRight(sender: UISwipeGestureRecognizer) {
        
        if !navOpen {
            menuSlideOut()
        }
        
    }

    @IBAction func swipeLeft(sender: UISwipeGestureRecognizer) {
        
        if navOpen {
            menuSlideIn()
        }
        
    }
    
    @IBAction func soundTogglePressed(sender: UIButton) {
        soundToggle()
        
    }
    
    @IBAction func addMoneyPressed(sender: UIButton) {
        addMoneyToggleLabel.fadeIn()
        
        if playerBalance <= 0 && currentBet <= 0 {
            
            playerBalance += replenishAmount
            updateLabels()
            showGameMessage("Awesome! Let's keep playing!")
            
        } else {
            showGameMessage("You still have money!")
        }
        
        menuSlideIn()
        
    }
    
    @IBAction func moreMoneyButtonPressed(sender: UIButton) {
        moreMoneyButton.fadeIn()
        moreMoneyButton.enabled = false
        moreMoneyButton.alpha = 0.3
        playerBalance += 2000
        timerInProgress = false
        moneyTimerInit()
        
        updateLabels()
        
        menuSlideIn()
        
    }
    

    
    
    
    
    
    
    
    
    
    //Navigation Functions
    
    func menuSlideOut() {
        navOpen = true
        navMenuLabel.hidden = false
        navMenuLabel.slideFromLeft()
    }
    
    func menuSlideIn() {
        navOpen = false
        navMenuLabel.hidden = true
        navMenuLabel.slideFromRight()
    }
    
 
    //Game Initializers and Mechanics
    
    func gameInit() {
        
        gameMessageLabel.layer.shadowOffset = CGSize(width: -3, height: 0)
        gameMessageLabel.layer.shadowOpacity = 1
        gameMessageLabel.layer.shadowRadius = 5
        
        deck = Cards().makeDeck()
        playingDeck = Cards().shuffleDeck(deck)
        
        dealerHandValueLabel.text = ""
        handValueLabel.text = ""
        
        doubleButtonLabel.enabled = false
        doubleButtonLabel.alpha = 0.5
        
        hitButtonLabel.enabled = false
        hitButtonLabel.alpha = 0.5
        
        standButtonLabel.enabled = false
        standButtonLabel.alpha = 0.5
        
        playerScoreView.layer.cornerRadius = 3.0
        dealerScoreView.layer.cornerRadius = 3.0
        
        playerScoreView.alpha = 0.0
        dealerScoreView.alpha = 0.0
    }
    
    func addCardsToArray() {
        cardback += [playerCardOne, playerCardTwo, playerCardThree, playerCardFour, playerCardFive, playerCardSix, playerCardSeven, playerCardEight, playerCardNine, playerCardTen, playerCardEleven, playerCardTwelve, dealerCardOne, dealerCardTwo, dealerCardThree, dealerCardFour, dealerCardFive, dealerCardSix, dealerCardSeven, dealerCardEight, dealerCardNine, dealerCardTen, dealerCardEleven,dealerCardTwelve]
        cardStyles()
        print(cardback.count)
    }
    
    func cardStyles() {
        for card in cardback {
            card.layer.shadowOffset = CGSize(width: -3, height: 0)
            card.layer.shadowOpacity = 1
            card.layer.shadowRadius = 5
        }
    }
    
    func disableBets() {
        blackChipLabel.enabled = false
        blackChipLabel.alpha = 0.5
        
        blueChipLabel.enabled = false
        blueChipLabel.alpha = 0.5
        
        redChipLabel.enabled = false
        redChipLabel.alpha = 0.5
        
        greenChipLabel.enabled = false
        greenChipLabel.alpha = 0.5
    }
    
    func enableBets() {
        blackChipLabel.enabled = true
        blackChipLabel.alpha = 1.0
        
        blueChipLabel.enabled = true
        blueChipLabel.alpha = 1.0
        
        redChipLabel.enabled = true
        redChipLabel.alpha = 1.0
        
        greenChipLabel.enabled = true
        greenChipLabel.alpha = 1.0
    }
    
    func disableGameButtons() {
        dealButtonLabel.enabled = false
        dealButtonLabel.alpha = 0.5
        
        doubleButtonLabel.enabled = false
        doubleButtonLabel.alpha = 0.5
        
        hitButtonLabel.enabled = false
        hitButtonLabel.alpha = 0.5
        
        standButtonLabel.enabled = false
        standButtonLabel.alpha = 0.5
        
        clearButtonLabel.enabled = false
        clearButtonLabel.alpha = 0.5
    }
    
    func initialButtonState() {
        doubleButtonLabel.enabled = false
        doubleButtonLabel.alpha = 0.5
        
        hitButtonLabel.enabled = false
        hitButtonLabel.alpha = 0.5
        
        standButtonLabel.enabled = false
        standButtonLabel.alpha = 0.5
        
        clearButtonLabel.enabled = true
        clearButtonLabel.alpha = 1.0
        
        dealButtonLabel.enabled = true
        dealButtonLabel.alpha = 1.0
    }
    
    func reShuffle() {
        if Double(playingDeck.count) <= (208/2) {
            playShuffle()
            deck = Cards().makeDeck()
            playingDeck = Cards().shuffleDeck(deck)
            
            let alertController = UIAlertController(title: "Reshuffling", message:
                "Reshuffling cards now.", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Got it!", style: UIAlertActionStyle.Default,handler: nil))
            
            self.presentViewController(alertController, animated: true, completion: nil)
            
        }
    }
    
    func saveData() {
        //Balance and Bet
        NSUserDefaults.standardUserDefaults().setInteger(playerBalance, forKey: "balance")
        NSUserDefaults.standardUserDefaults().setInteger(currentBet, forKey: "bet")
        NSUserDefaults.standardUserDefaults().setInteger(secondsLeft, forKey: "seconds")
        NSUserDefaults.standardUserDefaults().setBool(timerInProgress, forKey: "timerInProgress")
        NSUserDefaults.standardUserDefaults().setObject(today, forKey: "pickUpTime")
        
        //Synchronize the Saved Data
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    
    //Play Sounds
    func playCardFlip() {
        if sfxDeal.playing == true {
            sfxDealTwo.play()
        } else {
            sfxDeal.play()
        }
    }
    
    func playShuffle() {
        sfxCardShuffle.play()
    }
    
    func soundToggle() {
        if volumeOn == true {
            soundToggleLabel.setTitleColor(darkRed, forState: UIControlState.Normal)
            soundToggleLabel.setTitle("Sound: Off", forState: UIControlState.Normal)
            volumeOn = false
            sfxCardShuffle.volume = 0
            sfxDeal.volume = 0
            sfxDealTwo.volume = 0
        } else {
            soundToggleLabel.setTitle("Sound: On", forState: UIControlState.Normal)
            soundToggleLabel.setTitleColor(darkGreen, forState: UIControlState.Normal)
            volumeOn = true
            sfxCardShuffle.volume = 1.0
            sfxDealTwo.volume = 0.3
            sfxDeal.volume = 0.3
        }
    }
    
    
    //Labels and Messages
    
    func updateHandLabel() {
        if handValueLabel.text != "\(playerHandValue)" {
            handValueLabel.slideFromRight()
            handValueLabel.text = "\(playerHandValue)"
        }

        if playerTurnOver() {
            if dealerHandValueLabel.text != "\(dealerHandValue)" {
                dealerHandValueLabel.slideFromRight()
                dealerHandValueLabel.text = "\(dealerHandValue)"
            }
        }
    }
    
    func updateLabels() {
        balanceLabel.text = "$\(playerBalance)"
        betAmountLabel.text = "$\(currentBet)"
    }
    
    func insufficientBetWarning() {
        showGameMessage("You must bet at least $1.00 to play!")
        gameMessageLabel.fadeOut(0.30, delay: 2.0)

    }
    
    func insufficientFundsWarning() {
        showGameMessage("You don't have enough money! Your balance is: $\(playerBalance)")
        gameMessageLabel.fadeOut(0.30, delay: 2.0)
    }
    
    func showDealerScore() {
        dealerScoreView.fadeIn()
        dealerScoreView.alpha = 1.0
        
    }
    
    func labelsChangeColor() {
        UIView.transitionWithView(self.balanceLabel, duration: 0.1, options: .TransitionCrossDissolve, animations: { self.balanceLabel.textColor = self.darkRed }, completion: nil)
        UIView.transitionWithView(self.betAmountLabel, duration: 0.1, options: .TransitionCrossDissolve, animations: { self.betAmountLabel.textColor = self.darkGreen }, completion: nil)
        
        NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "labelsTurnWhite", userInfo: nil, repeats: false)
    }
    
    func labelsTurnWhite() {
        UIView.transitionWithView(self.balanceLabel, duration: 0.1, options: .TransitionCrossDissolve, animations: { self.balanceLabel.textColor = self.grayTextColor }, completion: nil)
        UIView.transitionWithView(self.betAmountLabel, duration: 0.1, options: .TransitionCrossDissolve, animations: { self.betAmountLabel.textColor = self.grayTextColor }, completion: nil)

    }
    
    func showGameMessage(message: String = "You forgot to enter text") {
        gameMessageLabel.text = message
        gameMessageLabel.alpha = 0.0
        gameMessageLabel.slideFromRight()
        gameMessageLabel.alpha = 1.0
        
        
    }
    
    
    //Bet Functions
    
    func addBet(desiredAmount:Int, sender: String = "") {
        if (playerBalance - desiredAmount) < 0 {
            if sender == "allIn" {
                insufficientFundsWarning()
                newTimer?.invalidate()
                timer?.invalidate()
                pressDuration = 0
            } else {
                insufficientFundsWarning()
            }
        } else {
            playerBalance -= desiredAmount
            currentBet += desiredAmount
            saveData()
            labelsChangeColor()

        }
        
        updateLabels()
    }
    
    func greenChipBet() {
        if pressDuration >= 2 {
            newTimer?.invalidate()
            pressDuration = 0
            timer?.invalidate()
            timer = NSTimer.scheduledTimerWithTimeInterval(0.04, target: self, selector: "greenChipBet", userInfo: nil, repeats: true)
        }
        
        if playerBalance - 1 < 0 {
            timer?.invalidate()
        } else {
            addBet(1)
        }
    }
    
    func redChipBet() {
        if pressDuration >= 2 {
            newTimer?.invalidate()
            pressDuration = 0
            timer?.invalidate()
            timer = NSTimer.scheduledTimerWithTimeInterval(0.04, target: self, selector: "redChipBet", userInfo: nil, repeats: true)
        }
        
        if playerBalance - 10 < 0 {
            timer?.invalidate()
        } else {
            addBet(10)
        }
    }
    
    func blueChipBet() {
        if pressDuration >= 2 {
            newTimer?.invalidate()
            pressDuration = 0
            timer?.invalidate()
            timer = NSTimer.scheduledTimerWithTimeInterval(0.04, target: self, selector: "blueChipBet", userInfo: nil, repeats: true)
        }
        
        if playerBalance - 25 < 0 {
            timer?.invalidate()
        } else {
            addBet(25)
        }
    }
    
    func blackChipBet() {
        if pressDuration >= 2 {
            newTimer?.invalidate()
            pressDuration = 0
            timer?.invalidate()
            timer = NSTimer.scheduledTimerWithTimeInterval(0.04, target: self, selector: "blackChipBet", userInfo: nil, repeats: true)
        }
        
        if playerBalance - 100 < 0 {
            timer?.invalidate()
        } else {
            addBet(100)
        }
    }
    
    func initBetAll() {
        balanceLabel.userInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: "betAll")
        tapGesture.numberOfTapsRequired = 1
        balanceLabel.addGestureRecognizer(tapGesture)
    }
    
    func betAll() {
        addBet(playerBalance, sender: "allIn")
    }
    
    func chipPressDuration() {
        pressDuration += 1
        print("Held for: \(pressDuration) seconds")
        
    }
    
    
    //Gameplay Functions
    func extendedDeal() {
        if currentBet <= 0 {
            dealButtonLabel.fadeIn()
            dealButtonLabel.enabled = true
            dealButtonLabel.alpha = 1.0
            balanceLabel.userInteractionEnabled = true
            insufficientBetWarning()
            
        } else {
            dealButtonLabel.enabled = false
            dealButtonLabel.alpha = 0.5
            
            if gameMessageLabel.text == "" {
                playerScoreView.alpha = 1.0
                cardsOnScreen = true
                dealButtonLabel.fadeIn()
                cardOneToDeal()
                disableBets()
                reShuffle()
                buttonStateOnDeal()
                dealAction()
                updateHandLabel()
                checkResult()
            } else {
                playerScoreView.alpha = 1.0
                cardsOnScreen = true
                gameMessageLabel.fadeOut(0.3, delay: 0)
                dealButtonLabel.fadeIn()
                cardOneToDeal()
                disableBets()
                reShuffle()
                buttonStateOnDeal()
                dealAction()
                updateHandLabel()
                checkResult()
            }
            
        }
        
        
    }

    func dealAction() {
        dealerCards = []
        dealerCardValues = []
        
        playerCards = []
        playerCardValues = []
        
        var dealtCards = Cards().dealCards(playingDeck)
        playingDeck[0...3] = []
        
        dealerCards.append(dealtCards[0])
        dealerCards.append(dealtCards[1])
        
        playerCards.append(dealtCards[2])
        playerCards.append(dealtCards[3])
        
        dealerCardValues.append(individualCards(dealerCards[0]))
        dealerCardValues.append(individualCards(dealerCards[1]))
        
        playerCardValues.append(individualCards(playerCards[0]))
        playerCardValues.append(individualCards(playerCards[1]))
        
        dealerHandValue = cardsValue(dealerCards[0], secondCard: dealerCards[1])
        playerHandValue = cardsValue(playerCards[0], secondCard: playerCards[1])
        
        //dealerCardOne.image = UIImage(named: "\(dealerCards[0])")
        //playerCardOne.image = UIImage(named: "\(playerCards[0])")
        //playerCardTwo.image = UIImage(named: "\(playerCards[1])")

        
    }
    
    func hitAction() {
        let dealtCard = playingDeck[0]
        playingDeck[0...0] = []
        
        playerCards.append(dealtCard)
        let lastIndex = playerCards.last
        
        playerCardValues.append(individualCards(lastIndex!))
        
        
        playerHandValue = playerHandValue + playerCardValues.last!
        
        showNextCard()
    }
    
    func doubleAction() {
        playerBalance = playerBalance - currentBet
        currentBet = currentBet + currentBet
        betAmountLabel.text = "$\(currentBet)"
        balanceLabel.text = "$\(playerBalance)"
        
        let dealtCard = playingDeck[0]
        playingDeck[0...0] = []
        
        playerCards.append(dealtCard)
        let lastIndex = playerCards.last
        
        playerCardValues.append(individualCards(lastIndex!))
        
        playerHandValue = playerHandValue + playerCardValues.last!
        
        showNextCard()
        
        NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "playerDidDoubleDown", userInfo: nil, repeats: false)
    }
    
    func buttonStateOnDeal() {
        dealButtonLabel.enabled = false
        dealButtonLabel.alpha = 0.5
        
        doubleButtonLabel.enabled = true
        doubleButtonLabel.alpha = 1.0
        
        hitButtonLabel.enabled = true
        hitButtonLabel.alpha = 1.0
        
        standButtonLabel.enabled = true
        standButtonLabel.alpha = 1.0
        
        clearButtonLabel.enabled = false
        clearButtonLabel.alpha = 0.5
    }
    
    func playerDidDoubleDown() {
        playerDouble = true
    }
    
    
    //Card Deck Manipulation
    
    func individualCards(desiredCard: String) -> Int {
        return Cards().cardValues(desiredCard)
    }
    
    func cardsValue(firstCard: String, secondCard: String) -> Int {
        let cardOne = Cards().cardValues(firstCard)
        let cardTwo = Cards().cardValues(secondCard)
        
        return cardOne + cardTwo
        
        
    }
    
    func playerAceBehavior() -> Bool {
        var newHandValue = 0
        if playerCardValues.contains(11) {
            let ace = Int(playerCardValues.indexOf(11)!)
            playerCardValues[ace] = Int(1)
            
            for num in playerCardValues {
                newHandValue += num
            }
            
            playerHandValue = newHandValue
            updateHandLabel()
            return true
        } else {
            return false
        }
    }
    
    func showNextCard() {
        if playerCardThree.hidden == true {
            dealAnyCard(playerCardThree)
        } else if playerCardFour.hidden == true {
            dealAnyCard(playerCardFour)
        } else if playerCardFive.hidden == true {
            dealAnyCard(playerCardFive)
        } else if playerCardSix.hidden == true {
            dealAnyCard(playerCardSix)
        } else if playerCardSeven.hidden == true {
            dealAnyCard(playerCardSeven)
        } else if playerCardEight.hidden == true {
            dealAnyCard(playerCardEight)
        } else if playerCardNine.hidden == true {
            dealAnyCard(playerCardNine)
        } else if playerCardTen.hidden == true {
            dealAnyCard(playerCardTen)
        } else if playerCardEleven.hidden == true {
            dealAnyCard(playerCardEleven)
        } else if playerCardTwelve.hidden == true {
            dealAnyCard(playerCardTwelve)
        }
    }
    
    func resetCards() {
        playerCardOne.image = UIImage(named: "cardback")
        playerCardOne.hidden = false
        playerCardTwo.image = UIImage(named: "cardback")
        playerCardTwo.hidden = false
        playerCardThree.hidden = true
        playerCardFour.hidden = true
        playerCardFive.hidden = true
        playerCardSix.hidden = true
        playerCardSeven.hidden = true
        playerCardEight.hidden = true
        playerCardNine.hidden = true
        playerCardTen.hidden = true
        playerCardEleven.hidden = true
        playerCardTwelve.hidden = true
        
        dealerCardOne.image = UIImage(named: "cardback")
        dealerCardOne.hidden = false
        dealerCardTwo.image = UIImage(named: "cardback")
        dealerCardTwo.hidden = false
        dealerCardThree.hidden = true
        dealerCardFour.hidden = true
        dealerCardFive.hidden = true
        dealerCardSix.hidden = true
        dealerCardSeven.hidden = true
        dealerCardEight.hidden = true
        dealerCardNine.hidden = true
        dealerCardTen.hidden = true
        dealerCardEleven.hidden = true
        dealerCardTwelve.hidden = true
    }
    
    
    //Outcome Functions
    
    func playerWin() {
        print("You win")
        roundIsOver = true
        endGame("playerWin")
    }
    
    func playerBlackJack() {
        print("You got Blackjack")
        roundIsOver = true
        endGame("playerBlackJack")
    }
    
    func dealerWin() {
        print("Dealer wins")
        roundIsOver = true
        endGame("dealerWin")
        
    }
    
    func dealerBlackJack() {
        print("Dealer got Blackjack")
        roundIsOver = true
        endGame("dealerBlackJack")
    }
    
    func push() {
        roundIsOver = true
        endGame("push")
    }
    
    func bust() {
        print("You busted")
        roundIsOver = true
        endGame("bust")
        dealerScoreView.alpha = 1.0
        dealerScoreView.hidden = false
        
    }
    
    func dealerBust() {
        print("Dealer busted")
        roundIsOver = true
        endGame("dealerBust")
    }
    
    func playerTurnOver() -> Bool {
        if playerStand == true{
            return true
        } else if playerDouble == true {
            return true
        } else if playerBust == true {
            return true
        } else {
            return false
        }
        
    }
    
    func roundOver() -> Bool {
        return true
    }
    
    func checkResult() {
        
        if playerCards.count == 2 {
            if playerHandValue == 21 && dealerHandValue == 21 {
                showDealerScore()
                push()
            } else if playerHandValue == 21 {
                showDealerScore()
                playerStand = true
                updateHandLabel()
                playerBlackJack()
            } else if dealerHandValue == 21 {
                showDealerScore()
                playerStand = true
                updateHandLabel()
                dealerBlackJack()
            } else if playerHandValue == 22 {
                showDealerScore()
                playerAceBehavior()
                updateHandLabel()
            } else if dealerHandValue == 22 {
                showDealerScore()
                dealerAceBehavior()
                updateHandLabel()
            }
        } else if playerCards.count >= 3 {
            if playerHandValue >= 22 {
                playerAceBehavior()
                if playerHandValue >= 22 {
                    playerStand = true
                    updateHandLabel()
                    hitButtonLabel.enabled = false
                    hitButtonLabel.alpha = 0.5
                    bust()
                } else {
                    hitButtonLabel.enabled = true
                    hitButtonLabel.alpha = 1.0
                }
            } else {
                hitButtonLabel.enabled = true
                hitButtonLabel.alpha = 1.0
            }
        }
    }
    

    // Dealer Play Functions
    
    func dealerPrepareToPlay() {
        //This function is initialized as a failsafe in case it is used when a player's turn is NOT over.
        if playerTurnOver() {
            if !roundIsOver {
                updateHandLabel()
                dealerPlay()
            }
        }
    }
    
    func dealerPlay() {
        //While dealer state is not stand or bust, this will execute
        if shouldDealerHit() {
            dealerHit()
        } else {
            roundIsOver = true
            NSTimer.scheduledTimerWithTimeInterval(0.35, target: self, selector: "dealerCheckResults", userInfo: nil, repeats: false)
        }
        
    }
    
    func dealerHit() {
        //Dealer's actions when hitting
        reShuffle()
        
        let dealtCard = playingDeck[0]
        playingDeck[0...0] = []
        
        dealerCards.append(dealtCard)
        let lastIndex = dealerCards.last
        
        dealerCardValues.append(individualCards(lastIndex!))
        
        dealerHandValue = dealerHandValue + dealerCardValues.last!
        
        
        if dealerScoreView.alpha == 0.0 {
            dealerScoreView.alpha = 1.0
        }
        
        
        NSTimer.scheduledTimerWithTimeInterval(0.35, target: self, selector: "dealerShowNextCard", userInfo: nil, repeats: false)
        //dealerShowNextCard()
    }
    
    func shouldDealerHit() -> Bool {
        /*if dealerHandValue > playerHandValue {
            return false
        } else if */
        
        if dealerHandValue <= 16 {
            return true
        } else if dealerHandValue == 17 {
            if dealerCardValues.contains(11) {
                dealerAceBehavior()
                return true
            }
        } else if dealerHandValue >= 18 {
            return false
        } else if dealerHandValue < playerHandValue {
            return true
        } else {
            return false
        }
        
        return false
    }
    
    func dealerAceBehavior() -> Bool {
        var newHandValue = 0
        if dealerCardValues.contains(11) {
            let ace = Int(dealerCardValues.indexOf(11)!)
            dealerCardValues[ace] = Int(1)
            
            for num in dealerCardValues {
                newHandValue += num
            }
            dealerHandValue = newHandValue
            updateHandLabel()
            return true
        } else {
            return false
        }
    }
    
    func dealerCheckResults() {
        if dealerHandValue <= 21 {
            if dealerHandValue == playerHandValue {
                push()
            }
            else if dealerHandValue > playerHandValue {
                dealerWin()
            } else if dealerHandValue < playerHandValue {
                playerWin()
            }
        } else if dealerHandValue >= 22 {
            dealerAceBehavior()
            if dealerHandValue >= 22 {
                dealerBust()
            } else {
                roundIsOver = false
                dealerPlay()
            }
        }
    }
    
    func dealerShowNextCard() {
        
        if dealerCardThree.hidden == true {
            dealAnyCard(dealerCardThree)
        } else if dealerCardFour.hidden == true {
            dealAnyCard(dealerCardFour)
        } else if dealerCardFive.hidden == true {
            dealAnyCard(dealerCardFive)
        } else if dealerCardSix.hidden == true {
            dealAnyCard(dealerCardSix)
        } else if dealerCardSeven.hidden == true {
            dealAnyCard(dealerCardSeven)
        } else if dealerCardEight.hidden == true {
            dealAnyCard(dealerCardEight)
        } else if dealerCardNine.hidden == true {
            dealAnyCard(dealerCardNine)
        } else if dealerCardTen.hidden == true {
            dealAnyCard(dealerCardTen)
        } else if dealerCardEleven.hidden == true {
            dealAnyCard(dealerCardEleven)
        } else if dealerCardTwelve.hidden == true {
            dealAnyCard(dealerCardTwelve)
        }
        
        updateHandLabel()
        

        
        NSTimer.scheduledTimerWithTimeInterval(0.35, target: self, selector: "dealerPlay", userInfo: nil, repeats: false)
        
    }
    
    
    // Add more money
    
    func addMoney() {
        let alertController = UIAlertController(title: "You're out of money!", message:
            "It looks like you're out of money! Luckily, you get to replenish your chips for free! I don't believe in microtransactions that hinder gameplay, and I want you to keep on Blackjackin' it up! Please consider, however, leaving a review in the App Store, as I am an independent developer and every critique helps! Thanks, and have fun!", preferredStyle: UIAlertControllerStyle.Alert)

        let thanksButton = UIAlertAction(title: "Submit", style: UIAlertActionStyle.Default,handler: {
            (alert: UIAlertAction!) in
            if let textField = alertController.textFields?.first as? UITextField!{
                
                if textField.text == Optional("") {
                    self.addMoney()
                } else {
                    self.playerBalance = Int(textField.text!)!
                    self.updateLabels()
                }
            }
        })
        
        alertController.addAction(thanksButton)
        
        thanksButton.enabled = false
        
        
        alertController.addTextFieldWithConfigurationHandler { (textField) -> Void in
            textField.placeholder = "Enter desired amount! (Max $1,000)"
            textField.keyboardType = UIKeyboardType.NumberPad
            
            
            NSNotificationCenter.defaultCenter().addObserverForName(UITextFieldTextDidChangeNotification, object: textField, queue: NSOperationQueue.mainQueue()) { (notification) in
                if Int(textField.text!) > 1000 {
                    thanksButton.enabled = false
                } else if Int(textField.text!) <= 0 {
                    thanksButton.enabled = false
                } else if textField.text == Optional("") {
                    thanksButton.enabled = false
                } else {
                    thanksButton.enabled = true
                }
                //thanksButton.enabled = Int(textField.text!) <= 10000
                //thanksButton.enabled = Int(textField.text!) > 0
                
            }
        }
        
        self.presentViewController(alertController, animated: true, completion: nil)
        
    }
    
    func moneyTimerInit() {
        print("TIMER IN PROGRESS = \(timerInProgress)")
        if secondsLeft != nil {
            if secondsLeft <= 0 {
                testTime()
            }
        }
        
        if !timerInProgress {
            secondsLeft = staticTime - Int(floor(NSDate().timeIntervalSinceDate(today)))
        } else {
            secondsLeft = staticTime - Int(floor(NSDate().timeIntervalSinceDate(today)))
            
            if secondsLeft <= 0 {
                secondsLeft = 0
            }
        }
        timerInProgress = true
        moneyTimerLabel.text = convert(secondsLeft)
        moneyTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "moreMoneyTimer", userInfo: nil, repeats: true)
    }
    
    func moreMoneyTimer() {
        secondsLeft = secondsLeft - 1
        
        if secondsLeft <= 0 {
            secondsLeft = 0
            moneyTimer?.invalidate()
            moneyTimerLabel.text = convert(secondsLeft)
            moreMoneyButton.enabled = true
            moreMoneyButton.alpha = 1.0
        }
        
        moneyTimerLabel.text = convert(secondsLeft)
        
        saveData()
    }
    
    func testTime() {
        todayComponents.year = NSCalendar.currentCalendar().component(NSCalendarUnit.Year, fromDate: NSDate())
        todayComponents.month = NSCalendar.currentCalendar().component(NSCalendarUnit.Month, fromDate: NSDate())
        todayComponents.day = NSCalendar.currentCalendar().component(NSCalendarUnit.Day, fromDate: NSDate())
        todayComponents.hour = NSCalendar.currentCalendar().component(NSCalendarUnit.Hour, fromDate: NSDate())
        todayComponents.minute = NSCalendar.currentCalendar().component(NSCalendarUnit.Minute, fromDate: NSDate())
        todayComponents.second = NSCalendar.currentCalendar().component(NSCalendarUnit.Second, fromDate: NSDate())
        today = userCalendar.dateFromComponents(todayComponents)!
        print("Date Timer Started: \(today)")
        
        //NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "testTime2", userInfo: nil, repeats: true)
    }
    
    func testTime2() {
        let now = NSDate()
        //print(floor(now.timeIntervalSinceDate(today)))
        
        print(staticTime - Int(floor(now.timeIntervalSinceDate(today))))
        
        
    }
    
    
    func convert(secs: Int) -> String {
        let hours = String(format: "%02d", (secs/3600))
        let minutes = String(format: "%02d", (secs % 3600) / 60)
        let seconds = String(format: "%02d", (secs % 3600) % 60)
        
        return "\(hours):\(minutes):\(seconds)"
    }
    
    
    //End Game and Reset State
    
    func endGame(messageID: String) {
        enableBets()
        initialButtonState()
        
        if playerHandValue > dealerHandValue {
            handValueLabel.textColor = darkGreen
            dealerHandValueLabel.textColor = darkRed
        } else if dealerHandValue > playerHandValue {
            handValueLabel.textColor = darkRed
            dealerHandValueLabel.textColor = darkGreen
        } else {
            handValueLabel.textColor = darkRed
            dealerHandValueLabel.textColor = darkRed
        }
        
        if messageID == "playerWin" {
            handValueLabel.textColor = darkGreen
            dealerHandValueLabel.textColor = darkRed
            
            playerBalance += currentBet
            updateLabels()
            
            dealerCardTwo.image = UIImage(named: "\(dealerCards[1])")
            
            showGameMessage("You win!")
        }
        
        else if messageID == "playerBlackJack" {
            handValueLabel.textColor = darkGreen
            dealerHandValueLabel.textColor = darkRed
            
            playerBalance += currentBet
            updateLabels()
            
            sfxDealTwo.play()
            dealerCardTwo.image = UIImage(named: "\(dealerCards[1])")
            
            showGameMessage("You got Blackjack!")
        }
        
        else if messageID == "dealerWin" {
            handValueLabel.textColor = darkRed
            dealerHandValueLabel.textColor = darkGreen
            
            playerBalance -= currentBet
            updateLabels()
            
            dealerCardTwo.image = UIImage(named: "\(dealerCards[1])")
            
            showGameMessage("Dealer won!")
            
        }
        
        else if messageID == "dealerBlackJack" {
            handValueLabel.textColor = darkRed
            dealerHandValueLabel.textColor = darkGreen
            
            playerBalance -= currentBet
            updateLabels()
            
            sfxDealTwo.play()
            dealerCardTwo.image = UIImage(named: "\(dealerCards[1])")
            
            showGameMessage("Dealer got Blackjack!")

        }
        
        else if messageID == "push" {
            handValueLabel.textColor = darkRed
            dealerHandValueLabel.textColor = darkRed
            
            updateLabels()
            
            dealerCardTwo.image = UIImage(named: "\(dealerCards[1])")
            
            showGameMessage("Push!")
        }
        
        else if messageID == "bust" {
            handValueLabel.textColor = darkRed
            dealerHandValueLabel.textColor = darkGreen
            
            playerBalance -= currentBet
            updateLabels()
            
            dealerCardTwo.image = UIImage(named: "\(dealerCards[1])")
            
            showGameMessage("Bust!")
        }
        
        else if messageID == "dealerBust" {
            handValueLabel.textColor = darkGreen
            dealerHandValueLabel.textColor = darkRed
            
            playerBalance += currentBet
            updateLabels()
            
            dealerCardTwo.image = UIImage(named: "\(dealerCards[1])")
            
            showGameMessage("Dealer busted!")
        }
        
        if playerBalance < 0 {
            playerBalance += currentBet
            currentBet -= currentBet
            updateLabels()
            if playerBalance <= 0 {
                showGameMessage("You're out of money! Add some more.")
                //NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: "addMoney", userInfo: nil, repeats: false)
            }

        }
        
        if playerDouble == true {
            playerDouble = false
            playerBalance += (currentBet / 2)
            currentBet -= (currentBet / 2)
            updateLabels()
            
        }
        
        balanceLabel.userInteractionEnabled = true
        saveData()
        updateLabels()
        
    }
    
    func resetGameState() {
        
        resetCards()
        enableBets()
        
        playerScoreView.fadeOut()
        playerScoreView.alpha = 0.0
        
        dealerScoreView.fadeOut()
        dealerScoreView.alpha = 0.0
        
        playerStand = false
        playerDouble = false
        playerBust = false
        roundIsOver = false
        
        dealerCards = []
        dealerCardValues = []
        
        playerCards = []
        playerCardValues = []
        
        dealerHandValue = 0
        playerHandValue = 0
        
        dealerHandValueLabel.text = ""
        handValueLabel.text = ""
        
        cardsInitialState()
        
        
    }


    //Animations
    func prepareForCardFlip() {
        
        defaultImage = UIImage(named: "cardback.png")
        
        for var x = 1; x<=5; x++ {
            let img = UIImage(named: "img\(x).png")
            cardFlipImageArray.append(img!)
        }
        
    }
    
    func cardsInitialState() {
        playerCardOne.alpha = 0.0
        playerCardTwo.alpha = 0.0
        
        dealerCardOne.alpha = 0.0
        dealerCardTwo.alpha = 0.0
    }
    
    
    func cardOneToDeal() {
        playerCardOne.alpha = 1.0
        playerCardOne.slideFromRight(0.25, completionDelegate: nil)
        NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "playCardFlip", userInfo: nil, repeats: false)
        NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "flipCardOne", userInfo: nil, repeats: false)
    }
    
    func cardTwoToDeal() {
        dealerCardOne.alpha = 1.0
        dealerCardOne.slideFromRight(0.25, completionDelegate: nil)
        NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "playCardFlip", userInfo: nil, repeats: false)
        NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "flipCardTwo", userInfo: nil, repeats: false)
    }
    
    func cardThreeToDeal() {
        playerCardTwo.alpha = 1.0
        playerCardTwo.slideFromRight(0.25, completionDelegate: nil)
        NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "playCardFlip", userInfo: nil, repeats: false)
        NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "flipCardThree", userInfo: nil, repeats: false)
    }
    
    func cardFourToDeal() {
        dealerCardTwo.alpha = 1.0
        dealerCardTwo.slideFromRight(0.25, completionDelegate: nil)
    }
    
    
    func flipCardOne() {
        self.playerCardOne.image = UIImage(named: "\(playerCards[0])")
        self.playerCardOne.playFlipAnimation(cardFlipImageArray)
        NSTimer.scheduledTimerWithTimeInterval(0.2, target: self, selector: "cardTwoToDeal", userInfo: nil, repeats: false)
    }
    
    func flipCardTwo() {
        self.dealerCardOne.image = UIImage(named: "\(dealerCards[0])")
        self.dealerCardOne.playFlipAnimation(cardFlipImageArray)
        NSTimer.scheduledTimerWithTimeInterval(0.2, target: self, selector: "cardThreeToDeal", userInfo: nil, repeats: false)
    }

    func flipCardThree() {
        self.playerCardTwo.image = UIImage(named: "\(playerCards[1])")
        self.playerCardTwo.playFlipAnimation(cardFlipImageArray)
        NSTimer.scheduledTimerWithTimeInterval(0.2, target: self, selector: "cardFourToDeal", userInfo: nil, repeats: false)
    }
    
    func flipCardFour() {
        playCardFlip()
        self.dealerCardTwo.image = UIImage(named: "\(dealerCards[1])")
        self.dealerCardTwo.playFlipAnimation(cardFlipImageArray)
    }
    

    func dealAnyCard(cardToDeal: CardFlipAnimation) {
        cardToDeal.hidden = false
        cardToDeal.alpha = 1.0
        cardToDeal.slideFromRight(0.25, completionDelegate: nil)
        
        NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "playCardFlip", userInfo: nil, repeats: false)
        NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "flipAnyCard", userInfo: nil, repeats: false)
        
    }
    
    func flipAnyCard() {
        if !playerTurnOver() {
            flipPlayerCards()
        } else {
            flipDealerCards()
        }


    }
    
    func flipPlayerCards() {
        
        if playerCardFour.hidden == true {
            playerCardThree.image = UIImage(named: "\(playerCards.last!)")
            playerCardThree.playFlipAnimation(cardFlipImageArray)
        } else if playerCardFive.hidden == true {
            playerCardFour.image = UIImage(named: "\(playerCards.last!)")
            playerCardFour.playFlipAnimation(cardFlipImageArray)
        } else if playerCardSix.hidden == true {
            playerCardFive.image = UIImage(named: "\(playerCards.last!)")
            playerCardFive.playFlipAnimation(cardFlipImageArray)
        } else if playerCardSeven.hidden == true {
            playerCardSix.image = UIImage(named: "\(playerCards.last!)")
            playerCardSix.playFlipAnimation(cardFlipImageArray)
        } else if playerCardEight.hidden == true {
            playerCardSeven.image = UIImage(named: "\(playerCards.last!)")
            playerCardSeven.playFlipAnimation(cardFlipImageArray)
        } else if playerCardNine.hidden == true {
            playerCardEight.image = UIImage(named: "\(playerCards.last!)")
            playerCardEight.playFlipAnimation(cardFlipImageArray)
        } else if playerCardTen.hidden == true {
            playerCardNine.image = UIImage(named: "\(playerCards.last!)")
            playerCardNine.playFlipAnimation(cardFlipImageArray)
        } else if playerCardEleven.hidden == true {
            playerCardTen.image = UIImage(named: "\(playerCards.last!)")
            playerCardTen.playFlipAnimation(cardFlipImageArray)
        } else if playerCardTwelve.hidden == true {
            playerCardEleven.image = UIImage(named: "\(playerCards.last!)")
            playerCardEleven.playFlipAnimation(cardFlipImageArray)
        } else {
            playerCardTwelve.image = UIImage(named: "\(playerCards.last!)")
            playerCardTwelve.playFlipAnimation(cardFlipImageArray)
        }
        
    }
    
    func flipDealerCards() {
        if dealerCardFour.hidden == true {
            dealerCardThree.image = UIImage(named: "\(dealerCards.last!)")
            dealerCardThree.playFlipAnimation(cardFlipImageArray)
        } else if dealerCardFive.hidden == true {
            dealerCardFour.image = UIImage(named: "\(dealerCards.last!)")
            dealerCardFour.playFlipAnimation(cardFlipImageArray)
        } else if dealerCardSix.hidden == true {
            dealerCardFive.image = UIImage(named: "\(dealerCards.last!)")
            dealerCardFive.playFlipAnimation(cardFlipImageArray)
        } else if dealerCardSeven.hidden == true {
            dealerCardSix.image = UIImage(named: "\(dealerCards.last!)")
            dealerCardSix.playFlipAnimation(cardFlipImageArray)
        } else if dealerCardEight.hidden == true {
            dealerCardSeven.image = UIImage(named: "\(dealerCards.last!)")
            dealerCardSeven.playFlipAnimation(cardFlipImageArray)
        } else if dealerCardNine.hidden == true {
            dealerCardEight.image = UIImage(named: "\(dealerCards.last!)")
            dealerCardEight.playFlipAnimation(cardFlipImageArray)
        } else if dealerCardTen.hidden == true {
            dealerCardNine.image = UIImage(named: "\(dealerCards.last!)")
            dealerCardNine.playFlipAnimation(cardFlipImageArray)
        } else if dealerCardEleven.hidden == true {
            dealerCardTen.image = UIImage(named: "\(dealerCards.last!)")
            dealerCardTen.playFlipAnimation(cardFlipImageArray)
        } else if dealerCardTwelve.hidden == true {
            dealerCardEleven.image = UIImage(named: "\(dealerCards.last!)")
            dealerCardEleven.playFlipAnimation(cardFlipImageArray)
        } else {
            dealerCardTwelve.image = UIImage(named: "\(dealerCards.last!)")
            dealerCardTwelve.playFlipAnimation(cardFlipImageArray)
        }
    }
    
    
    func cardsLeaveScreen() {
        for card in cardback {
            if card.hidden == false {
                card.alpha = 1.0
                card.slideFromRight(0.25, completionDelegate: nil)
                card.alpha = 0.0
            }

        }
        
        cardsOnScreen = false
    }
    
    
}

    

