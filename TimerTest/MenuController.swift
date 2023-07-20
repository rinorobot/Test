//
//  MenuController.swift
//  TimerTest
//
//  Created by Salvador Gómez Moya on 19/07/23.
//

import UIKit

//Configuramos el menú lateral
class MenuController: UITableViewController{
    private let menuItems: [String]
    
    init(with menuItems: [String]) {
        self.menuItems = menuItems
        super.init(nibName: nil, bundle: nil)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        tableView.backgroundColor = .orange
        tableView.separatorStyle = .none
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let icons = [" "," "," ","gearshape.fill"," "," "," "," ","doc.text"]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = menuItems[indexPath.row]
        cell.textLabel?.textColor = .black
        cell.textLabel?.font = .boldSystemFont(ofSize: 20.0)
        cell.contentView.backgroundColor = .orange
        let imageView = UIImageView(frame: CGRectMake(10, 15, 25, 25));
        let image = UIImage(systemName: icons[indexPath.row]);
        imageView.image = image;
        cell.imageView?.image = imageView.image
        cell.imageView?.tintColor = .gray

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let story = UIStoryboard(name: "Main", bundle: nil)
        
       let configutationViewController = story.instantiateViewController(withIdentifier: "story") as! ConfigurationViewController
       
        let comentsViewController = story.instantiateViewController(withIdentifier: "comentsStory") as! ComentsViewController
        
        if (indexPath.row == 3){
           self.navigationController!.pushViewController(configutationViewController, animated: true)
        }
        
        if (indexPath.row == 8){
            self.navigationController!.pushViewController(comentsViewController, animated: true)
        }
        
    }
    
}


