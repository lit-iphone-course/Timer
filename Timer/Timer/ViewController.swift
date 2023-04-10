import UIKit

class ViewController: UIViewController {
    
    var timer: Timer!
    
    //残りの秒数の変数
    var countdown: Int = 0

    @IBOutlet weak var timerLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //timerLabelに表示される文字を00:00にする
        updateLabel()
    }

    //30秒のボタンが押された時
    @IBAction func select30seconds(_ sender: Any) {
        
        startTimer(time: 30)
    }
    
    //1分のボタンが押された時
    @IBAction func select1minute(_ sender: Any) {
        
        startTimer(time: 60)
    }
    
    //5分のボタンが押された時
    @IBAction func select5minutes(_ sender: Any) {
        
        //5分=300秒
        startTimer(time: 300)
    }
    
    //10分のボタンが押された時
    @IBAction func select10minutes(_ sender: Any) {
        
        startTimer(time: 600)
    }
    
    //timerを動かす
    //time引数で、タイマーの長さを設定する
    func startTimer(time: Int) {
        
        countdown = time
        
        //もしすでにtimerが動いていたら二重でタイマーが動いてしまうので、元々のタイマーを終わらせる
        if timer != nil {
            
            timer.invalidate()
        }
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(onTimerCalled), userInfo: nil, repeats: true)
        
        timer.fire()
    }
    
    //timerを止める
    func stopTimer() {
        
        timer.invalidate()
    }
    
    //timerによって1秒ごとに呼び出される
    @objc func onTimerCalled() {
        
        updateLabel()
        
        countdown -= 1
        
        //もし残り時間が0未満なら終わり
        if countdown < 0 {
            
            showStopAlert()
            stopTimer()
        }
    }
    
    //残り秒数のlabelに表示される文章を変える
    func updateLabel() {
        
        //残りの分数→countdownを60で割って切り捨て
        //残りの秒数→countdownを60で割ったあまり
        let remainingMinutes: Int = countdown / 60
        let remainingSeconds: Int = countdown % 60
        
        //%02dには、あとに書いてある変数（ここではremainingMinutesとremainingSeconds）がそれぞれ入ります。
        //また、%02dという書き方をしているため、もし代入された値が1桁なら0で埋めて表示されるようになっています。
        //例：remainingMinutes=1、remainingSeconds=5が代入されたら、01:05と表示
        timerLabel.text = String(format: "%02d:%02d", remainingMinutes, remainingSeconds)
    }

    //残り時間が0になったことを知らせるアラートを表示
    func showStopAlert() {
        
        let stopAlert = UIAlertController(title: "タイマーが終了しました", message: nil, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        
        stopAlert.addAction(okAction)
        
        present(stopAlert, animated: true)
    }
}

