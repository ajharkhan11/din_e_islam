//
//  MoreViewController.swift
//  din-e-islam
//
//  Created by Ajharudeen Khan on 27/09/22.
//

import UIKit

class MoreViewController: UIViewController {
    @IBOutlet weak var moreCollectionView: UICollectionView!
    
    private var moreViewModel : MoreViewModel!
    
    private var moreHorizontalCellIdentifier = "more_horizontal_cell"
    
    private var moreVerticalCellIdentifier = "more_vertical_cell"
    
    private let sectionInsets = UIEdgeInsets(
      top: 10.0,
      left: 10.0,
      bottom: 10.0,
      right: 10.0)
    
    private let itemsPerRow: CGFloat = 4
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.moreCollectionView.register(UINib.init(nibName: "HorizontalCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: moreHorizontalCellIdentifier)
        self.moreCollectionView.register(UINib.init(nibName: "VerticalCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: moreVerticalCellIdentifier)
        self.callFunctionToUIUpdate()
    }

    func callFunctionToUIUpdate()  {
        self.moreViewModel = MoreViewModel()
        self.moreViewModel.bindMoreViewModelToController = {
            DispatchQueue.main.async {
                self.moreCollectionView.delegate = self
                self.moreCollectionView.dataSource = self
//                self.moreCollectionView.layout
                self.moreCollectionView.reloadData()
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MoreViewController : UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return self.moreViewModel.moreModel.horizontal?.count ?? 0
        }
        return self.moreViewModel.moreModel.vertical?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let collectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: moreHorizontalCellIdentifier, for: indexPath) as! HorizontalCollectionViewCell
            let horizontalData = self.moreViewModel.moreModel.horizontal?[indexPath.row]
            collectionViewCell.horizontal_image.image = UIImage.init(named: horizontalData?.image_name ?? "")
            collectionViewCell.horizontal_text.text = horizontalData?.title
            return collectionViewCell
        }
        let collectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: moreVerticalCellIdentifier, for: indexPath) as! VerticalCollectionViewCell
        let verticalData = self.moreViewModel.moreModel.vertical?[indexPath.row]
        collectionViewCell.vertical_image.image = UIImage.init(named: verticalData?.image_name ?? "")
        collectionViewCell.vertical_text.text = verticalData?.title
        return collectionViewCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            let paddingSpace = indexPath.section == 0 ? sectionInsets.left * (itemsPerRow + 1) : sectionInsets.left * (1 + 1)
            let availableWidth = collectionView.frame.width - paddingSpace
            let widthPerItem = availableWidth / itemsPerRow

            return CGSize.init(width: widthPerItem, height: widthPerItem)
        }
        let paddingSpace = sectionInsets.left + sectionInsets.right
        let availableWidth = collectionView.frame.width - paddingSpace

        return CGSize.init(width: availableWidth, height: 44)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
    
}
