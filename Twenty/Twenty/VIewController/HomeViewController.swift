//
//  HomeViewController.swift
//  Twenty
//
//  Created by Effy Zhang on 6/13/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import UIKit
import Combine
import SwiftUI

class HomeViewController: UIViewController {
    
    var userID: String?

    private var cancellable: AnyCancellable!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let currentDate: Date.Day = Date().asDay(in: .current)
        
        // TODO: clean up DB async intialization
        
        let goalStore = GoalStoreImpl(
            persistentDataStore: FirebasePersistentDataStore(userID: userID!)
        )
        
        let goalStoreReader = AnyGoalStoreReader(goalStore)
        let goalStoreWriter = goalStore
        
        cancellable = goalStore.firstGoalPublisher.sink { firstGoal in
            guard let firstGoal = firstGoal else {
                return
            }
            
            let goalID = firstGoal.id
            let goalPublisher: GoalPublisher = goalStoreReader.goalPublisher(for: goalID)
            
            let initialTimerState: TimerState = .init(activeState: .inactive, totalElapsedTime: 0)
            let timerStateStore: TimerStateStore = .init(
                initialState: initialTimerState,
                goalStoreWriter: goalStoreWriter,
                goalID: goalID
            )
            let timer: TwentyTimer = RealTimer(timeInterval: 1, store: timerStateStore)

            let selectDayStore = SelectDayStore(initialSelectDay: currentDate)
            
            let contentView = ContentView(
                timerTabContext: .init(
                    timerStateStore: timerStateStore,
                    goalPublisher: goalPublisher,
                    timer: timer,
                    selectDayStore: selectDayStore,
                    todayPublisher: Just(currentDate).eraseToAnyPublisher()
                )
            )
            
            let childView = UIHostingController(rootView: contentView)
            self.addChild(childView)
            childView.view.frame = self.view.bounds
            self.view.addSubview(childView.view)
            childView.didMove(toParent: self)
        }
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
