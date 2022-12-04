//
//  ProgressDataManager.swift
//  TiskTasker
//
//  Created by Jon Schlandt on 7/22/22.
//

import Foundation

class ProgressDataManager: BaseDataManager {
    var progress: Progress?
    
    // MARK: Network calls
    
    func fetchProgress() async {
        do {
            let params = [ URLQueryItem(name: "userId", value: "0") ]
            progress = try await fetchItem(at: "http://localhost:3000/progress", as: Progress.self, using: params)
        } catch {
            print("Request failed with error: \(error)")
        }
    }
    
    func updateProgress(using progress: Progress) async {
        do {
            let _ = try await updateItem(at: "http://localhost:3000/progress", with: progress)
        } catch {
            print("Request failed with error: \(error)")
        }
    }
    
    // MARK: Data manipulation
    
    func incrementProgress(by points: Int) async {
        await fetchProgress()
        
        guard let progress = progress else {
            return
        }
        
        guard var totalTasks = progress.totalTasks,
              var totalPoints = progress.totalPoints else {
                  return
        }
        
        totalTasks = totalTasks + 1
        totalPoints = totalPoints + points
        
        let updatedProgress = Progress(
            userId: progress.userId,
            avatarUrl: progress.avatarUrl,
            fullName: progress.fullName,
            totalTasks: totalTasks,
            totalPoints: totalPoints
        )
        
        await updateProgress(using: updatedProgress)
    }
}
