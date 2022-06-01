//
//  DataPersistenceManager.swift
//  Netfilx
//
//  Created by KhaleD HuSsien on 01/06/2022.
//

import Foundation
import UIKit
import CoreData

enum ErrorCases: Error {
    case FaildToSaveData
    case FaildToFechData
    case FaildToDeleteData
}
class DataPersistenceManager{
    static let shared =  DataPersistenceManager()
    func downloadTitle(with model :Title,completion: @escaping (Result <Void , Error>)-> Void){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let context = appDelegate.persistentContainer.viewContext
        let item = TitleItem(context: context)
        item.original_name = model.original_name
        item.original_title = model.original_title
        item.id = Int64(model.id)
        item.overview = model.overview
        item.poster_path = model.poster_path
        item.media_type = model.media_type
        item.release_date = model.release_date
        item.vote_average = model.vote_average
        item.vote_count = Int64(model.vote_count)
        do {
            try context.save()
            completion(.success(()))
        } catch {
            completion(.failure(ErrorCases.FaildToSaveData))
        }
    }
    func fetchingDataFromDataBase(completion: @escaping (Result<[TitleItem] , Error>) -> Void){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{return}
        let context = appDelegate.persistentContainer.viewContext
        let request: NSFetchRequest<TitleItem>
        request = TitleItem.fetchRequest()
        do{
            let titles = try context.fetch(request)
            completion(.success(titles))
        }catch{
            completion(.failure(ErrorCases.FaildToFechData))
        }
    }
    func deleteWith(model: TitleItem , completion: @escaping (Result<Void , Error>)-> Void){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{return}
        let context = appDelegate.persistentContainer.viewContext
        context.delete(model)
        do {
            try context.save()
            completion(.success(()))
        } catch  {
            completion(.failure(ErrorCases.FaildToDeleteData))
        }
    }
}
