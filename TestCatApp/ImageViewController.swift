//
//  ImageViewController.swift
//  TestCatApp
//
//  Created by Alex Stepanov on 20.05.2020.
//  Copyright © 2020 Alex Stepanov. All rights reserved.
//

import UIKit

class ImageViewController: UICollectionViewController {
    
    var imagesUrl = [Image]()
    let url = "https://api.thecatapi.com/v1/images/search"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getCatsImagesUrl(url: url, params: ["limit" : "50"])
        
    }
    
    func getCatsImagesUrl(url: String, params: [String: String]) {
        
        let urlComp = NSURLComponents(string: url)!
        var items = [URLQueryItem]()
        
        for (key,value) in params {
            items.append(URLQueryItem(name: key, value: value))
        }
        items = items.filter{!$0.name.isEmpty}
        
        if !items.isEmpty {
            urlComp.queryItems = items
        }
        
        var urlRequest = URLRequest(url: urlComp.url!)
        urlRequest.httpMethod = "GET"
        let config = URLSessionConfiguration.default
        config.httpAdditionalHeaders = [
            "x-api-key": "befbb750-1656-45fb-b236-c8f8a1fc733d"]
        let session = URLSession(configuration: config)
        session.dataTask(with: urlRequest) { (data, _, _) in
            
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                self.imagesUrl = try decoder.decode([Image].self, from: data)
            } catch let error { print("Error serialization json", error) }
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
            
            }.resume()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "image" else { return }
        guard let destination = segue.destination as? DetailImageViewController else {return }
        destination.myTuple = sender as! (selectedImage: CollectionViewCell?, imagesName: String?)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesUrl.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        
        let link = imagesUrl[indexPath.row].url
        cell.imageView.downloaded(from: link)
        cell.imageView.clipsToBounds = true
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let selectedImageCell = collectionView.cellForItem(at: indexPath) as! CollectionViewCell
        
        if let categories = imagesUrl[indexPath.row].categories {
            
            let myTuple = (selectedImage: selectedImageCell, imagesName: categories[0].name?.uppercased())
            performSegue(withIdentifier: "image", sender: myTuple)
        }
        else {
            let myTuple = (selectedImage: selectedImageCell, imagesName: "Unknown image name")
            performSegue(withIdentifier: "image", sender: myTuple)
            
        }
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        
        let size = CGSize(width: 100, height: 100)
        return size
    }
    
    
    
}


