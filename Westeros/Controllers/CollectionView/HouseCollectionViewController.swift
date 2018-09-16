//
//  HouseCollectionViewController.swift
//  Westeros
//
//  Created by Alexandre Freire on 16/09/2018.
//  Copyright © 2018 Westeros. All rights reserved.
//

import UIKit

class HouseCollectionViewController: UIViewController {
    // Mark: - Constants
    enum Constants {
        static let columns: CGFloat = 3
        static let itemSpacing: CGFloat = 10
        static let itemHeight: CGFloat = 60
    }
    
    // Mark: - Outlets
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            let nib = UINib(nibName: "HouseCollectionViewCell", bundle: nil)
            collectionView.register(nib, forCellWithReuseIdentifier: "CellId")
        }
    }
    
    // Mark: - Properties
    let model: [House]
    private let collectionViewLayout: UICollectionViewFlowLayout
    
    // Mark: - Initialization
    init(houses: [House], collectionViewLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()) {
        self.model = houses
        self.collectionViewLayout = collectionViewLayout
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Mark: - Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
    }
    
    // Mark: - Setup View
    func calculateItemWidth() -> CGFloat {
        let viewWidth: CGFloat = view.frame.size.width
        let totalSpacing: CGFloat = (Constants.columns - 1) * Constants.itemSpacing
        
        return (viewWidth - totalSpacing) / Constants.columns
    }
    
    func setupView() {
        

        collectionView.dataSource = self
        let width = calculateItemWidth()
        collectionViewLayout.itemSize = CGSize(width: width, height: width)
        collectionView.collectionViewLayout = collectionViewLayout
    }
}


extension HouseCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // Obtenemos la celda
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellId", for: indexPath) as! HouseCollectionViewCell

        // Obtenemos la casa
        let house = model[indexPath.item]

        // Sincronizamos modelo y vista
        cell.imageView.image = house.sigil.image
        cell.nameLabel.text = house.name
        cell.wordsLabel.text = house.words
        
        return cell
        
    }
    
    
}
