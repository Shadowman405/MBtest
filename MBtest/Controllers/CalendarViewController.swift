//
//  CalendarViewController.swift
//  MBtest
//
//  Created by Maxim Mitin on 5.10.23.
//

import UIKit

class CalendarViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var monthLbl: UILabel!

    var selectedDate = Date()
    var totalSquares = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setCellsView()
        setMonthView()
    }
    
    func setCellsView(){
        let width = (collectionView.frame.size.width - 2) / 8
        let height = (collectionView.frame.size.width - 2) / 8
        
        let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.itemSize = CGSize(width: width, height: height)
        
    }
    
    func setMonthView(){
        let daysInMonth = CalendarHelper().daysInMonth(date: selectedDate)
        let firstDayOfMonth = CalendarHelper().firstOfMonth(date: selectedDate)
        let startingSpaces = CalendarHelper().weekDay(date: firstDayOfMonth)
        
        var count = 1
        
        while(count <= 42) {
            if(count <= startingSpaces || count - startingSpaces > daysInMonth)
            {
                totalSquares.append("")
            } else {
                totalSquares.append(String(count - startingSpaces))
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        totalSquares.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "calCell", for: indexPath) as! CalendarCell
        cell.dayOfMonth.text = totalSquares[indexPath.item]
        
        return cell
    }
  
    @IBAction func previousMonthTaped(_ sender: Any) {
    }
    
    @IBAction func nextMonthTaped(_ sender: Any) {
    }
    
    
}
