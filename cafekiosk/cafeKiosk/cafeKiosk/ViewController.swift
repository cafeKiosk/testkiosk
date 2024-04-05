//
//  ViewController.swift
//  cafeKiosk
//
//  Created by 문기웅 on 4/1/24.
//

import UIKit

final class ViewController: UIViewController {
    @IBOutlet private weak var categorySegmentControl: UISegmentedControl!
    @IBOutlet private weak var menuCollectionView: UICollectionView!
    @IBOutlet private weak var selectMenuTableView: UITableView!
    @IBOutlet private weak var totalSelectCount: UILabel!
    @IBOutlet private weak var totalSelectPrice: UILabel!
    
    private var menuList = Menu.Coffee.allCases.map { $0.rawValue }
    private var selectedMenuList = [String]()
    private var selectCount: Int = 0
    private var selectPrice: Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        menuCollectionView.delegate = self
        menuCollectionView.dataSource = self
        
        menuCollectionView.isPagingEnabled = true
        
        selectMenuTableView.delegate = self
        selectMenuTableView.dataSource = self
        
        
    }
    
    //컬렉션뷰 여백
    private let sectionInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    
    
    //  카테고리 탭 기능
    @IBAction private func tappedCategory(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            menuList = Menu.Coffee.allCases.map { $0.rawValue }
        case 1:
            menuList = Menu.Beverage.allCases.map { $0.rawValue }
        case 2:
            menuList = Menu.Dessert.allCases.map { $0.rawValue }
        default:
            break
        }
        menuCollectionView.reloadData()
    }
    
    // 하단 버튼 alert (전체삭제버튼과 결제버튼에 테이블뷰를 비우는 작업 필요)
    @IBAction private func callButton(_ sender: Any) {
        let alert1 = UIAlertController(title: "직원 호출", message: "직원을 호출하시겠습니까?", preferredStyle: .alert)
        let confirm1 = UIAlertAction(title: "예", style: .default)
        let cancel1 = UIAlertAction(title: "취소", style: .default)
        
        alert1.addAction(confirm1)
        alert1.addAction(cancel1)
        present(alert1, animated: true)
    }
    
    @IBAction private func cancelButton(_ sender: Any) {
        let alert2 = UIAlertController(title: "주문 전체 삭제", message: "주문을 모두 삭제하시겠습니까?", preferredStyle: .alert)
        let confirm2 = UIAlertAction(title: "예", style: .default, handler: { [self]_ in
            self.selectCount = 0
            self.selectPrice = 0
            self.totalSelectCount.text = String(selectCount)
            self.totalSelectPrice.text = String(selectPrice)
            self.selectedMenuList.removeAll()
            selectMenuTableView.reloadData()
        })
        let cancel2 = UIAlertAction(title: "취소", style: .default)
        
        alert2.addAction(confirm2)
        alert2.addAction(cancel2)
        present(alert2, animated: true)
    }
    
    @IBAction private func payButton(_ sender: Any) {
        let alert3 = UIAlertController(title: "결제", message: "결제 하시겠습니까?", preferredStyle: .alert)
        let confirm3 = UIAlertAction(title: "예", style: .default, handler: { [self]_ in
            self.selectCount = 0
            self.selectPrice = 0
            self.totalSelectCount.text = String(selectCount)
            self.totalSelectPrice.text = String(selectPrice)
            self.selectedMenuList.removeAll()
            selectMenuTableView.reloadData()

            orderCheck()                                                                 
        })
        let cancel3 = UIAlertAction(title: "취소", style: .default)
        
        alert3.addAction(confirm3)
        alert3.addAction(cancel3)
        present(alert3, animated: true)
    }
    
    @IBAction private func orderCheck() {
        let orderTilt = "주문 완료"
        let orderMessage = "주문되었습니다!"
        
        let alert = UIAlertController(title: orderTilt, message: orderMessage, preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "확인", style: .default) { _ in
        }
        
        alert.addAction(confirmAction)
        
        present(alert, animated: true, completion: nil)
    }
}

