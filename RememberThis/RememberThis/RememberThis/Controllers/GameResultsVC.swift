//
//  GameResultsVC.swift
//  RememberThis
//
//  Created by Uchenna  Aguocha on 12/12/17.
//  Copyright © 2017 Uchenna  Aguocha. All rights reserved.
//

import UIKit

class GameResultsVC: UIViewController {

    var guesses: [String: [String]] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension GameResultsVC: UICollectionViewDataSource {
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return (guesses["wrong"]?.count)!
        } else {
            return (guesses["correct"]?.count)!
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionElementKindSectionHeader else {
            fatalError("Unexpected element kind.")
        }
        
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "gameResults", for: indexPath) as! GameResultsCollectionReusableView
        
        if indexPath.section == 0 {
            headerView.wrongOrCorrectLabel.text = "Wrong"
            headerView.layer.backgroundColor = UIColor.red.cgColor
            
            return headerView
        } else {
            headerView.wrongOrCorrectLabel.text = "Correct"
            headerView.layer.backgroundColor = UIColor.green.cgColor
            
            return headerView
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "gameResultsCell", for: indexPath) as! GameResultsCollectionViewCell
        let row = indexPath.row
        
        cell.layer.cornerRadius = 6
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 1
        
        if indexPath.section == 0 {
            cell.personFaceImageView.getImageFromURL(url: guesses["wrong"]![row])
        } else {
            cell.personFaceImageView.getImageFromURL(url: guesses["correct"]![row])
        }
        
        return cell
    }
    
}

extension GameResultsVC: UICollectionViewDelegateFlowLayout {
    // sets collectionview cell size and space between each cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // returns cell size, 3 cells in each row
        let columns: CGFloat = 3
        let spacing: CGFloat = 1.5
        let totalHorizontalSpacing = (columns - 1) * spacing
        
        let itemWidth = (collectionView.bounds.width - totalHorizontalSpacing) / columns
        let itemSize = CGSize(width: itemWidth, height: itemWidth)
        
        return itemSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1.5
    }
}
