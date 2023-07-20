//
//  ConfigurationViewController.swift
//  TimerTest
//
//  Created by Salvador Gómez Moya on 10/07/23.
//

import UIKit

class ConfigurationViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    
   
    
    @IBOutlet weak var soundPicker: UIPickerView!
    let sounds = ["Sonido 1", "Sonido 2"]
    var stateSoundSelected = UserDefaults.standard.integer(forKey: "stateSoundSelected")
    
    

    @IBOutlet weak var vibrationPicker: UIPickerView!
    let vibrations = ["Vibración 1", "Vibración 2"]
    var stateVibrationSelected = UserDefaults.standard.integer(forKey: "stateVibrationSelected")
    

    @IBOutlet weak var vibrationAndSoundButton: UIButton!
    @IBOutlet weak var soundButton: UIButton!
    
    
    @IBOutlet weak var vibrationButton: UIButton!
    
    let check = UIImage(systemName: "checkmark.square")
    let uncheck = UIImage(systemName: "square")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
       soundPicker.delegate = self
       soundPicker.dataSource = self
       soundPicker.tag = 1
       soundPicker.selectRow(stateSoundSelected, inComponent: 0, animated: false)
        
       vibrationPicker.delegate = self
       vibrationPicker.dataSource = self
       vibrationPicker.tag = 2
       vibrationPicker.selectRow(stateVibrationSelected, inComponent: 0, animated: true)
        
        
       let stateVibrationAndSound = UserDefaults.standard.integer(forKey: "stateVibrationAndSound")
       
        

       if stateVibrationAndSound == 0 {
            vibrationAndSoundButton.isSelected = true
            soundButton.isSelected = false
            vibrationButton.isSelected = false
        } else if stateVibrationAndSound == 1 {
            vibrationAndSoundButton.isSelected = false
            soundButton.isSelected = true
            vibrationButton.isSelected = false
        } else if stateVibrationAndSound == 2 {
            vibrationAndSoundButton.isSelected = false
            soundButton.isSelected = false
            vibrationButton.isSelected = true
        }
        
        
      
        
        vibrationAndSoundButton.setImage(check, for: .selected)
        vibrationAndSoundButton.setImage(uncheck, for: .normal)
        
        soundButton.setImage(check, for: .selected)
        soundButton.setImage(uncheck, for: .normal)
        
        vibrationButton.setImage(check, for: .selected)
        vibrationButton.setImage(uncheck, for: .normal)
        
   }
    
    @IBAction func vibrationAndSoundTapped(_ sender: UIButton) {
        if sender.isSelected{
            sender.isSelected = false
           
       }else{
         sender.isSelected = true
           soundButton.isSelected = false
           vibrationButton.isSelected = false
            UserDefaults.standard.set(0, forKey: "stateVibrationAndSound")
               
        }
    }
    
    
 
    @IBAction func soundTapped(_ sender: UIButton) {
        if sender.isSelected{
           sender.isSelected = false
            
       }else{
           sender.isSelected = true
          
           vibrationAndSoundButton.isSelected = false
           vibrationButton.isSelected = false
            UserDefaults.standard.set(1, forKey: "stateVibrationAndSound")
               
        }
        
    }
    
    
    

    @IBAction func vibrationButtonTapped(_ sender: UIButton) {
        if sender.isSelected{
           sender.isSelected = false
            
       }else{
           sender.isSelected = true
          
          vibrationAndSoundButton.isSelected = false
           soundButton.isSelected = false
            UserDefaults.standard.set(2, forKey: "stateVibrationAndSound")
               
        }
    }
    
    //Para los pickers de sonido y vibración
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1 {
            return sounds.count
        } else {
            return vibrations.count
        }
        
        
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 1 {
                   return sounds[row]
               } else {
                   return vibrations[row]
               }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(pickerView.tag)
        if pickerView.tag == 1 {
            if row == 0 {
                UserDefaults.standard.set(0, forKey: "stateSoundSelected")
            }
            if row == 1 {
                UserDefaults.standard.set(1, forKey: "stateSoundSelected")
            }
        } else {
            if row == 0 {
                UserDefaults.standard.set(0, forKey: "stateVibrationSelected")
            }
            if row == 1 {
                UserDefaults.standard.set(1, forKey: "stateVibrationSelected")
            }
            
        }
       
       
    }
    
   func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
       
       
       if pickerView.tag == 1 {
           return NSAttributedString(string: sounds[row], attributes: [NSAttributedString.Key.foregroundColor : UIColor.black])
              } else {
                  return NSAttributedString(string: vibrations[row], attributes: [NSAttributedString.Key.foregroundColor : UIColor.black])
              }
        
       
    }
    
    
   
    
}
