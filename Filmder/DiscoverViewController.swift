//
//  DiscoverViewController.swift
//  Filmder
//
//  Created by MacNicolas on 20/12/2018.
//  Copyright © 2018 civetdelapin. All rights reserved.
//

import UIKit
import Koloda
import Kingfisher
import TMDBSwift

private var numberOfCards: Int = 1

class DiscoverViewController: UIViewController {

    @IBOutlet weak var kolodaView: KolodaView!
    
    private var apikey = "bb43e72055ce4efbf7bedaad66a91e6d"
    
    
    fileprivate var dataSource: [UIImage] = {
        
        var array: [UIImage] = []
        for index in 0..<numberOfCards {
            array.append(UIImage(named: "Film")!)
        }
        
        return array
    }()
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TMDBConfig.apikey = self.apikey
        
        kolodaView.dataSource = self
        kolodaView.delegate = self
        
        self.modalTransitionStyle = UIModalTransitionStyle.flipHorizontal
    }
    
    // MARK: IBActions
    
    @IBAction func leftButtonClick(_ sender: UIButton) {
        kolodaView?.swipe(.left)
    }
    
    @IBAction func rightButtonClick(_ sender: UIButton) {
        kolodaView?.swipe(.right)
    }
    

}

// MARK: KolodaViewDelegate

extension DiscoverViewController: KolodaViewDelegate {
    
    func kolodaDidRunOutOfCards(_ koloda: KolodaView) {
        let position = kolodaView.currentCardIndex
        for i in 1...4 {
            dataSource.append(UIImage(named: "Film")!)
        }
        kolodaView.insertCardAtIndexRange(position..<position + 4, animated: true)
    }
    
    func koloda(_ koloda: KolodaView, didSelectCardAt index: Int) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let popViewController:PopViewController = storyBoard.instantiateViewController(withIdentifier: "popViewController") as! PopViewController
        
        popViewController.movie = MoviesHandler.GetInstance().GetMovieAtIndex(index: index)
        
        if(popViewController.movie != nil){
            self.navigationController?.pushViewController(popViewController, animated: true)
        }
        
        //self.present(popViewController, animated: true, completion: nil)
    }
    
    func koloda(_ koloda: KolodaView, didSwipeCardAt index: Int, in direction: SwipeResultDirection) {
        
        var movie = MoviesHandler.GetInstance().GetMovieAtIndex(index: index)
        
        if(direction == .right){
            
            //ACTION DE SWIP DROITE ICI
            print("Swip right")
            DataBase.GetInstance().insertMovie(movie: movie!, wichList : 1)
        }else{
            
            //ACTION DE SWIP GAUCHE ICI
            print("Swip left")
            DataBase.GetInstance().insertMovie(movie: movie!, wichList : 0)
        }
    }
    
}

// MARK: KolodaViewDataSource

extension DiscoverViewController: KolodaViewDataSource {
    
    func kolodaNumberOfCards(_ koloda: KolodaView) -> Int {
        return dataSource.count
    }
    
    func kolodaSpeedThatCardShouldDrag(_ koloda: KolodaView) -> DragSpeed {
        return .default
    }
    
    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
        
        var imageView = UIImageView(image: dataSource[Int(index)]);
        MoviesHandler.GetInstance().GetMovieAtIndex(index: index){ data in
            
            var urlString = "https://image.tmdb.org/t/p/original"+(data?.poster_path)!
            
            let url = URL(string: urlString)
            imageView.kf.setImage(with: url)
        }
        
        return imageView
    }
    
    func koloda(_ koloda: KolodaView, viewForCardOverlayAt index: Int) -> OverlayView? {
        //return Bundle.main.loadNibNamed("OverlayView", owner: self, options: nil)?[0] as? OverlayView
        return OverlayView()
    }
}

