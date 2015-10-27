//
//  ViewController.swift
//  Hangman
//
//  Created by Gene Yoo on 10/13/15.
//  Copyright © 2015 cs198-ios. All rights reserved.
//

import UIKit

class HangmanViewController: UIViewController, UIPickerViewDelegate , UIPickerViewDataSource {


    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var hangManImage: UIImageView!
    @IBOutlet weak var newGameButton: UIButton!
    @IBOutlet weak var guessesLabel: UILabel!
    @IBOutlet weak var guessButton: UIButton!
    @IBOutlet weak var progressLabel: UILabel!
    
    var hangManGame: Hangman!
    var pickerData: [String] = [String]()
    var appendageCount = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (hangManGame == nil ) {
            startNewGame()
        }
        
        guessesLabel.textAlignment = NSTextAlignment.Center
        progressLabel.textAlignment = NSTextAlignment.Center
        // Do any additional setup after loading the view, typically from a nib.
        
        // Connect data:
        self.picker.delegate = self
        self.picker.dataSource = self
        
        // Input data into the Array:
        pickerData = ["A", "B","C", "D", "E" ,"F", "G", "H", "I" ,"J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V" ,"W" ,"X", "Y", "Z"]
        
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    
    @IBAction func guessButtonPressed(sender: UIButton) {
        let currentGuess = pickerData[picker.selectedRowInComponent(0)]
        let success = hangManGame.guessLetter(currentGuess)
        
        if (success == true && hangManGame.knownString == hangManGame.answer) {
            winningAlert()
            return
        }
        
        if (success == false) {
            addHangmanAppendage()
            if (appendageCount >= 6) {
                losingAlert()
                return
            }
        }
        updateLabels()
    }
    
    func winningAlert() {
        let alertView = UIAlertController(title: "You Win!", message: "Play again?", preferredStyle: .Alert)
        alertView.addAction(UIAlertAction(title: "OK", style: .Default, handler: self.newGameHandler))
        presentViewController(alertView, animated: true, completion: nil)
        return
    }
    
    func losingAlert() {
        let alertView = UIAlertController(title: "You Lose! :(", message: "Try again?", preferredStyle: .Alert)
        alertView.addAction(UIAlertAction(title: "OK", style: .Default, handler: self.newGameHandler))
        presentViewController(alertView, animated: true, completion: nil)
        return
    }
    
    func startNewGame() {
        self.hangManGame = Hangman()
        hangManGame.start()
        self.progressLabel.text = hangManGame.knownString
        self.guessesLabel.text = "No guesses so far!"
        appendageCount = 0
        let imageName = "hangman\(appendageCount+1).gif"
        self.hangManImage.image = UIImage(named: imageName)
        
        
        
    }
    
    func updateLabels() {
        self.progressLabel.text = hangManGame.knownString
        self.guessesLabel.text = hangManGame.guesses()
    }

        
    func newGameHandler(alert: UIAlertAction!) {
        startNewGame()
    }
    
    
    @IBAction func newGameButtonPressed(sender: AnyObject) {
        startNewGame()
    }

    
    
    func addHangmanAppendage() {
        appendageCount += 1
        let imageName = "hangman\(appendageCount+1).gif"
        self.hangManImage.image = UIImage(named: imageName)
   
    }
    

    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

