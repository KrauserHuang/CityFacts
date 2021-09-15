//
//  ViewController.swift
//  CityFacts
//
//  Created by Tai Chin Huang on 2021/9/14.
//

import UIKit

class CityViewController: UITableViewController {
    
    var countries = [Country]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "City Facts"
        navigationController?.navigationBar.prefersLargeTitles = true
        loadCountries()
    }
    
    func loadCountries() {
        NetworkController.shared.fetchCountryData { [weak self] searchResponse in
            guard let self = self else { return }
            
            if let data = searchResponse {
                self.countries = data
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    //MARK: - Table View DataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCell", for: indexPath)
        
        let country = countries[indexPath.row]
        cell.textLabel?.text = country.name
        
        let capital = country.capital == "" ? "" : "Capital: \(country.capital)"
        cell.detailTextLabel?.text = capital
        
        return cell
    }
    //MARK: - Table View Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let detailVC = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else {
            fatalError("Fail to load DetailViewController")
        }
        let country = countries[indexPath.row]
        detailVC.country = country
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

