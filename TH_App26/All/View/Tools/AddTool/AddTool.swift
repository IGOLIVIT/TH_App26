//
//  AddTool.swift
//  TH_App26
//
//  Created by IGOR on 31/01/2025.
//

import SwiftUI

struct AddTool: View {
    
    @StateObject var viewModel: ToolsViewModel
    
    var body: some View {

        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                ZStack {
                    
                    Text("New tool")
                        .foregroundColor(.white)
                        .font(.system(size: 20, weight: .regular))
                    
                    HStack {
                                                
                        Button(action: {
                            
                            withAnimation(.spring()) {
                                
                                viewModel.isAdd = false
                            }
                            
                        }, label: {
                            
                            Image(systemName: "chevron.left")
                                .foregroundColor(.white)
                                .font(.system(size: 20, weight: .medium))
                        })
                        
                        Spacer()

                    }
                }
                .padding()
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    VStack(alignment: .leading, spacing: 14) {
                        
                        Text("Tool name")
                            .foregroundColor(Color("prim"))
                            .font(.system(size: 14, weight: .regular))
                        
                        ZStack(content: {
                            
                            Text("Enter")
                                .foregroundColor(.gray)
                                .font(.system(size: 15, weight: .regular))
                                .opacity(viewModel.toName.isEmpty ? 1 : 0)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            TextField("", text: $viewModel.toName)
                                .foregroundColor(Color.white)
                                .font(.system(size: 16, weight: .regular))
                            
                        })
                        
                        Rectangle()
                            .fill(Color("bg"))
                            .frame(maxWidth: .infinity)
                            .frame(height: 1)
                            .padding(.vertical, 5)
                        
                        Text("Category")
                            .foregroundColor(Color("prim"))
                            .font(.system(size: 14, weight: .regular))
                        
                        VStack {
                            
                            ForEach(viewModel.categories, id: \.self) { index in
                            
                                Button(action: {
                                    
                                    viewModel.currCat = index
                                    
                                }, label: {
                                    
                                    HStack {
                                        
                                        Image(index)
                                            .opacity(viewModel.currCat == index ? 1 : 0.4)
                                        
                                        Text(index)
                                            .foregroundColor(viewModel.currCat == index ? .white : .white.opacity(0.4))
                                            .font(.system(size: 16, weight: .regular))
                                        
                                        Spacer()
                                    }
                                    .padding(6)
                                    .padding(.horizontal, 5)
                                    .background(RoundedRectangle(cornerRadius: 5).fill(Color("bg")))
                                })
                            }
                        }
                        
                        Text("Candition")
                            .foregroundColor(Color("prim"))
                            .font(.system(size: 14, weight: .regular))
                        
                        HStack {
                            
                            ForEach(viewModel.conditions, id: \.self) { index in
                            
                                Button(action: {
                                    
                                    viewModel.currCond = index
                                    
                                }, label: {
                                    
                                    Text(index)
                                        .foregroundColor(viewModel.currCond == index ? .white : .white.opacity(0.4))
                                        .font(.system(size: 16, weight: .regular))
                                        .frame(maxWidth: .infinity)
                                        .padding(6)
                                        .padding(.horizontal, 5)
                                        .background(RoundedRectangle(cornerRadius: 5).fill(Color("bg")))
                                        .background(RoundedRectangle(cornerRadius: 5).stroke(Color.green, lineWidth: 3).opacity(viewModel.currCond == index ? 1 : 0))
                                        .padding(1)
                                })
                            }
                        }
                        .padding(.bottom, 100)
                        
                        Button(action: {
                            
                            viewModel.toCat = viewModel.currCat
                            viewModel.toCond = viewModel.currCond
                            
                            viewModel.addTool()
                            
                            viewModel.currCat = ""
                            viewModel.currCond = ""
                            viewModel.toName = ""
                            
                            viewModel.fetchTools()
                            
                            withAnimation(.spring()) {
                                
                                viewModel.isAdd = false
                            }
                            
                        }, label: {
                            
                            HStack {
                                
                                Image(systemName: "checkmark")
                                    .foregroundColor(.black)
                                    .font(.system(size: 16, weight: .regular))
                                
                                Text("Save")
                                    .foregroundColor(.black)
                                    .font(.system(size: 16, weight: .regular))
                            }
                            .padding()
                            .padding(.horizontal)
                            .background(RoundedRectangle(cornerRadius: 5).fill(Color("prim")))
                        })
                        .opacity(viewModel.toName.isEmpty || viewModel.currCat.isEmpty || viewModel.currCond.isEmpty ? 0.5 : 1)
                        .disabled(viewModel.toName.isEmpty || viewModel.currCat.isEmpty || viewModel.currCond.isEmpty ? true : false)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.black)
            }
        }
    }
}

#Preview {
    AddTool(viewModel: ToolsViewModel())
}
