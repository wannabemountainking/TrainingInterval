//
//  MainView.swift
//  TrainingInterval
//
//  Created by yoonie on 4/12/26.
//

import SwiftUI

struct MainView: View {
    
    @State private var vm: IntervalViewModel = .init()
    
    var body: some View {
        VStack(spacing: 40) {
            
            // MARK: - 운동중 / 휴식중
            Text(vm.phase == .trainingMode ? "●  운동 중" : "●  휴식 중")
                .font(.title)
                .fontWeight(.semibold)
                .foregroundStyle(vm.phase == .trainingMode ? Color.pink : .blue)
                .padding(15)
                .padding(.horizontal, 15)
                .background(vm.phase == .trainingMode ? Color.gray.opacity(0.2) : .blue.opacity(0.2))
                .clipShape(Capsule(style: .circular))
            
            // MARK: - 시계 / 남은 시간 / 진행상황
            VStack(spacing: 15) {
                Text("00:\(String(format: "%.02d", vm.timeLeft))")
                    .font(.custom("Clock", size: 100))
                Text("다음: \(vm.phase == .trainingMode ? "휴식: 10초" : "운동: 30초")")
                    .font(.title3)
                HStack(spacing: 0) {
                    ForEach(1..<11) { index in
                        if index <= vm.progressBar {
                            Image(systemName: "circle.fill")
                                .foregroundStyle(vm.phase == .trainingMode ? Color.red : Color.blue)
                        } else {
                            Image(systemName: "circle")
                                .foregroundStyle(vm.phase == .trainingMode ? Color.red : .blue)
                        }
                    }
                }
                .padding(30)
                .font(.title)
            }
            
            // MARK: - 버튼들 - / 시작, 정지, 재개, 리셋
            HStack {
                Button("시작") {
                    vm.start()
                }
                .foregroundStyle(.white)
                .frame(height: 40)
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                
                Button("정지") {
                    vm.stop()
                }
                .foregroundStyle(.white)
                .frame(height: 40)
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                
                Button("재개") {
                    vm.resume()
                }
                .foregroundStyle(.white)
                .frame(height: 40)
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                
                Button("리셋") {
                    vm.reset()
                }
                .foregroundStyle(.white)
                .frame(height: 40)
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .font(.title)
            .fontWeight(.semibold)
        }
        .padding(20)
    }
}

#Preview {
    MainView()
}
