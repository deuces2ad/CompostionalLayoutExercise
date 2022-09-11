//
//  LayoutBuilder.swift
//  ComposinalLayoutExercise
//
//  Created by Abhishek Dhiman on 10/09/22.
//

import Foundation
import UIKit

class LayoutBuilder {
    
    static func createCompostionalLayout() -> UICollectionViewCompositionalLayout {
        
        //first Item
        let item = CompositionalLayout.createItem(width: .fractionalWidth(0.5), height: .fractionalHeight(1.0), spacing: 5)
                
        //Second Item
        let fullItem = CompositionalLayout.createItem(width: .fractionalWidth(1.0), height: .fractionalHeight(1.0), spacing: 5)
        
        //Third Item
        let partialItem = CompositionalLayout.createItem(width: .fractionalWidth(1), height: .fractionalHeight(1.0), spacing: 5)
        
        
        let upperGroup = CompositionalLayout.createGroup(alignment: .horizontal, width: .fractionalWidth(1.0), height: .estimated(200), item: item,count: 2)
        
        let middleGroup = CompositionalLayout.createGroup(alignment: .horizontal, width: .fractionalWidth(1.0), height: .fractionalHeight(1/3), item: fullItem,count: 1)
        
        let secondaryLowerGroup = CompositionalLayout.createGroup(alignment: .vertical, width: .fractionalWidth(0.5), height: .fractionalHeight(1.0), item:partialItem, count: 2)
        
        let lowerGroup = CompositionalLayout.createGroup(alignment: .horizontal, width: .fractionalWidth(1.0), height: .estimated(300), items: [secondaryLowerGroup])
        
        
       
        let containerGRP = CompositionalLayout.createGroup(alignment: .vertical, width: .fractionalWidth(1.0), height: .estimated(700), items: [upperGroup,middleGroup,lowerGroup])
        
        containerGRP.contentInsets.leading = 5
        containerGRP.contentInsets.trailing = 5
        
        let section = NSCollectionLayoutSection(group: containerGRP)
        return UICollectionViewCompositionalLayout(section:section )
        
    }
}
