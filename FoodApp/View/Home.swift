//
//  Home.swift
//  FoodApp
//
//  Created by Ierchenko Anna  on 2/7/22.
//

import SwiftUI

struct Home: View {
    
    @StateObject var HomeModel = HomeViewModel()
    var body: some View {
      ZStack {
        VStack(spacing: 10) {
            HStack(spacing: 15) {
                Button(action: {
                    withAnimation(.easeIn){HomeModel.showMenu.toggle()}
                }, label: {
                    Image(systemName: "line.horizontal.3.decrease")
                        .font(.title)
                        .foregroundColor(.red)
                })
                Text(HomeModel.userLocation == nil ? "Locating..." : "Deliver To")
                    .foregroundColor(.black)
                
                Text(HomeModel.userAddress)
                    .font(.caption)
                    .fontWeight(.heavy)
                    .foregroundColor(.red)
                
                Spacer(minLength: 0)
            }
            .padding([.horizontal,.top])
            
            Divider()
            
            HStack(spacing: 15) {
                Image(systemName: "magnifyingglass")
                        .font(.title2)
                        .foregroundColor(.gray)
                    
                TextField("Search", text: $HomeModel.search)
            }
            .padding(.horizontal)
            .padding(.top,10)
            
            Divider()
        
            if HomeModel.items.isEmpty {
                Spacer()
                ProgressView()
                Spacer()
            }
            else {
                ScrollView(.vertical, showsIndicators: false, content: {
                    VStack(spacing: 25) {
                        ForEach(HomeModel.filtered){item in
                            
                            //item view
                            ZStack(alignment: Alignment(horizontal: .center, vertical: .top), content: {
                                ItemView(item: item)
                                HStack {
                                    Text("FREE DELIVERY")
                                        .foregroundColor(.white)
                                        .padding(.vertical, 10)
                                        .padding(.horizontal)
                                        .background(Color.red)
                                    
                                    Spacer(minLength: 0)
                                    
                                    Button(action: {
                                        HomeModel.addToCart(item: item)
                                    }, label: {
                                        Image(systemName: item.isAdded ? "checkmark" : "plus")
                                            .foregroundColor(.white)
                                            .padding(10)
                                            .background(item.isAdded ? Color.green : Color.red)
                                            .clipShape(Circle())
                                    })
                                }
                                .padding(.trailing,10)
                                .padding(.top,10)
                            })
                           
                        }
                    }
                    .padding(.top,10)
                })
            }
        }
        
        //side menu
        
        HStack {
            Menu(homeData: HomeModel)
            //move effect from left
                .offset(x: HomeModel.showMenu ? 0 : -UIScreen.main.bounds.width / 1.6)
            Spacer(minLength: 0)
        }
        .background(Color.black.opacity(HomeModel.showMenu ? 0.3 : 0).ignoresSafeArea()
        //closing when taps on outside
                        .onTapGesture (perform: {
                            withAnimation(.easeIn){HomeModel.showMenu.toggle()}
            })
        )
        
        //non CLosable alert if permission denied
        if HomeModel.noLocation {
            Text("Please Enable Location Access in Settings to Further Move On!!!")
                .foregroundColor(.black)
                .frame(width: UIScreen.main.bounds.width - 100, height: 120)
                .background(Color.white)
                .cornerRadius(10)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.black.opacity(0.3).ignoresSafeArea())
        }
    }
        .onAppear(perform: {
            //calling location delegate...
            HomeModel.locationManager.delegate = HomeModel
        })
      .onChange(of: HomeModel.search, perform: { value in
        //to avoid continues Search requests
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            if value == HomeModel.search && HomeModel.search != "" {
                //search data
                HomeModel.filterData()
            }
        }
        if HomeModel.search == ""{
            //reset all data
            withAnimation(.linear){HomeModel.filtered = HomeModel.items}
        }
      })
    }
}

