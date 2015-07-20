//
//  PConstraintsChanger.swift
//  Phantom of the West
//
//  Created by Christopher Raleigh on 2015/19/07.
//  Copyright (c) 2015 Christopher Raleigh. All rights reserved.
//

import Foundation

/*
Contains methods for reacting to interface orientation changes.
*/
protocol PConstraintsChanger {
    /*
    Add new constraints after device rotates.
    */
    func addOrientationConstraints(orientation: UIInterfaceOrientation)
    
    /*
    Remove old constraints before device rotates.
    */
    func removeOrientationConstraints()
}