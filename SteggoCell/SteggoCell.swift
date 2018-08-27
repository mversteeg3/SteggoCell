//
//  SteggoCell.swift
//  SteggoCell
//
//  Created by Matt Versteeg on 8/27/18.
//  Copyright © 2018 SteggoSoft. All rights reserved.
//

import Foundation
import UIKit

public protocol SteggoCell: class{
    static var xib: String {get}
    static var reuseId: String {get}
}

extension SteggoCell{
    // Defaults
    public static var xib: String{
        return String(describing: Self.self)
    }
    public static var reuseId: String{
        return xib
    }
}

extension SteggoCell where Self: UITableViewCell{
    public static func register(for tableView: UITableView){
        tableView.register(UINib(nibName: xib, bundle: Bundle(for: Self.self)), forCellReuseIdentifier: reuseId)
    }
    
    public static func dequeue(from tableView: UITableView, at indexPath: IndexPath) -> Self{
        return tableView.dequeueReusableCell(withIdentifier: reuseId, for: indexPath) as! Self
    }
}

extension SteggoCell where Self: UICollectionViewCell{
    public static func register(for collectionView: UICollectionView){
        collectionView.register(UINib(nibName: xib, bundle: Bundle(for: Self.self)), forCellWithReuseIdentifier: reuseId)
    }
    public static func dequeue(from collectionView: UICollectionView, at indexPath: IndexPath) -> Self{
        return collectionView.dequeueReusableCell(withReuseIdentifier: reuseId, for: indexPath) as! Self
    }
}

public protocol SteggoDataCell: SteggoCell{
    associatedtype DataType
    func setup(with: DataType)
}

extension SteggoDataCell where Self: UITableViewCell{
    static func dequeue(from tableView: UITableView, at indexPath: IndexPath, with data: DataType) -> Self{
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseId, for: indexPath) as! Self
        cell.setup(with: data)
        return cell
    }
}

extension SteggoDataCell where Self: UICollectionViewCell{
    static func dequeue(from collectionView: UICollectionView, at indexPath: IndexPath, with data: DataType) -> Self{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseId, for: indexPath) as! Self
        cell.setup(with: data)
        return cell
    }
}

