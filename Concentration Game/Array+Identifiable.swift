//
//  Array+Index.swift
//  Concentration Game
//
//  Created by Stephen Brockbank  on 10/19/23.
//

import Foundation

extension Array where Element: Identifiable {
    func firstIndex(matching targetElement: Element) -> Int? {
        for index in self.indices {
            if self[index].id == targetElement.id {
                return index
            }
        }
        return nil
    }
}
