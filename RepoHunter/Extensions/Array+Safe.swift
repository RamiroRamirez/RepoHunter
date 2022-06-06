//
//  Array+Safe.swift
//  RepoHunter
//
//  Created by Ramirez-Hernandez, Ramiro on 06.06.22.
//

import Foundation

extension Array {

    subscript(safe index: Int) -> Element? {
        return ((self.indices ~= index) ? self[index] : nil)
    }
}
