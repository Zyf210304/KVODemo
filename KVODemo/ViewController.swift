//
//  ViewController.swift
//  KVODemo
//
//  Created by     马世杰 on 2024/11/7.
//

import UIKit

class ViewController: UIViewController {

    var person:Person = Person()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        person.addObserver(self, forKeyPath: #keyPath(Person.name), options: [.new,.old], context: nil)
        person.name = "John"
        
        view.addSubview(btn)
        
    }
    
    
    lazy var btn: UIButton = {
        let r = UIButton(frame: CGRectMake(100, 100, 100, 100))
        r.backgroundColor = .red
        r.addTarget(self, action: #selector(changeName), for: .touchUpInside)
        return r
    }()
    
    @objc func changeName() {
        print(#line, person.name)
        person.name = "abc"
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if keyPath == #keyPath(Person.name) {
            if let newName = change?[.newKey] as? String {
                print("New name: \(newName)")
            }
            
            if let oldName = change?[.oldKey] as? String {
                print("Old name: \(oldName)")
            }
        }
    }


}

class Person: NSObject {
    @objc dynamic var name: String = ""
}

//class ViewController: UIViewController {
//    var person: Person = Person()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // 确保添加观察者使用正确的 key path
//        person.addObserver(self, forKeyPath: #keyPath(Person.name), options: [.new, .old], context: nil)
//        person.name = "John"  // 触发 KVO
//
//        view.addSubview(btn)
//    }
//
//    lazy var btn: UIButton = {
//        let r = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
//        r.backgroundColor = .red
//        r.addTarget(self, action: #selector(changeName), for: .touchUpInside)
//        return r
//    }()
//
//    @objc func changeName() {
//        print(#line, person.name)  // 输出当前 name
//        person.name = "abc"       // 触发 KVO
//    }
//
//    // 正确实现 KVO 观察者方法
//    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
//        if keyPath == #keyPath(Person.name) {
//            if let newName = change?[.newKey] as? String {
//                print("New name: \(newName)")
//            }
//
//            if let oldName = change?[.oldKey] as? String {
//                print("Old name: \(oldName)")
//            }
//        }
//    }
//
//    deinit {
//        person.removeObserver(self, forKeyPath: #keyPath(Person.name))
//    }
//}
//
//class Person: NSObject {
//    @objc dynamic var name: String = ""
//}
