//
//  ViewController.swift
//  CoreDataDemo
//
//  Created by JHJG on 2016. 7. 15..
//  Copyright © 2016년 KangJungu. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    //매니지드 객체 콘텍스트 접근
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    @IBOutlet var name: UITextField!
    @IBOutlet var address: UITextField!
    @IBOutlet var phone: UITextField!
    @IBOutlet var status: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //메니지드 객체 콘텍스트를 얻어 사용자가 입력한 데이터를 가지고 있는 매니지드 객체를생성하고 저장.
    @IBAction func saveContact(sender: AnyObject) {
        
        //Contacts 엔티티 디스크럽션 얻기
        let entityDescription = NSEntityDescription.entityForName("Contacts", inManagedObjectContext: managedObjectContext)
        
        //Contacts 매니지드 객체 하위 클래스의 새로운 인스턴스를 만든다.
        let contact = Contacts(entity: entityDescription!, insertIntoManagedObjectContext: managedObjectContext)

        contact.name = name.text
        contact.address = address.text
        contact.phone = phone.text
        
        do{
            try managedObjectContext.save()
            name.text = ""
            address.text = ""
            phone.text = ""
            status.text = "Contact Saved"
        }catch let error as NSError {
            status.text = error.localizedFailureReason
        }
    }
    
    //영구 저장소에서 데이터 가져오기
    @IBAction func findContact(sender: AnyObject) {
        //Contacts 엔티티 디스크럽션 얻기
        let entityDescription = NSEntityDescription.entityForName("Contacts", inManagedObjectContext: managedObjectContext)
        //Contacts 매니지드 객체 하위 클래스의 새로운 인스턴스를 만든다.
        NSEntityDescription.entityForName("Contacts", inManagedObjectContext: managedObjectContext)
        
        let request = NSFetchRequest()
        request.entity = entityDescription
        
        //사용자가 입력한 이름에 해당하는 데이터만 검색되도록 조건부 생성
        let pred = NSPredicate(format: "(name = %@)", name.text!)
        request.predicate = pred
        
        do{
            //결과를 가져온다(배열)
            var results = try managedObjectContext.executeFetchRequest(request)

            //결과 값이 있으면
            if results.count > 0 {
                //첫번째 결과를 가져와서 보여준다.
                let match = results[0] as! NSManagedObject
                
                name.text = match.valueForKey("name") as? String
                address.text = match.valueForKey("name") as? String
                phone.text = match.valueForKey("phone") as? String
                status.text = "Matches found: \(results.count)"
            }else {
                status.text = "No Match"
            }
        }catch let error as NSError{
            status.text = error.localizedFailureReason
        }
        
    }

}

