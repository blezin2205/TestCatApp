//
//  ViewController.swift
//  TestCatApp
//
//  Created by Alex Stepanov on 19.05.2020.
//  Copyright © 2020 Alex Stepanov. All rights reserved.
//

import UIKit

class CatsBreedsController: UITableViewController {
    
    let url = "https://api.thecatapi.com/v1/breeds"
    var catsBreeds = [Cats]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Cats breeds"
        fetchCatsBreedsJSON()
    }
    
    private func fetchCatsBreedsJSON()  {
        
        guard let url = URL(string: url) else { return }
        
        let config = URLSessionConfiguration.default
        config.httpAdditionalHeaders = [
            "Accept": "application/json",
            "x-api-key": "befbb750-1656-45fb-b236-c8f8a1fc733d"
        ]
        
        let session = URLSession(configuration: config)
        session.dataTask(with: url) { (data, _, _) in
            
            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                self.catsBreeds = try decoder.decode([Cats].self, from: data)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch let error {
                print("Error serialization json", error)
            }
            
            }.resume()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return catsBreeds.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        let breed = catsBreeds[indexPath.row]
        cell.textLabel?.text = breed.name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let breed = catsBreeds[indexPath.row]
        
        
        performSegue(withIdentifier: "description", sender: breed)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "description" else { return }
        guard let destination = segue.destination as? DescriptionViewController else {return }
        destination.selectedBreed = (sender as! Cats)
    }
    
}




