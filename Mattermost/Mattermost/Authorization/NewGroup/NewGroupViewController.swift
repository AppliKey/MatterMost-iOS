//
//  NewGroupNewGroupViewController.swift
//  Mattermost
//
//  Created by Vladimir Kravchenko on 19/12/2016.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation
import UIKit
import RSKPlaceholderTextView

class NewGroupViewController: UIViewController {
	
	//MARK: - Properties
  	var eventHandler: NewGroupEventHandling!
    
    //MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
  
  	//MARK: - Life cycle

	override func viewDidLoad() {
		super.viewDidLoad()
        configureInterface()
	}

    //MARK: - Private -
    private var keyboardHandler: KeyboardHandler?
    private var tapRecognizer: HideKeyboardRecognizer?
    fileprivate var type: GroupType = .private {
        didSet {
            switch type {
            case .public:
                self.navigationItem.title = R.string.localizable.publicGroupTitle()
            case .private:
                self.navigationItem.title = R.string.localizable.privateGroupTitle()
            }
            let sectionsSet = IndexSet(integer: Section.groupInfo.rawValue)
            tableView.reloadSections(sectionsSet, with: .automatic)
        }
    }
    fileprivate var name: String = ""
    fileprivate var url: String = ""
    fileprivate var purpose: String = ""
    fileprivate var searchText: String = ""
    fileprivate var users = Array<UserRepresantation>()
    fileprivate var membersInfo: MembersInfoRepresentation?

	//MARK: - UI
    
    private func configureInterface() {
        self.type = .private
        localizeViews()
        configureTableView()
        tapRecognizer = HideKeyboardRecognizer(withView: view)
        setupKeyboardHandler()
        eventHandler.viewDidLoad()
    }
    
    private func localizeViews() {
    }
    
    private func configureTableView() {
        tableView.register(cellType: NewGroupTypeCell.self)
        tableView.register(cellType: NewGroupTextCell.self)
        tableView.register(cellType: GroupMemberCell.self)
        tableView.register(cellType: SearchCell.self)
        tableView.register(cellType: AddMembersCell.self)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func setupKeyboardHandler() {
        keyboardHandler = KeyboardHandler(withView: tableView)
    }

}

extension NewGroupViewController: NewGroupViewing { //MARK: - NewGroupViewing -
    
    func show(_ users: [UserRepresantation]) {
        self.users = users
        let sectionsSet = IndexSet(integer: Section.users.rawValue)
        self.tableView.reloadSections(sectionsSet, with: .automatic)
    }
    
    func updateMembersInfo(_ membersInfo: MembersInfoRepresentation) {
        self.membersInfo = membersInfo
        let sectionsSet = IndexSet(integer: Section.membersInfo.rawValue)
        self.tableView.reloadSections(sectionsSet, with: .automatic)
    }
    
}

extension NewGroupViewController: UITableViewDataSource { //MARK: - UITableViewDataSource -
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Section.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = Section(rawValue: section) else { return 0 }
        switch section {
        case .groupType: return 1
        case .groupInfo: return GroupInfoRow.count
        case .membersInfo: return 1
        case .search: return 1
        case .users: return max(users.count, 1)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = Section(rawValue: indexPath.section) else { fatalError("Wrong section") }
        switch section {
        case .groupType: return groupTypeCellAt(indexPath)
        case .groupInfo: return groupInfoCellAt(indexPath)
        case .membersInfo: return membersInfoCellAt(indexPath)
        case .search: return searchCellAt(indexPath)
        case .users: return userCellAt(indexPath)
        }
    }
    
    //MARK: - Group type
    
    private func groupTypeCellAt(_ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as NewGroupTypeCell
        cell.type = type
        cell.typeChange = { self.type = $0 }
        return cell
    }
    
    //MARK: - Group info
    
    private func groupInfoCellAt(_ indexPath: IndexPath) -> UITableViewCell {
        guard let row = GroupInfoRow(rawValue: indexPath.row) else { fatalError("Wrong row") }
        let cell = tableView.dequeueReusableCell(for: indexPath) as NewGroupTextCell
        cell.label.text = row.label
        cell.textView.placeholder = row.placeholder(for: type) as NSString
        cell.textView.text = textForGroupInfoRow(row)
        cell.textView.delegate = self
        return cell
    }
    
    fileprivate func textForGroupInfoRow(_ row: GroupInfoRow) -> String {
        switch row {
        case .name: return name
        case .url: return url
        case .purpose: return purpose
        }
    }
    
    //MARK: - Members info
    
    private func membersInfoCellAt(_ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as AddMembersCell
        cell.configure(with: membersInfo)
        return cell
    }
    
    //MARK: - Search
    
    private func searchCellAt(_ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as SearchCell
        cell.searchTextField.delegate = self
        cell.searchTextField.text = searchText
        return cell
    }
    
    //MARK: - Users
    
    private func userCellAt(_ indexPath: IndexPath) -> UITableViewCell {
        guard users.count > 0 else { return noUsersCellAt(indexPath) }
        let user = users[indexPath.row]
        let cell = tableView.dequeueReusableCell(for: indexPath) as GroupMemberCell
        cell.configure(with: user)
        return cell
    }
    
