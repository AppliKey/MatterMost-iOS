//
//  AddMembersCell.swift
//  Mattermost
//
//  Created by Vladimir Kravchenko on 12/28/16.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import UIKit

class AddMembersCell: UITableViewCell, NibReusable {
    
    func configure(with membersInfo: MembersInfoRepresentation?) {
        if let membersInfo = membersInfo {
            imageUrls = membersInfo.urls
            membersCount = membersInfo.count
        } else {
            imageUrls = []
        }
        collectionView.reloadData()
    }

    //MARK: - Outlets
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        localizeViews()
        configureCollectionView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageUrls = []
        membersCount = 0
    }
    
    //MARK: - Private
    fileprivate var imageUrls = Array<URL>()
    fileprivate var membersCount = 0
    
    private func localizeViews() {
        label.text = R.string.localizable.addMembersLabel().uppercased().separatedWithSpaces
    }
    
    //MARK: - Collection view
    
    private func configureCollectionView() {
        collectionView.register(cellType: ImageCollectionViewCell.self)
        collectionView.register(cellType: LabelCollectionViewCell.self)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
}

extension AddMembersCell: UICollectionViewDataSource { //MARK: - UICollectionViewDataSource -
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return min(membersCount, 5)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if membersCount >= 5 && indexPath.row == 4 {
            let cell = collectionView.dequeueReusableCell(for: indexPath) as LabelCollectionViewCell
            cell.titleLabel.text = "+" + "\(membersCount - 4)"
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(for: indexPath) as ImageCollectionViewCell
            cell.imageView.setRoundedImage(withUrl: imageUrls[indexPath.row])
            return cell
        }
    }
    
}

extension AddMembersCell: UICollectionViewDelegateFlowLayout { //MARK: - UICollectionViewDelegateFlowLayout -
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.height, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
}
