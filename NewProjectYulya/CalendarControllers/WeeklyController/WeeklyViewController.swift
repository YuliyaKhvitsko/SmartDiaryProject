//
//  WeeklyViewController.swift
//  NewProjectYulya
//
//  Created by Yuliya Khvitsko on 13.07.22.
//

import UIKit

var selectedDate = Date()
class WeeklyViewController: UIViewController {

    
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    
    var totalSquares = [Date]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCellsView()
           setWeekView()
           
           collectionView.delegate = self
           collectionView.dataSource = self
        
        tableView.delegate = self
        tableView.dataSource = self
          
           let nibCell = UINib(nibName: String(describing: CalendarViewCell.self), bundle: nil)
           collectionView.register(nibCell, forCellWithReuseIdentifier: String(describing: CalendarViewCell.self))
    
        
        let tableCell = UINib(nibName: String(describing: WeeklyTableViewCell.self), bundle: nil)
        tableView.register(tableCell, forCellReuseIdentifier: String(describing: WeeklyTableViewCell.self))

       }
    
        func showNavigationBar() {
                self.navigationController?.setNavigationBarHidden(false, animated: true)
            }
        
    @IBAction func showCalendarController(_ sender: Any) {
        let vc = CalendarViewController(nibName: String(describing: CalendarViewController.self), bundle: nil)
        
        navigationController?.pushViewController(vc, animated: true)
        print("нажата")
        
    }
    @IBAction func showEventEditController(_ sender: Any) {
        let vc = EventEditController(nibName: String(describing: EventEditController.self), bundle: nil)
        navigationController?.pushViewController(vc, animated: true)
        print("нажата")
        
    }
    func setCellsView() {
        let width = (collectionView.frame.size.width - 2) / 8
        let height = (collectionView.frame.size.height - 2)
        
        let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.itemSize = CGSize(width: width, height: height)
    }
    
    func setWeekView() {
        totalSquares.removeAll()
        
        var current = CalendarHelper().sundayForDate(date: selectedDate)
        let nextSunday = CalendarHelper().addDays(date: current, days: 7)
        
        while (current < nextSunday)
        {
            totalSquares.append(current)
            current = CalendarHelper().addDays(date: current, days: 1)
        }
        
        monthLabel.text = CalendarHelper().monthString(date: selectedDate)
            + " " + CalendarHelper().yearString(date: selectedDate)
        collectionView.reloadData()
        tableView.reloadData()
    }
    
    @IBAction func previousWeek(_ sender: Any) {
        selectedDate = CalendarHelper().addDays(date: selectedDate, days: -7)
               setWeekView()
    }
    @IBAction func nextWeek(_ sender: Any) {
        selectedDate = CalendarHelper().addDays(date: selectedDate, days: 7)
                setWeekView()
    }
    
    override open var shouldAutorotate: Bool {
        return false
    }
    
}


extension WeeklyViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        totalSquares.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CalendarViewCell.self), for: indexPath) as! CalendarViewCell
        
        let date = totalSquares[indexPath.item]
        cell.dayOfMonth.text = String(CalendarHelper().dayOfMonth(date: date))
        
        if(date == selectedDate)
        {
            cell.backgroundColor = UIColor.systemGreen
        }
        else
        {
            cell.backgroundColor = UIColor.black
        }
        
        return cell
    
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedDate = totalSquares[indexPath.item]
        collectionView.reloadData()
        tableView.reloadData()
    }
}

extension WeeklyViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Event().eventsForDate(date: selectedDate).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: WeeklyTableViewCell.self), for: indexPath) as! WeeklyTableViewCell
        
        let event = Event().eventsForDate(date: selectedDate)[indexPath.row]
        cell.eventLabel.text = event.name + " " + CalendarHelper().timeString(date: event.date)
        return cell
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
}



