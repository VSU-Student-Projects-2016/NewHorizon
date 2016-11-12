//
//  Map.swift
//  NewHorizon
//
//  Created by xcode on 22.10.16.
//  Copyright © 2016 NewHorizon. All rights reserved.
//

import Foundation

class Map {
    public class Point {
        var x : Double = 0
        var y : Double = 0

        public init() {
            
        }
        
        public init(_ data: NSDictionary) {
            x = data["x"] as! Double
            y = data["y"] as! Double
        }
    }
    
    public class Region {
        var ID : Int
        var type : Int
        var owner: Int
        var pos : Point
        var width : Double = 0
        var height : Double = 0
        var area : Array<Point> = []
        
        public init(id : Int, owner: Int, size : NSDictionary, position: NSDictionary, type : Int, points : Array<NSDictionary>) {
            self.ID = id
            self.type = type
            self.owner = owner
            self.pos = Point(position)
            width = size["width"] as! Double
            width /= 100
            height = size["height"] as! Double
            height /= 100
            for p in points {
                area.append(Point(p))
            }
        }
    }
    
    var pos : Point = Point()
    var width : Double = 0
    var height : Double = 0
    
    var regions : Array<Region> = []
    
    public init(_ data: NSDictionary) {
        let regionSizes = data["region-sizes"] as! Array<NSDictionary>
        let regionPoses = data["region-poses"] as! Array<NSDictionary>
        let regionTypes = data["region-types"] as! Array<Int>
        let regionAreas = data["region-areas"] as! Array<Array<NSDictionary>>
        let regionOwner = data["region-owner"] as! Array<Int>
        
        
        for i in (0..<regionSizes.count) {
            let size = regionSizes[i]
            let pos = regionPoses[i]
            let type = regionTypes[i]
            let area = regionAreas[i]
            let owner = regionOwner[i]
            
            let region = Region(id: i, owner: owner, size: size, position: pos, type: type, points: area)
            regions.append(region)
        }
    }
}
