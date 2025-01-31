//
//  AddWork.swift
//  TH_App26
//
//  Created by IGOR on 31/01/2025.
//

import SwiftUI

struct AddWork: View {

    @StateObject var viewModel: WorksViewModel
    @StateObject var mainModel = ToolsViewModel()
    
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
                        
                        Text("Work name")
                            .foregroundColor(Color("prim"))
                            .font(.system(size: 14, weight: .regular))
                        
                        ZStack(content: {
                            
                            Text("Enter")
                                .foregroundColor(.gray)
                                .font(.system(size: 15, weight: .regular))
                                .opacity(viewModel.woName.isEmpty ? 1 : 0)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            TextField("", text: $viewModel.woName)
                                .foregroundColor(Color.white)
                                .font(.system(size: 16, weight: .regular))
                            
                        })
                        
                        Rectangle()
                            .fill(Color("bg"))
                            .frame(maxWidth: .infinity)
                            .frame(height: 1)
                            .padding(.vertical, 5)
                        
                        HStack {
                           
                            VStack(alignment: .leading, spacing: 14) {
                                
                                Text("Date")
                                    .foregroundColor(Color("prim"))
                                    .font(.system(size: 14, weight: .regular))
                                
                                DatePicker("", selection: $viewModel.woDate, displayedComponents: .date)
                                    .labelsHidden()
                                    .accentColor(.white)
                                    .padding(5)
                                    .padding(.horizontal, 5)
                                    .background(RoundedRectangle(cornerRadius: 5).fill(Color("bg")))
                            }
                            .padding(.trailing, 40)
                            
                            VStack(alignment: .leading, spacing: 14) {
                                
                                Text("Duration")
                                    .foregroundColor(Color("prim"))
                                    .font(.system(size: 14, weight: .regular))
                                
                                HStack {
                                    
                                    ZStack(content: {
                                        
                                        Text("2h")
                                            .foregroundColor(.gray)
                                            .font(.system(size: 15, weight: .regular))
                                            .opacity(viewModel.woH.isEmpty ? 1 : 0)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                        
                                        TextField("", text: $viewModel.woH)
                                            .foregroundColor(Color.white)
                                            .font(.system(size: 16, weight: .regular))
                                        
                                    })
                                    
                                    ZStack(content: {
                                        
                                        Text("30min")
                                            .foregroundColor(.gray)
                                            .font(.system(size: 15, weight: .regular))
                                            .opacity(viewModel.woM.isEmpty ? 1 : 0)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                        
                                        TextField("", text: $viewModel.woM)
                                            .foregroundColor(Color.white)
                                            .font(.system(size: 16, weight: .regular))
                                        
                                    })
                                }
                            }
                        }
                        
                        VStack(alignment: .leading) {
                            
                            Text("Tools")
                                .foregroundColor(Color("prim"))
                                .font(.system(size: 14, weight: .regular))
                                .padding(.bottom, 7)
                            
                            ScrollView(.vertical, showsIndicators: false) {
                                
                                LazyVStack {
                                    
                                    ForEach(mainModel.tools, id: \.self) { index in
                                        
                                        Button(action: {
                                            
                                            mainModel.selectedTool = index
                                            
                                        }, label: {
                                            
                                            HStack {
                                                
                                                Text(index.toName ?? "")
                                                    .foregroundColor(.white)
                                                    .font(.system(size: 15, weight: .medium))
                                                
                                                Spacer()
                                                
                                                ZStack {
                                                    
                                                    RoundedRectangle(cornerRadius: 2)
                                                        .stroke(Color.white.opacity(0.2))
                                                        .frame(width: 15, height: 15)
                                                        .padding(1)
                                                    
                                                    Image(systemName: "checkmark")
                                                        .foregroundColor(Color("prim"))
                                                        .font(.system(size: 11, weight: .regular))
                                                        .opacity(mainModel.selectedTool == index ? 1 : 0)
                                                }
                                            }
                                        })
                                    }
                                }
                            }
                        }
                        .padding()
                        .frame(height: 200)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color("bg")))
                        .padding(.bottom)
                        
                        Text("Earning")
                            .foregroundColor(Color("prim"))
                            .font(.system(size: 14, weight: .regular))
                        
                        ZStack(content: {
                            
                            Text("Enter")
                                .foregroundColor(.gray)
                                .font(.system(size: 15, weight: .regular))
                                .opacity(viewModel.woEar.isEmpty ? 1 : 0)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            TextField("", text: $viewModel.woEar)
                                .foregroundColor(Color.white)
                                .font(.system(size: 16, weight: .regular))
                            
                        })
                        
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
                                        .background(RoundedRectangle(cornerRadius: 5).stroke(Color("prim"), lineWidth: 3).opacity(viewModel.currCond == index ? 1 : 0))
                                        .padding(1)
                                })
                            }
                        }
                        .padding(.bottom, 60)
                        
                        Button(action: {
                            
                            viewModel.woTool = mainModel.selectedTool?.toName ?? ""
                            viewModel.woCond = viewModel.currCond
                            
                            viewModel.addWork()
                            
                            viewModel.woName = ""
                            viewModel.woEar = ""
                            viewModel.currCond = ""
                            
                            viewModel.fetchWorks()
                            
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
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .opacity(viewModel.woName.isEmpty || viewModel.woEar.isEmpty || viewModel.currCond.isEmpty ? 0.5 : 1)
                        .disabled(viewModel.woName.isEmpty || viewModel.woEar.isEmpty || viewModel.currCond.isEmpty ? true : false)
                    }
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.black)
            }
        }
        .onAppear {
            
            mainModel.fetchTools()
        }
    }
}

#Preview {
    AddWork(viewModel: WorksViewModel())
}
