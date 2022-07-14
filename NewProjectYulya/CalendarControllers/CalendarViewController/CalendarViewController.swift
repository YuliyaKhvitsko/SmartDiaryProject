//
//  CalendarViewController.swift
//  NewProjectYulya
//
//  Created by Yuliya Khvitsko on 13.07.22.
//

import UIKit

class CalendarViewController: UIViewController {

    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    

    var totalSquares = [String]()
    
    


    override func viewDidLoad() {
        super.viewDidLoad()
     setCellsView()
        setMonthView()
        
    
        collectionView.delegate = self
        collectionView.dataSource = self
        

        let nibCell = UINib(nibName: String(describing: CalendarViewCell.self), bundle: nil)
        collectionView.register(nibCell, forCellWithReuseIdentifier: String(describing: CalendarViewCell.self))
    }
    
  
    
//    func showNavigationBar() {
//            self.navigationController?.setNavigationBarHidden(false, animated: true)
//        }
//
    @IBAction func showWeeklyController(_ sender: Any) {
        
        let vc = WeeklyViewController(nibName: String(describing: WeeklyViewController.self), bundle: nil)
        
        navigationController?.pushViewController(vc, animated: true)
        print("нажата")
        
    
    }
    
    func setCellsView() {
        let width = (collectionView.frame.size.width - 2) / 8
        let height = (collectionView.frame.size.height - 2) / 8
        
        let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.itemSize = CGSize(width: width, height: height)
    }
    
    func setMonthView() {
        totalSquares.removeAll()
        
        let daysInMonth = CalendarHelper().daysInMonth(date: selectedDate)
        let firstDayOfMonth = CalendarHelper().firstOfMonth(date: selectedDate)
        let startingSpaces = CalendarHelper().weekDay(date: firstDayOfMonth)
        
        var count: Int = 1
        
        while(count <= 42){
            if (count <= startingSpaces || count - startingSpaces > daysInMonth) {
                totalSquares.append("")
            }
            else {
                totalSquares.append(String(count - startingSpaces))
            }
            count += 1
        }
        
        monthLabel.text = CalendarHelper().monthString(date: selectedDate) + " " + CalendarHelper().yearString(date: selectedDate)
        collectionView.reloadData()
    }
    
    @IBAction func previousMonth(_ sender: Any) {
        selectedDate = CalendarHelper().minusMonth(date: selectedDate)
        setMonthView()
    }
    
    @IBAction func nextMonth(_ sender: Any) {
        selectedDate = CalendarHelper().plusMonth(date: selectedDate)
        setMonthView()
    }
    
    override open var shouldAutorotate: Bool {
        return false
    }
    
}


extension CalendarViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        totalSquares.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CalendarViewCell.self), for: indexPath) as! CalendarViewCell
        
        cell.dayOfMonth.text = totalSquares[indexPath.item]
        return cell
    }
}
