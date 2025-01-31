//
//  ToolsView.swift
//  TH_App26
//
//  Created by IGOR on 31/01/2025.
//

import SwiftUI

struct ToolsView: View {
    
    @StateObject var viewModel = ToolsViewModel()
    
    var body: some View {

        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                ZStack {
                    
                    Text("Tools")
                        .foregroundColor(.white)
                        .font(.system(size: 22, weight: .medium))
                    
                    HStack {
                        
                        Spacer()
                        
                        Button(action: {
                            
                            withAnimation(.spring()) {
                                
                                viewModel.isAdd = true
                            }
                            
                        }, label: {
                            
                            Image(systemName: "plus")
                                .foregroundColor(.white)
                                .font(.system(size: 20, weight: .medium))
                        })
                    }
                }
                .padding()
                
                if viewModel.tools.isEmpty {
                    
                    VStack(spacing: 20) {
                        
                        Image("em1")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 80)
                        
                        Text("Your tool list is empty. Tap «+» above to add your first tool!")
                            .foregroundColor(.white)
                            .font(.system(size: 17, weight: .regular))
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 40)
                    }
                    .padding()
                    .frame(maxHeight: .infinity)
                    .frame(maxWidth: .infinity)
                    .background(Color.black)
                    
                } else {
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        
                        LazyVStack(spacing: 10) {
                         
                            ForEach(viewModel.tools, id: \.self) { index in
                            
                                VStack(spacing: 20) {
                                    
                                    HStack {
                                        
                                        Text(index.toName ?? "")
                                            .foregroundColor(.white)
                                            .font(.system(size: 20, weight: .medium))
                                        
                                        Spacer()
                                        
                                        Image(index.toCat ?? "")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 23)
                                    }
                                    
                                    HStack {
                                        
                                        Text(index.toCond ?? "")
                                            .foregroundColor(.white)
                                            .font(.system(size: 14, weight: .regular))
                                            .padding(6)
                                            .padding(.horizontal, 6)
                                            .background(RoundedRectangle(cornerRadius: 5).stroke(index.toCond ?? "" == "Working" ? Color.green : Color.orange))
                                        
                                        Spacer()
                                        
                                        Button(action: {
                                            
                                            viewModel.selectedTool = index
                                            
                                            withAnimation(.spring()) {
                                                
                                                viewModel.isDelete = true
                                            }
                                                
                                        }, label: {
                                            
                                            Text("Delete")
                                                .foregroundColor(.red)
                                                .font(.system(size: 14, weight: .medium))
                                        })
                                    }
                                }
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(RoundedRectangle(cornerRadius: 8).fill(Color("bg")))
                            }
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.black)
                }
            }
            
        }
        .onAppear {
            
            viewModel.fetchTools()
        }
        .sheet(isPresented: $viewModel.isAdd, content: {
            
            AddTool(viewModel: viewModel)
        })
        .overlay(
            
            ZStack {
                
                Color.black.opacity(viewModel.isDelete ? 0.5 : 0)
                    .ignoresSafeArea()
                    .onTapGesture {
                        
                        withAnimation(.spring()) {
                            
                            viewModel.isDelete = false
                        }
                    }
                
                VStack(spacing: 15) {

                    Text("Delete \(viewModel.selectedTool?.toName ?? "")?")
                        .foregroundColor(.white)
                        .font(.system(size: 20, weight: .semibold))
                        .multilineTextAlignment(.center)
                        .padding(.vertical)

                    Rectangle()
                        .fill(.white.opacity(0.2))
                        .frame(maxWidth: .infinity)
                        .frame(height: 1)
                    
                    HStack {
                        
                        Button(action: {
                            
                            CoreDataStack.shared.deleteTool(withToName: viewModel.selectedTool?.toName ?? "", completion: {
                                
                                viewModel.fetchTools()
                            })
                            
                            withAnimation(.spring()) {
                                
                                viewModel.isDelete = false
                            }
                            
                        }, label: {
                            
                            Text("Delete")
                                .foregroundColor(.red)
                                .font(.system(size: 18, weight: .semibold))
                                .frame(maxWidth: .infinity)
                                .frame(height: 45)
                            
                        })
                        
                        Button(action: {
                            
                            withAnimation(.spring()) {
                                
                                viewModel.isDelete = false
                            }
                            
                        }, label: {
                            
                            Text("Cancel")
                                .foregroundColor(.white)
                                .font(.system(size: 17, weight: .regular))
                                .frame(maxWidth: .infinity)
                                .frame(height: 45)
                            
                        })
                    }
                    .padding(.top, 25)

                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(RoundedRectangle(cornerRadius: 20).fill(Color("bg")))
                .padding()
                .offset(y: viewModel.isDelete ? 0 : UIScreen.main.bounds.height)
            }
        )
    }
}

#Preview {
    ToolsView()
}
