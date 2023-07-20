//
//  DataStore.swift
//  TimerTest
//
//  Created by Salvador Gómez Moya on 19/07/23.
//

import Foundation

//Para guardar estados de los botones
var stateVibrationAndSound: Int {
      get {
          return UserDefaults.standard.integer(forKey: "stateVibrationAndSound")
      }
      set {
          UserDefaults.standard.set(0, forKey: "stateVibrationAndSound")
      }
  }

var stateSoundSelected: Int {
      get {
          return UserDefaults.standard.integer(forKey: "stateSoundSelected")
      }
      set {
          UserDefaults.standard.set(0, forKey: "stateSoundSelected")
      }
  }
var stateVibrationSelected: Int {
      get {
          return UserDefaults.standard.integer(forKey: "stateVibrationSelected")
      }
      set {
          UserDefaults.standard.set(0, forKey: "stateVibrationSelected")
      }
  }
