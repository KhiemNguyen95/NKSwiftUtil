//
//  Pushser.swift
//
//
//  Created by Khiem on 2020-05-28.
//  Copyright © 2020 Khiem Nguyen. All rights reserved.
//

import Foundation
typealias ObserverHander = () -> Void

public protocol Observer {
    var id: String { get }
    func update()
    init(id: String)
}

final class ActionObserver: NSObject, Observer {
    var id: String
    var subject = SubjectAction()
    var success: ObserverHander?
    
    init(id: String) {
        self.id = id
    }
    
    convenience init(subject : SubjectAction, id : String, onSuccess: ObserverHander?) {
        self.init(id: id)
        self.subject = subject
        self.subject.attachObserver(obs: self)
        success = onSuccess
    }
    func update() {
        if self.success != nil {
            self.success!()
        }
    }
}

public class SubjectAction {
    var arrObserver = [Observer]()
    ///thoi gian toi thiêu de call update
    private var minTime = Int()

    private var currentTime = Int()
    ///check thông báo đã đc push chưa
    private var isNotify = false

    func changeValue() {
        self.isNotify = false
        if currentTime > 0 {
            return
        }
        self.notify()
    }

    func attachObserver(obs: Observer) {
        self.arrObserver.append(obs)
    }

    func removeObserver(obs: Observer) {
        self.arrObserver = self.arrObserver.filter { $0.id != obs.id }
    }

    func debounce(time: Int) {
        self.minTime = time
    }
    func notify() {
        self.isNotify = true
        for obs in arrObserver {
            obs.update()
        }
        startTimer()
    }
    //Timer
    private var timerTake: Timer?

    func stopTimer()
    {
        if timerTake != nil && timerTake!.isValid
        {
            timerTake?.invalidate()
        }
    }
    func startTimer() -> Void {
        self.currentTime = self.minTime
        self.stopTimer()
        timerTake = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }

    @objc func updateTimer()
    {
        self.currentTime = self.currentTime > minTime ? minTime : self.currentTime - 1
        if self.currentTime <= 0
        {
            self.stopTimer()
            if !isNotify {
                self.notify()
            }
        }
    }
}
