//
//  ContentView.swift
//  ScamShield
//
//  Created by no use for a name on 5/8/25.
//

import SwiftUI

struct ContentView: View {
    @State private var phoneNumber = ""
    @State private var messageContent = ""
    @State private var isScam = false
    @State private var isChecking = false
    @State private var showResult = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Anti-Scam Message Checker")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(LinearGradient(colors:[.red, .blue], startPoint: .topLeading, endPoint: .bottomTrailing))
                    .padding()
                
                
                
                TextField("Enter phone number or text message", text: $phoneNumber)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.phonePad)
                    .padding()
                
                TextEditor(text: $messageContent)
                    .frame(height: 200)
                    .cornerRadius(10)
                    .padding()
                
                Button(action: checkMessage) {
                    Text("Check Message")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .disabled(isChecking)
                .padding()
                
                if showResult {
                    VStack {
                        Text(isScam ? "⚠️ SCAM ALERT!" : "✅ Safe Message")
                            .font(.title)
                            .foregroundColor(isScam ? .red : .green)
                            .padding()
                        
                        Button(action: {
                            // Add to blocked list
                        }) {
                            Text("Block Number")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.red)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Scam Shield")
            .padding()
        }
    }
    
    
    
    private func checkMessage() {
           isChecking = true
           showResult = false
           
           // Clean phone number by removing non-digit characters
           let cleanNumber = phoneNumber.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
           
           // Simple scam detection logic
           let scamKeywords = ["urgent", "immediately", "verify", "payment", "gift card", "password", "secure account"]
           let messageLower = messageContent.lowercased()
           
           // Check phone number
           let isValidNumber = cleanNumber.count >= 10 // At least 10 digits
           
           // Check message content
           let containsScamKeywords = scamKeywords.contains { messageLower.contains($0) }
           
           // A message is considered a scam if:
           // 1. The message contains scam keywords OR
           // 2. The phone number is invalid AND the message is suspicious
           isScam = containsScamKeywords || (!isValidNumber && messageLower.contains("urgent"))
           
           isChecking = false
           showResult = true
       }
   }

   struct ContentView_Previews: PreviewProvider {
       static var previews: some View {
           ContentView()
       }
   }

