

import Foundation




class baseballGame{
    func gameStart(){
        print("< 게임을 시작합니다 >")
        // 게임에 필요한 정답 만들기
        let answer = createAnswer()
        var inputAry: [Int] = []
        while true{
            //값 받아오기
            print("숫자를 입력하세요")
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
            if !result.contains(num) || ( result.count == 0 && num != 0 ){
                result.append(num)
            }
        }
        return result
    }
}

print(baseballGame().gameStart())
//print(baseballGame().createAnswer())
//print(baseballGame().checkBall([3,2,5], [3,1,2]))
//print(baseballGame().checkStrike([3,2,5], [3,2,2]))
