//
//  EventEditViewController.swift
//  MBtest
//
//  Created by Maxim Mitin on 6.10.23.
//

import UIKit

class EventEditViewController: UIViewController {
    
    @IBOutlet weak var eventName: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        datePicker.date = selectedDate
    }
    
    
    @IBAction func saveTaped(_ sender: Any) {
        let newEvent = Event()
        newEvent.id = eventList.count
        newEvent.name = eventName.text
        newEvent.date = datePicker.date
    }
    
}
