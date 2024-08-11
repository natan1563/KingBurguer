//
//  ProfileViewController.swift
//  KingBurguer
//
//  Created by Natã Romão on 16/02/23.
//

import UIKit

class ProfileViewController: UITableViewController {
    
    var data: [ (String, String) ] = []
    
    override init(style: UITableView.Style) {
        super.init(style: style)
        
        self.tabBarItem.image = UIImage(systemName: "person.circle")
        self.tabBarItem.title = "Perfil"
        
        tableView.register(ProfileCell.self, forCellReuseIdentifier: ProfileCell.identifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var viewModel: ProfileViewModel? {
        didSet {
            viewModel?.delegate = self
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        
        if viewModel?.state == .loading {
            viewModel?.fetch()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Perfil"
        tableView.backgroundColor = .systemGray6
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProfileCell.identifier, for: indexPath) as! ProfileCell
        
        cell.data = data[indexPath.row]
        
        cell.isUserInteractionEnabled = false
        return cell
    }
}

extension ProfileViewController: ProfileViewModelDelegate {
    func viewModelDidChanged(state: ProfileState) {
        switch(state) {
            case .loading:
                break
                
            case .success(let response):
                let doc = Mask(mask: "###.###.###-##").process(value: response.document) ?? "formato não definido"
                
                let birthdayFormatted = response.birthday.toDate(dateFormat: "yyyy-MM-dd")?.toString(dateFormat: "dd/MM/yyyy")
                
                data.append( ("Identificador", "\(response.id)") )
                data.append( ("Nome", response.name) )
                data.append( ("E-mail", response.email) )
                data.append( ("Documento", doc) )
                data.append( ("Data de Nascimento", birthdayFormatted ?? "formato nao especificado") )
                tableView.reloadData()
                break
                
            case .error(let msg):
                alert(message: msg)
                break
        }
    }
}
