//
//  UITableView+Cell.swift
//  Kcell-Activ
//
//  Created by Nurlan Tolegenov on 2/25/20.
//  Copyright © 2020 Azimut Labs. All rights reserved.
//

import UIKit

extension UITableView {
    func register(cellClass: AnyClass) {
        let nib = UINib(nibName: "\(cellClass)", bundle: Bundle(for: cellClass))
        register(nib, forCellReuseIdentifier: "\(cellClass)")
    }

    func register(aClass: AnyClass) {
        let nib = UINib(nibName: "\(aClass)", bundle: Bundle(for: aClass))
        register(nib, forHeaderFooterViewReuseIdentifier: "\(aClass)")
    }
    
    func register<T: UITableViewCell>(_: T.Type) {
        register(T.self, forCellReuseIdentifier: NSStringFromClass(T.self))
    }
    
    func register<T: UITableViewHeaderFooterView>(view: T.Type) {
        register(T.self, forHeaderFooterViewReuseIdentifier: NSStringFromClass(T.self))
    }
    
    func dequeueReusableCell<Cell: UITableViewCell>(for indexPath: IndexPath) -> Cell {
        guard let cell = dequeueReusableCell(withIdentifier: NSStringFromClass(Cell.self), for: indexPath) as? Cell else {
            fatalError("register(cellClass:) has not been implemented")
        }
        return cell
    }
    
    func dequeueReusableHeaderFooterView<Cell: UITableViewHeaderFooterView>() -> Cell {
        guard let view = dequeueReusableHeaderFooterView(withIdentifier: NSStringFromClass(Cell.self)) as? Cell else {
            fatalError("register(aClass:) has not been implemented")
        }
        return view
    }
    
    func dequeueReusableCell<T: UITableViewCell>(forIndexPath indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: NSStringFromClass(T.self), for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(NSStringFromClass(T.self))")
        }
        return cell
    }
    
    func dequeueReusableHeaderFooter<T: UITableViewHeaderFooterView>() -> T {
        guard let headerFooter = dequeueReusableHeaderFooterView(withIdentifier: NSStringFromClass(T.self)) as? T else {
            fatalError("Could not dequeue cell with identifier: \(NSStringFromClass(T.self))")
        }
        return headerFooter
    }
}
