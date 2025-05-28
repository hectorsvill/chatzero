//
//  GoogleGen.swift
//  chatzero
//
//  Created by Hector Steven Villasano on 5/27/25.
//

import Foundation

import FirebaseAI

class GoogleGen {
    var text = ""
    
    func fetchContent() async {
        let ai = FirebaseAI.firebaseAI(backend: .googleAI())
        let model = ai.generativeModel(modelName: "gemini-2.0-flash")
        let prompt = "Write a story about a cyber punk coder named Raine who discovers a new dimension in the year 2089."
        
        do {
            let response = try await model.generateContent(prompt)
            self.text = response.text ?? "No text in response."
        } catch {
            print("Error generating content: \(error)")
            
        }
    }
    
    

    
}
