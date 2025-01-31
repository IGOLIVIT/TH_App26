//
//  WorksView.swift
//  TH_App26
//
//  Created by IGOR on 31/01/2025.
//

import SwiftUI

struct WorksView: View {

    @StateObject var viewModel = WorksViewModel()
    
    var body: some View {

        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                ZStack {
                    
                    Text("Works")
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
                
                if viewModel.works.isEmpty {
                    
                    VStack(spacing: 20) {
                        
                        Image("em1")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 80)
                        
                        Text("Your work list is empty. Tap «+» above to add your first work!")
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
                         
                            ForEach(viewModel.works, id: \.self) { index in
                            
                                VStack(alignment: .leading, spacing: 20) {
              
                                    HStack {
                                        
                                        Text(index.woName ?? "")
                                            .foregroundColor(.white)
                                            .font(.system(size: 20, weight: .medium))
                                        
                                        Spacer()
                                        
                                        Text((index.woDate ?? Date()).convertDate(format: "MMM dd, YYYY"))
                                            .foregroundColor(.gray)
                                            .font(.system(size: 16, weight: .regular))
                                    }
                                    
                                    Text(index.woCond ?? "")
                                        .foregroundColor(.white)
                                        .font(.system(size: 14, weight: .regular))
                                        .padding(6)
                                        .padding(.horizontal, 6)
                                        .background(RoundedRectangle(cornerRadius: 5).stroke(index.woCond ?? "" == "Completed" ? Color.green : index.woCond ?? "" == "In progress" ? Color("prim") : Color.white))
                                    
                                    Text("\(index.woH ?? "")h \(index.woM ?? "")min")
                                        .foregroundColor(.gray)
                                        .font(.system(size: 16, weight: .regular))
                                    
                                    Text("1 tool")
                                        .foregroundColor(.gray)
                                        .font(.system(size: 16, weight: .regular))
                                    
                                    HStack {
                                        
                                        Text("$\(index.woEar ?? "")")
                                            .foregroundColor(.gray)
                                            .font(.system(size: 16, weight: .regular))
                                        
                                        Spacer()
                                        
                                        Menu(content: {
                                            
                                            Button(action: {
                                                
                                                viewModel.selectedWork = index
                                                
                                                viewModel.woNewCond = "In progress"
                                                
                                                CoreDataStack.shared.updateCond(withWoName: viewModel.selectedWork?.woName ?? "", woNewCond: viewModel.woNewCond)
                                                
                                                viewModel.fetchWorks()
                                                
                                            }, label: {
                                                
                                                Text("In Progress")
                                            })
                                            
                                            Button(action: {
                                                
                                                viewModel.selectedWork = index
                                                
                                                viewModel.woNewCond = "Planned"
                                                
                                                CoreDataStack.shared.updateCond(withWoName: viewModel.selectedWork?.woName ?? "", woNewCond: viewModel.woNewCond)
                                                
                                                viewModel.fetchWorks()
                                                
                                            }, label: {
                                                
                                                Text("Planned")
                                            })
                                            
                                            Button(action: {
                                                
                                                viewModel.selectedWork = index
                                                
                                                viewModel.woNewCond = "Completed"
                                                
                                                CoreDataStack.shared.updateCond(withWoName: viewModel.selectedWork?.woName ?? "", woNewCond: viewModel.woNewCond)
                                                
                                                viewModel.fetchWorks()
                                                
                                            }, label: {
                                                
                                                Text("Completed")
                                            })
                                            
                                            Button(action: {
                                                
                                                viewModel.selectedWork = index
                                                
                                                withAnimation(.spring()) {
                                                    
                                                    viewModel.isDelete = true
                                                }
                                                
                                            }, label: {
                                                
                                                HStack {
                                                    
                                                    Text("Delete")
                                                        .foregroundColor(.red)
                                                    
                                                    Spacer()
                                                    
                                                    Image(systemName: "trash")
                                                        .foregroundColor(.red)
                                                }
                                            })
                                            
                                        }, label: {
                                            
                                            Text("...")
                                                .foregroundColor(.white)
                                                .font(.system(size: 18, weight: .semibold))
                                        })
                                    }
                                }
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
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
            
            viewModel.fetchWorks()
        }
        .sheet(isPresented: $viewModel.isAdd, content: {
            
            AddWork(viewModel: viewModel)
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

                    Text("Delete \(viewModel.selectedWork?.woName ?? "")?")
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
                            
                            CoreDataStack.shared.deleteWork(withWoName: viewModel.selectedWork?.woName ?? "", completion: {
                                
                                viewModel.fetchWorks()
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
    WorksView()
}
