//
//  HackerTableCellStyle.swift
//  Hackin.at
//
//  Created by Prateek on 3/17/15.
//  Copyright (c) 2015 Prateek Dayal. All rights reserved.
//

enum HackerTableCellStyle {
    
    case ContactView
    case FullView
    
    func reuseIdentifier() -> String {
        switch self {
            case .ContactView:
                return "ContactViewCell"
            case .FullView:
                return "FullViewCell"
        }
    }
    
    func registerCell(tableView: UITableView) {
        switch self {
        case .ContactView:
            tableView.registerClass(HackerTableCell.ContactView.self, forCellReuseIdentifier: reuseIdentifier() )
        case .FullView:
            tableView.registerClass(HackerTableCell.FullView.self, forCellReuseIdentifier: reuseIdentifier())
        }
        
    }
    
    func dequeReusableCell(tableView: UITableView, hacker: Hacker) -> UITableViewCell {
        var cell: HackerTableCell!
        switch self {
        case .ContactView:
            cell =
            tableView.dequeueReusableCellWithIdentifier(reuseIdentifier()) as HackerTableCell.ContactView
        case .FullView:
            cell =
            tableView.dequeueReusableCellWithIdentifier(reuseIdentifier()) as HackerTableCell.FullView
        }
        cell.setupViewData(hacker)
        return cell
        
    }
    
    
}