// 컬렉션뷰에 데이터 전달
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = menuCollectionView.dequeueReusableCell(withReuseIdentifier: "MenuCell", for: indexPath) as? MenuCell else { return UICollectionViewCell() }
        
        let menuItem = menuList[indexPath.row]
        cell.menuName.text = menuItem

        if let coffee = Menu.Coffee(rawValue: menuItem) {
            cell.menuPrice.text = "\(coffee.price)원"
            cell.menuImage.image = coffee.image
        } else if let beverage = Menu.Beverage(rawValue: menuItem) {
            cell.menuPrice.text = "\(beverage.price)원"
            cell.menuImage.image = beverage.image
        } else if let dessert = Menu.Dessert(rawValue: menuItem) {
            cell.menuPrice.text = "\(dessert.price)원"
            cell.menuImage.image = dessert.image
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if !selectedMenuList.contains(menuList[indexPath.row]) {
            selectedMenuList.append(menuList[indexPath.row])
        }
        
        selectCount += 1
        
        if let coffee = Menu.Coffee(rawValue: menuList[indexPath.row]) {
            selectPrice += coffee.price
        } else if let beverage = Menu.Beverage(rawValue: menuList[indexPath.row]) {
            selectPrice += beverage.price
        } else if let dessert = Menu.Dessert(rawValue: menuList[indexPath.row]) {
            selectPrice += dessert.price
        }
        
        totalSelectCount.text = String(selectCount)
        totalSelectPrice.text = String(selectPrice)
        
        selectMenuTableView.reloadData()
    }
    
    
    //컬렉션뷰 셀 사이즈 2*2
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        let height = collectionView.frame.height
        let itemsPerRow: CGFloat = 2
        let widthPadding = sectionInsets.left * (itemsPerRow + 1)
        let itemsPerColumn: CGFloat = 2
        let heightPadding = sectionInsets.top * (itemsPerColumn + 1)
        let cellWidth = (width - widthPadding) / itemsPerRow
        let cellHeight =  cellWidth * 1.2 //(height - heightPadding) / itemsPerColumn
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    //좌우간격 최소값
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}




// 선택된 메뉴를 테이블뷰 데이터 전달
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedMenuList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = selectMenuTableView.dequeueReusableCell(withIdentifier: "SelectedCell", for: indexPath) as? SelectedCell else { return UITableViewCell() }
        
        let menuItem = selectedMenuList[indexPath.row]

        if let coffee = Menu.Coffee(rawValue: menuItem) {
            cell.selectMenuName.text = coffee.rawValue
            cell.selectImage.image = coffee.image
        } else if let beverage = Menu.Beverage(rawValue: menuItem) {
            cell.selectMenuName.text = beverage.rawValue
            cell.selectImage.image = beverage.image
        } else if let dessert = Menu.Dessert(rawValue: menuItem) {
            cell.selectMenuName.text = dessert.rawValue
            cell.selectImage.image = dessert.image
        }
        //희라 : 중복된거 수정하실때 이부분에 cell.selectMenuCount.text 카운트 더해지도록하면될거같아요
        
        return cell
    }
}



final class MenuCell: UICollectionViewCell {
    @IBOutlet weak var menuName: UILabel!
    @IBOutlet weak var menuPrice: UILabel!
    @IBOutlet weak var menuImage: UIImageView!
}



final class SelectedCell: UITableViewCell {
    @IBOutlet weak var selectImage: UIImageView!
    @IBOutlet weak var selectMenuName: UILabel!
    
    //희라 추가
    //스탭퍼 min 1, max 9
    @IBOutlet weak var selectStepper: UIStepper!
    @IBOutlet weak var selectMenuCount: UILabel!
    @IBAction func selectStepperAct(_ sender: UIStepper) {
        selectMenuCount.text = Int(sender.value).description
    }
}

