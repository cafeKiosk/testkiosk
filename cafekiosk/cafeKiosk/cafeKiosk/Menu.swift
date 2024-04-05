//
//  MenuData.swift
//  cafeKiosk
//
//  Created by 문기웅 on 4/2/24.
// 

import UIKit

struct Menu {
    enum Coffee: String, CaseIterable {
        case americano = "아메리카노"
        case cafeLatte = "카페라떼"
        case caramelMacchiato = "카라멜마끼아또"
        case dolceLatte = "돌체라떼"
        
        var price: Int {
            switch self {
            case .americano:
                return 4500
            case .cafeLatte:
                return 5000
            case .caramelMacchiato:
                return 5500
            case .dolceLatte:
                return 5500
            }
        }
        
        var image: UIImage? {
            switch self {
            case .americano:
                return UIImage(named: "ameri")
            case .cafeLatte:
                return UIImage(named: "latte")
            case .caramelMacchiato:
                return UIImage(named: "caramel")
            case .dolceLatte:
                return UIImage(named: "dolce")
            }
        }
    }
    
    enum Beverage: String, CaseIterable {
        case lemonAde = "레몬에이드"
        case milkChoco = "밀크초코"
        case matchaLatte = "말차라떼"
        case mangoSmoothie = "망고스무디"
        
        var price: Int {
            switch self {
            case .lemonAde:
                return 5500
            case .milkChoco:
                return 5500
            case .matchaLatte:
                return 6000
            case .mangoSmoothie:
                return 6000
            }
        }
        
        var image: UIImage? {
            switch self {
            case .lemonAde:
                return UIImage(named: "lemon")
            case .milkChoco:
                return UIImage(named: "milkChoco")
            case .matchaLatte:
                return UIImage(named: "matcha")
            case .mangoSmoothie:
                return UIImage(named: "mango")
            }
        }
    }
    
    enum Dessert: String, CaseIterable {
        case chocoCake = "초코케이크"
        case pecanPie = "피칸파이"
        case cheeseCake = "치즈케이크"
        
        var price: Int {
            switch self {
            case .chocoCake:
                return 5500
            case .pecanPie:
                return 5500
            case .cheeseCake:
                return 5500
            }
        }
        
        var image: UIImage? {
            switch self {
            case .chocoCake:
                return UIImage(named: "chocoCake")
            case .pecanPie:
                return UIImage(named: "pecan")
            case .cheeseCake:
                return UIImage(named: "cheeseCake")
            }
        }
    }
}
