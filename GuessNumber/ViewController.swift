//
//  ViewController.swift
//  GuessNumber
//
//  Created by SHIH-YING PAN on 2020/8/25.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var boxButton: [UIButton]!
    @IBOutlet weak var gameNum: UITextField!
    @IBOutlet weak var scoreBoard: UITextField!
    @IBOutlet weak var guessLabel: UIButton!
    @IBOutlet weak var rangeLabel: UILabel!
    var games: Int = 3
    var score: Int = 0
    var index = 0
    var answer = Int.random(in: 1...5)
    var guessWrongCount = 0
    var lowerBound: Int = 1
    var upperBound: Int = 5
    var chances: Int = 2
    let emptyImage = UIImage(systemName: "envelope.open.fill")
    let dollarImage = UIImage(systemName: "dollarsign.circle.fill")
    let closeImage = UIImage(systemName: "envelope.fill")
    
    @IBOutlet weak var startoverButton: UIButton!
    @IBOutlet weak var replayButton: UIButton!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var numberTextField: UITextField!
    
    @IBOutlet weak var chancesLeftLabel: UILabel!
    @IBOutlet weak var guessWrongCountLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //guessWrongCountLabel.text = "猜錯\(guessWrongCount)次"

        chancesLeftLabel.text = "第\(4-games )局剩下\(chances)次機會"
        rangeLabel.text = "提示： \(lowerBound)~\(upperBound)"
        resultLabel.text = "進入第\(4-games)局！"
        startoverButton.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    @IBAction func pressBox(_ sender: UIButton) {
        for oneButton in boxButton{
            oneButton.isHighlighted = true
        }
        numberTextField.text = "\(sender .tag)"
    }
    
    @IBAction func guess(_ sender: Any) {
        //numberTextField.resignFirstResponder()
        
        let numberText = numberTextField.text!
        let number = Int(numberText)
        if number != nil, chances != 0{
        let guessNumber = number!
        
        if guessNumber == answer {
                resultLabel.text = "賊準!"
                chances -= 1
                chancesLeftLabel.text = "第\(4-games)局剩下\(chances)次機會"
            
            for oneButton in boxButton{
                oneButton.isEnabled = false
                if oneButton.tag != answer{
                    oneButton.setImage(emptyImage, for:.normal)
                }else{
                    oneButton.setImage(dollarImage, for:.normal)
                }
                }
                score += 1
                scoreBoard.text = "\(score)/3"
                numberTextField.isEnabled = false
                numberTextField.text = ""
                if games == 1{
                    replayButton.isHidden = true
                    startoverButton.isHidden = false
                    if score == 3{
                        resultLabel.text = "🤑 神偷！"
                    }else{
                        resultLabel.text = "錢沒偷著，失敗的小偷！"
                    }
                }
            } else if guessNumber < answer {
                resultLabel.text = "太小了"
                chances -= 1
                chancesLeftLabel.text = "第\(4-games)局剩下\(chances)次機會"
                //guessWrongCount = guessWrongCount + 1
                //guessWrongCountLabel.text = "猜錯\(guessWrongCount)次"
                lowerBound = guessNumber + 1
                rangeLabel.text = "祖師爺提示： \(lowerBound)~\(upperBound)"
                numberTextField.text = ""
                if chances == 0{
                    numberTextField.isEnabled = false
                    resultLabel.text = "💰在\(answer)號信封。真不是當賊的料！"
                    scoreBoard.text = "\(score)/3"
                    for oneButton in boxButton{
                            if oneButton.tag != answer{
                                oneButton.setImage(emptyImage, for:.normal)
                            }else{
                                oneButton.setImage(dollarImage, for:.normal)
                            }
                            }
                    if games == 1{
                        replayButton.isHidden = true
                        startoverButton.isHidden = false
                        if score == 3{
                            resultLabel.text = "🤑 神偷！"
                        }else{
                            resultLabel.text = "錢沒偷著，失敗的小偷！"
                        }
                    }
                    }
                } else {
                resultLabel.text = "太大了"
                chances -= 1
                chancesLeftLabel.text = "第\(4-games)局剩下\(chances)次機會"
                //guessWrongCount = guessWrongCount + 1
                //guessWrongCountLabel.text = "猜錯\(guessWrongCount)次"
                upperBound = guessNumber - 1
                rangeLabel.text = "祖師爺提示： \(lowerBound)~\(upperBound)"
                numberTextField.text = ""
                    if chances == 0{
                        numberTextField.isEnabled = false
                        resultLabel.text = "💰在\(answer)號信封。真不是當賊的料！"
                        for oneButton in boxButton{
                            if oneButton.tag != answer{
                                oneButton.setImage(emptyImage, for:.normal)
                            }else{
                                oneButton.setImage(dollarImage, for:.normal)
                            }
                            }
                        scoreBoard.text = "\(score)/3"
                        if games == 1{
                            replayButton.isHidden = true
                            startoverButton.isHidden = false
                            if score == 3{
                                resultLabel.text = "🤑 神偷！"
                                
                            }else{
                                resultLabel.text = "錢沒偷著，失敗的小偷！"
                            }
                        }
                        }
            }
        }
    }
    
    @IBAction func replay(_ sender: Any) {
        for oneButton in boxButton{
            oneButton.isEnabled = true
            oneButton.setImage(closeImage, for:.normal)
            }
        answer = Int.random(in: 1...5)
        if games > 1{
        games -= 1
        gameNum.text = "\(4-games)/3"
        resultLabel.text = "進入第\(4-games)局！"
        }
        numberTextField.text = ""
        numberTextField.isEnabled = true
        
        lowerBound = 1
        upperBound = 5
        rangeLabel.text = "祖師爺提示： \(lowerBound)~\(upperBound)"
        chances = 2
        chancesLeftLabel.text = "第\(4-games)局剩下\(chances)次機會"
        //guessWrongCount = 0
        //guessWrongCountLabel.text = "猜錯\(guessWrongCount)次"
            
}
    

    @IBAction func startOver(_ sender: UIButton) {
        for oneButton in boxButton{
            oneButton.isEnabled = true
            oneButton.setImage(closeImage, for:.normal)
            }
        answer = Int.random(in: 1...5)
        chances = 2
        numberTextField.text = ""
        games = 3
        gameNum.text = "\(4-games)/3"
        resultLabel.text = "進入第\(4-games)局！"
        chancesLeftLabel.text = "第\(4-games)局剩下\(chances)次機會"
        numberTextField.text = ""
        numberTextField.isEnabled = true
        lowerBound = 1
        upperBound = 5
        rangeLabel.text = "祖師爺提示： \(lowerBound)~\(upperBound)"
        gameNum.text = "\(4-games)/3"
        score = 0
        scoreBoard.text = "\(score)/3"
        replayButton.isHidden = false
        startoverButton.isHidden = true
    }
}