    private func noUsersCellAt(_ indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
}


extension NewGroupViewController: UITableViewDelegate { //MARK: - UITableViewDelegate -
    
    //MARK: Selection
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        guard let section = Section(rawValue: indexPath.section) else { fatalError("Wrong section") }
        switch section {
        case .users: selectUserAt(indexPath)
        default: break
        }
    }
    
    private func selectUserAt(_ indexPath: IndexPath) {
        let index = indexPath.row
        guard users.count > index else { return }
        eventHandler.didSelectUserAt(index) { newUser in
            users[index] = newUser
            if let cell = tableView.cellForRow(at: indexPath) as? GroupMemberCell {
                cell.configure(with: newUser)
            }
        }
    }
    
    //MARK: - Row height
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let section = Section(rawValue: indexPath.section) else { fatalError("Wrong section") }
        switch section {
        case .groupType: return 57
        case .groupInfo: return groupInfoCellHeightAt(indexPath)
        case .membersInfo: return membersInfoCellHeightAt(indexPath)
        case .search: return searchCellHeightAt(indexPath)
        case .users: return userCellHeightAt(indexPath)
        }
    }
    
    private func groupInfoCellHeightAt(_ indexPath: IndexPath) -> CGFloat {
        guard let row = GroupInfoRow(rawValue: indexPath.row) else { fatalError("Wrong row") }
        var text = textForGroupInfoRow(row)
        if text.isEmpty { text = row.placeholder(for: type) }
        let height = NewGroupTextCell.heightForText(text, withViewWidth: tableView.frame.width)
        return height
    }
    
    private func groupTextCellHeightAt(_ indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    private func membersInfoCellHeightAt(_ indexPath: IndexPath) -> CGFloat {
        if membersInfo?.count > 0 {
            return 140
        } else {
            return 65
        }
    }
    
    private func searchCellHeightAt(_ indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    private func userCellHeightAt(_ indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
}

extension NewGroupViewController: UITextViewDelegate { //MARK: - UITextViewDelegate -
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange,
                  replacementText text: String) -> Bool {
        let currentText = textView.text ?? ""
        let resultString = NSString(string: currentText).replacingCharacters(in: range, with: text)
        saveText(resultString, for: textView)
        updateTableViewForChangedText(resultString, in: textView)
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        saveText(textView.text, for: textView)
    }
    
    private func saveText(_ text: String, for textView: UITextView) {
        let origin = tableView.convert(textView.frame.origin, from: textView.superview)
        guard let indexPath = tableView.indexPathForRow(at: origin) else { return }
        guard Section.groupInfo.rawValue == indexPath.section else { return }
        guard let row = GroupInfoRow(rawValue: indexPath.row) else { return }
        switch row {
        case .name: name = text
        case .url: url = text
        case .purpose: purpose = text
        }
    }
    
    private func updateTableViewForChangedText(_ resultText: String, `in` textView: UITextView) {
        let previousText = textFromTextView(textView)
        var newText = resultText
        if newText.isEmpty {
            newText = placeholderForTextView(textView)
        }
        let previousHeight = NewGroupTextCell.heightForText(previousText, withViewWidth: tableView.frame.width)
        let newHeight = NewGroupTextCell.heightForText(newText, withViewWidth: tableView.frame.width)
        if (previousHeight != newHeight) {
            tableView.beginUpdates()
            tableView.endUpdates()
        }
    }
    
    private func textFromTextView(_ textView: UITextView) -> String {
        var text = textView.text ?? ""
        if text.isEmpty {
            text = placeholderForTextView(textView)
        }
        return text
    }
    
    private func placeholderForTextView(_ textView: UITextView) -> String {
        if let textView = textView as? RSKPlaceholderTextView,
            let placeholder = textView.placeholder {
            return placeholder as String
        }
        return ""
    }
    
}

extension NewGroupViewController: UITextFieldDelegate { //MARK: - UITextFieldDelegate -
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        let resultString = NSString(string: currentText).replacingCharacters(in: range,
                                                                             with: string)
        searchText = resultString
        eventHandler.didChangeSearchString(resultString)
        return true
    }
    
}

//MARK: - Enums -

enum GroupType {
    case `public`, `private`
}

fileprivate enum Section: Int {
    case groupType, groupInfo, membersInfo, search, users
    static let count = 5
}

fileprivate enum GroupInfoRow: Int {
    case name, url, purpose
    static let count = 3
    
    var label: String {
        switch self {
        case .name: return R.string.localizable.groupNameLabel().uppercased().separatedWithSpaces
        case .url: return R.string.localizable.groupUrlLabel().uppercased().separatedWithSpaces
        case .purpose: return R.string.localizable.groupPurposeLabel().uppercased().separatedWithSpaces
        }
    }
    
    func placeholder(for type: GroupType) -> String {
        switch self {
        case .name: return R.string.localizable.groupNamePlaceholder()
        case .url: return R.string.localizable.groupUrlPlaceholder()
        case .purpose:
            if type == .private {
                return R.string.localizable.groupPurposePlaceholder()
            } else {
                return R.string.localizable.channelPurposePlaceholder()
            }
        }
    }
    
}
