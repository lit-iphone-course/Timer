import UIKit

class ViewController: UIViewController {
    
    var timer: Timer!
    
    //残りの秒数
    var remainTime: Int = 0

    @IBOutlet weak var timerLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //timerLabelに表示される文字を00:00にする
        updateLabel()
    }

    //30秒のボタンが押された時
    @IBAction func select30seconds(_ sender: Any) {
        
        remainTime = 30
        
        startTimer()
    }
    
    //1分のボタンが押された時
    @IBAction func select1minute(_ sender: Any) {
        
        remainTime = 60
        
        startTimer()
    }
    
    //5分のボタンが押された時
    @IBAction func select5minutes(_ sender: Any) {
        
        //5分=300秒
        remainTime = 300
        
        startTimer()
    }
    
    //10分のボタンが押された時
    @IBAction func select10minutes(_ sender: Any) {
        
        remainTime = 600
        
        startTimer()
    }
    
    //timerを動かす
    func startTimer() {
        
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
        
        remainTime -= 1
        
        //もし残り時間が0未満なら終わり
        if remainTime < 0 {
            
            showStopAlert()
            stopTimer()
        }
    }
    
    //残り秒数のlabelに表示される文章を変える
    func updateLabel() {
        
        //残りの分数→remainTimeを60で割って切り捨て
        //残りの秒数→remainTimeを60で割ったあまり
        let remainMinutes: Int = remainTime / 60
        let remainSeconds: Int = remainTime % 60
        
        //%02dには、あとに書いてある変数（ここではremainMinutesとremainSeconds）がそれぞれ入ります。
        //また、%02dという書き方をしているため、もし代入された値が1桁なら0で埋めて表示されるようになっています。
        //例：remainMinutes=1、remainSeconds=5が代入されたら、01:05と表示
        timerLabel.text = String(format: "%02d:%02d", remainMinutes, remainSeconds)
    }

    //残り時間が0になったことを知らせるアラートを表示
    func showStopAlert() {
        
        let stopAlert = UIAlertController(title: "タイマーが終了しました", message: nil, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        
        stopAlert.addAction(okAction)
        
        present(stopAlert, animated: true)
    }
}

