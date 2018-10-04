//
//  DiaryViewController.swift
//  Instructor
//
//  Created by Steve Smith on 11/02/2016.
//  Copyright © 2016 Midrive. All rights reserved.
//

import UIKit
import RealmSwift

let DiaryViewControllerIdentifier = "DiaryViewController"

class DiaryViewController: UIViewController {

    @IBAction func crash(_ sender: UIButton) {
        let createLessonReportOperation = CreateLessonReportOperation(lessonId: "69d1c942-bb9c-4e02-ac3f-c9ffaf8c9ee3")

        createLessonReportOperation.success = { lessonReportItem in
            DispatchQueue.main.sync {
                let realm = try! Realm()
                try! realm.write {
                    realm.add(lessonReportItem, update: true)
                }

                let trackLessonViewController = self.storyboard!.instantiateViewController(withIdentifier: "TrackLessonViewController") as! TrackLessonViewController
                trackLessonViewController.lessonReportId = lessonReportItem.id

                let navigationController = UINavigationController(rootViewController: trackLessonViewController)
                navigationController.setNavigationBarHidden(true, animated: false)

                self.present(navigationController, animated: true, completion: nil)
            }
        }

        createLessonReportOperation.failure = { error in
            DispatchQueue.main.sync {
                print(error.localizedDescription)
            }
        }

        NetworkQueue.shared.addOperation(op: createLessonReportOperation)
    }
}
