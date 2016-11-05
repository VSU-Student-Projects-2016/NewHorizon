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
        var imageUrl : String = ""
        var pos : Point
        var width : Double = 0
        var height : Double = 0
        var area : Array<Point> = []
        
        public init(id : Int, size : NSDictionary, position: NSDictionary, image: String, points : Array<NSDictionary>) {
            ID = id
            imageUrl = image
            width = size["width"] as! Double
            height = size["height"] as! Double
            pos = Point(position)
            for p in points {
                area.append(Point(p))
            }
        }
    }
    
    var backgroundUrl : String = ""
    var pos : Point = Point()
    var width : Double = 0
    var height : Double = 0
    
    var regions : Array<Region> = []
    
    public init(_ data: NSDictionary) {
        backgroundUrl = data["bg-image"] as! String
        let regionSizes = data["region_sizes"] as! Array<NSDictionary>
        let regionPoses = data["region-poses"] as! Array<NSDictionary>
        let regionImages = data["region-images"] as! Array<String>
        let regionAreas = data["region-areas"] as! Array<Array<NSDictionary>>
        
        for i in (0..<regionSizes.count) {
            let size = regionSizes[i]
            let pos = regionPoses[i]
            let image = regionImages[i]
            let area = regionAreas[i]
            let region = Region(id: i, size: size, position: pos, image: image, points: area)
            regions.append(region)
        }
    }
}
