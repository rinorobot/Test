//
//  ViewController.swift
//  TimerTest
//
//  Created by Salvador Gómez Moya on 07/07/23.
//

import UIKit
import SideMenu
import AVFoundation
import CoreMotion






class ViewController: UIViewController {
    
    let manager = CMMotionManager()
    let feedbackGenerator = UINotificationFeedbackGenerator()
    
    
    @IBOutlet weak var hoursTextField: UITextField!
    @IBOutlet weak var minutesTextField: UITextField!
    @IBOutlet weak var secondsTextField: UITextField!
    
    @IBOutlet weak var pauseResumeButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var cancelButtonTapped: UIButton!
    
    
    
    private let sideMenu = SideMenuNavigationController(rootViewController: MenuController(with: [" "," "," ","Configuración"," "," "," "," ","Comentarios"]))
    
    var audioPlayer: AVAudioPlayer?
    
    var timer: Timer?
    var remainingTime: TimeInterval = 0
    var isTimerRunning = false
    var isPausaded = false

    
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            if isPausaded {
                
            }else{
                startAccelerometer()
            }
            
            sideMenu.leftSide = false
            SideMenuManager.default.rightMenuNavigationController = sideMenu
            SideMenuManager.default.addPanGestureToPresent(toView: view)
                       
            disableUserInput(false)
            
            hoursTextField.text = "00"
            minutesTextField.text = "00"
            secondsTextField.text = "10"
            
          
        }
    
    
    func startAccelerometer(){
        guard manager.isAccelerometerAvailable else {
            return
        }
        
        manager.accelerometerUpdateInterval = 1
        
        manager.startAccelerometerUpdates(to: OperationQueue.main) { [weak self] (data, error) in
            guard let acceleration = data?.acceleration, let self = self else {
                return
            }
            
            let horizontal = self.isHorizontal(acceleration: acceleration)
            if horizontal && !isPausaded {
                 if !self.isTimerRunning {
                     self.startTimer()
                     self.pauseResumeButton.setTitle("Pausar", for: .normal)
                 }
             } else {
                 if self.isTimerRunning {
                     self.pauseTimer()
                     self.pauseResumeButton.setTitle("Reanudar", for: .normal)
                 }
             }
          
        }
        
        
    }
    //Corroboramos que el dispositivo está en una mesa
    func isHorizontal(acceleration: CMAcceleration) -> Bool {
           //let x = acceleration.x
           let y = abs(acceleration.y)
           let z = abs(acceleration.z)
           return y < 0.1 && z > 1.0
        }

  
    
    //Para el cronómetro
        
        func disableUserInput(_ disable: Bool) {
            hoursTextField.isEnabled = !disable
            minutesTextField.isEnabled = !disable
            secondsTextField.isEnabled = !disable
       
           
        }
    
    func startTimer() {
            guard timer == nil else {
                return
            }
            
            guard let hoursText = hoursTextField.text,
                let minutesText = minutesTextField.text,
                let secondsText = secondsTextField.text,
                let hours = Int(hoursText),
                let minutes = Int(minutesText),
                let seconds = Int(secondsText) else {
                    return
            }
            
            remainingTime = TimeInterval(hours * 3600 + minutes * 60 + seconds)
           
            updateTextFields()
            isTimerRunning = true
            disableUserInput(true)
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] (_) in
                guard let self = self else { return }
                
                self.remainingTime -= 1
                
                if self.remainingTime <= 0 {
                    self.stopTimer()
                    
                   
                    if stateVibrationAndSound == 0 {
                        self.vibration()
                        self.playSound()
                    } else if stateVibrationAndSound == 1 {
                        self.playSound()
                    } else if stateVibrationAndSound == 2 {
                        self.vibration()
                    }
                        
                } else {
                    self.updateTextFields()
                }
            }
        }
    
  
    
  
        
    func updateTextFields() {
        let hours = Int(remainingTime / 3600)
        let minutes = Int((remainingTime / 60).truncatingRemainder(dividingBy: 60))
        let seconds = Int(remainingTime.truncatingRemainder(dividingBy: 60))
        
        hoursTextField.text = String(format: "%02d", hours)
        minutesTextField.text = String(format: "%02d", minutes)
        secondsTextField.text = String(format: "%02d", seconds)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        manager.stopDeviceMotionUpdates()
        timer?.invalidate()
        timer = nil
        audioPlayer?.stop()
        audioPlayer = nil
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        pauseResumeButton.titleLabel?.text = "Pon el iPhone en una mesa para comenzar"
    }
    
    func vibration() {
       if stateVibrationSelected == 0 {
            feedbackGenerator.notificationOccurred(.success)
        } else{
            feedbackGenerator.notificationOccurred(.error)
        }
     }
    
    func playSound() {
        if stateSoundSelected == 0 {
            guard let sound1URL = Bundle.main.url(forResource: "sound", withExtension: "mp3") else {
                return
            }
            
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: sound1URL)
                audioPlayer?.play()
            } catch {
                print("Error playing sound: \(error)")
            }
        }
        else{
            guard let sound2URL = Bundle.main.url(forResource: "sonido2", withExtension: "mp3") else {
                return
            }
            
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: sound2URL)
                audioPlayer?.play()
            } catch {
                print("Error playing sound: \(error)")
            }
        }
    }
     
    
    
    @IBAction func pauseResumeButtonTapped(_ sender: UIButton) {
        isPausaded = !isPausaded
        if isTimerRunning {
            pauseTimer()
            sender.setTitle("Reanudar", for: .normal)
        } else {
            startTimer()
            sender.setTitle("Pausar", for: .normal)
        }
    }
    
    func pauseTimer() {
        timer?.invalidate()
        timer = nil
        isTimerRunning = false
        disableUserInput(false)
    }
    
    func resumeTimer() {
        startTimer()
        
        pauseResumeButton.setTitle("Pausar", for: .normal)
    }
    
    
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        isPausaded = true
        stopTimer()
        remainingTime = 0
        updateTextFields()
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
        disableUserInput(false)
    }
    
    //Para el menú lateral
    @IBAction func tapMenuButton(){
        present(sideMenu, animated: true)
    }
    
    
   
    
}

