//
//  ImageCache.swift
//  SuperHeroes
//
//  Created by Artem Zhuzhgin on 24.01.2022.
//
import UIKit

class ImageCache {
    
    static let shared = NSCache<NSString,UIImage>()
    private init() {}
    
}
