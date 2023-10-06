//
//  WeeklyViewController.swift
//  MBtest
//
//  Created by Maxim Mitin on 6.10.23.
//

import UIKit

var selectedDate = Date()

class WeeklyViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var monthLbl: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    
    
    var totalSquares = [Date]()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    
    func setCellsView(){
        let width = (collectionView.frame.size.width - 2) / 8
        let height = (collectionView.frame.size.width - 2) / 8
        
        let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.itemSize = CGSize(width: width, height: height)
        
    }
    
    func setWeekView(){
        totalSquares.removeAll()
        
        var current = CalendarHelper().sundayForDate(date: selectedDate)
        let nextSunday = CalendarHelper().addDays(date: current, days: 7)
        
        while (current < nextSunday){
            totalSquares.append(current)
            current = CalendarHelper().addDays(date: current, days: 1)
        }
        
        
        monthLbl.text = CalendarHelper().mothString(date: selectedDate) + " " + CalendarHelper().yearString(date: selectedDate)
        collectionView.reloadData()
        tableView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        totalSquares.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "calCell", for: indexPath) as! CalendarCell
        let date = totalSquares[indexPath.item]
        cell.dayOfMonth.text = String(CalendarHelper().dayOfMonth(date: date))
        
        if(date == selectedDate) {
            cell.backgroundColor = UIColor.systemGreen
        } else {
            cell.backgroundColor = UIColor.white
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedDate = totalSquares[indexPath.item]
        collectionView.reloadData()
        tableView.reloadData()
    }
    
    //MARK: - TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Event().eventsForDate(date: selectedDate).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID") as! EventCell
        let event = Event().eventsForDate(date: selectedDate)[indexPath.row]
        cell.eventLbl.text = event.name
        
        return cell
    }
    
    @IBAction func nextWeekTaped(_ sender: Any) {
        selectedDate = CalendarHelper().addDays(date: selectedDate, days: 7)
        setWeekView()
    }
    
    
    @IBAction func previousWeekTaped(_ sender: Any) {
        selectedDate = CalendarHelper().addDays(date: selectedDate, days: -7)
        setWeekView()
    }
    
    override open var shouldAutorotate: Bool {
        return false
    }

}
