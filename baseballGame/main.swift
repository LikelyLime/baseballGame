

import Foundation




class baseballGame{
    func gameMainPage(){
        var gameCounts: [Int] = []
        print("환영합니다! 원하시는 번호를 입력해주세요")
        
        while true{
            print("1. 게임 시작하기  2. 게임 기록 보기  3. 종료하기")
            if let input = readLine(){
                if input == "1"{
                    gameCounts.append(gameStart())
                }else if input == "2"{
                    historyView(gameCounts)
                }else if input == "3"{
                    print("< 숫자 야구 게임을 종료합니다 >")
                    break
                }else{
                    print("유효하지 않은 숫자 입니다.")
                }
            }
        }
    }
    func historyView(_ gameCounts: [Int]){
        print("< 게임 기록 보기 >")
        for (index, element) in gameCounts.enumerated(){
            print("\(index + 1)번째 게임 : 시도 횟수 - \(element)")
        }
    }
    /**
     게임 시작
     */
    func gameStart() -> Int{
        print("< 게임을 시작합니다 >")
        // 게임에 필요한 정답 만들기
        let answer = createAnswer()
        var inputAry: [Int] = []
        var gameCount = 0
        while true{
            //값 받아오기
            print("숫자를 입력하세요")
            //몇번 호출했는지 숫자 카운트
            gameCount += 1
            
            if let input = readLine(){
                inputAry = input.compactMap{ Int( String($0) ) }
                if inputAry.count != 3 || checkDuplication(inputAry){
                    print("올바르지 않은 입력값입니다")
                    continue
                }
            }
            
            //볼 체크
            let ballCount = checkBall(inputAry, answer)
            //스트라이크 체크
            let strikeCount = checkStrike(inputAry, answer)
            //결과 출력
            if strikeCount != 3{
                printResult(ballCount, strikeCount)
            }else{
                print("정답입니다!")
                break
            }
            
        }
        return gameCount
    }
    /**
     배열의 중복값 확인하는 메서드
     //Referencing initializer 'init(_:)' on 'Set' requires that 'T' conform to 'Hashable'
     */
    func checkDuplication<T: Hashable>(_ ary: [T]) -> Bool{
        return ary.count != Set(ary).count
    }
    
    /**
     결과 출력 메서드
     */
    func printResult(_ ballCount: Int, _ strikeCount: Int){
        if strikeCount > 0 && ballCount == 0{
            print("\(strikeCount)스트라이크")
        }else if strikeCount == 0 && ballCount > 0{
            print("\(ballCount)볼")
        }else if strikeCount > 0 && ballCount > 0{
            print("\(strikeCount)스트라이크 \(ballCount)볼")
        }else{
            print("Nothing")
        }
    }
    /**
     스트라이크 갯수를 구하는 메서드
     */
    func checkStrike(_ inputAry: [Int], _ answer: [Int]) -> Int{
        var strikeCount = 0
        for (index, element) in inputAry.enumerated(){
            if answer[index] == element{
                strikeCount += 1
            }
        }
        return strikeCount
    }
    
    /**
     볼 갯수를 구하는 메서드
     */
    func checkBall(_ inputAry: [Int], _ answer: [Int]) -> Int{
        var ballCount = 0
        for (index, element) in inputAry.enumerated(){
            if answer[index] != element && answer.contains(element){
                ballCount += 1
            }
        }
        return ballCount
    }
    
    /**
     정답을 만드는 메서드
     */
    func createAnswer() -> [Int]{
        var result: [Int] = []
        while result.count != 3{
            let num = Int.random(in: 0...9)
            if !result.contains(num){
                if  result.isEmpty && num == 0{
                    continue
                }
                result.append(num)
            }
        }
        return result
    }
}

//print(baseballGame().gameMainPage())
print(baseballGame().createAnswer())
//print(baseballGame().checkBall([3,2,5], [3,1,2]))
//print(baseballGame().checkStrike([3,2,5], [3,2,2]))
