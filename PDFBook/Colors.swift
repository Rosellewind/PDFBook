//
//  Colors.swift
//  AkiraCards
//
//  Created by Roselle Milvich on 9/17/15.
//  Copyright (c) 2015 Roselle Tanner. All rights reserved.
//

import Cocoa

// http://flatUIColors.com/

extension NSColor {
    class func turquoise() -> NSColor {                 // turqoise
        return NSColor.colorComponents(components: (26, 188, 156))
    }
    class func greenSea() -> NSColor {                  // slightly darker turqoise
        return NSColor.colorComponents(components: (22, 160, 133))
    }
    class func sunflower() -> NSColor {                 // yellow
        return NSColor.colorComponents(components: (241, 196, 15))
    }
    class func orange() -> NSColor {                    // orange
        return NSColor.colorComponents(components: (243, 156, 18))
    }
    
    class func emerald() -> NSColor {                   // emerald green
        return NSColor.colorComponents(components: (46, 204, 113))
    }
    class func nephritis() -> NSColor {                 // darker emerald
        return NSColor.colorComponents(components: (39, 174, 96))
    }
    class func carrot() -> NSColor {                    // darker orange
        return NSColor.colorComponents(components: (230, 126, 34))
    }
    class func pumpkin() -> NSColor {                   // darker carrot
        return NSColor.colorComponents(components: (211, 84, 0))
    }
    
    class func peterRiver() -> NSColor {                // blue
        return NSColor.colorComponents(components: (52, 152, 219))
    }
    class func belizeHole() -> NSColor {                // darker peterRiver blue
        return NSColor.colorComponents(components: (41, 128, 185))
    }
    class func alizarin() -> NSColor {                  // red-orange
        return NSColor.colorComponents(components: (231, 76, 60))
    }
    class func pomagranate() -> NSColor {               // darker alizarin red-orange
        return NSColor.colorComponents(components: (192, 57, 43))
    }
    
    class func amethyst() -> NSColor {                  // purple
        return NSColor.colorComponents(components: (155, 89, 182))
    }
    class func wisteria() -> NSColor {                  // darker ametlyst purple
        return NSColor.colorComponents(components: (142, 68, 173))
    }
    class func clouds() -> NSColor {                    // white
        return NSColor.colorComponents(components: (236, 240, 241))
    }
    class func silver() -> NSColor {                    // light gray
        return NSColor.colorComponents(components: (189, 195, 199))
    }
    
    class func wetAsphalt() -> NSColor {                // dark gray
        return NSColor.colorComponents(components: (52, 73, 94))
    }
    class func midnightBlue() -> NSColor {              // midnight dark blue
        return NSColor.colorComponents(components: (44, 62, 80))
    }
    class func concrete() -> NSColor {                  // darker than silver light gray
        return NSColor.colorComponents(components: (149, 165, 166))
    }
    class func asbestos() -> NSColor {                  // darker than concrete gray
        return NSColor.colorComponents(components: (127, 140, 141))
    }



}

private extension NSColor {
    class func colorComponents(components: (CGFloat, CGFloat, CGFloat)) -> NSColor {
        return NSColor(red: components.0/255, green: components.1/255, blue: components.2/255, alpha: 1)
    }
}
