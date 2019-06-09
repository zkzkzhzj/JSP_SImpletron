// 실행
var memory = [],
    instructionCounter = 0,	// 수행되고 있는 명령을 포함하는 메모리의 위치 탐지
    instructionRegister = 0, // 현재의 명령
    operator = 0, // 연산부(왼쪽 숫자 2자리)
    operand = 0, // 주소부(오른쪽 숫자 2자리)
    nextCounter = 0,
    accumulator = 0, // 누산기
    halted = false,
    debug = false;

// 사용자 요청
var btnLoad = document.getElementById('btn-load'),
    btnExec = document.getElementById('btn-exec'),
    btnDebug = document.getElementById('btn-debug'),
    btnClear = document.getElementById('btn-clear'),
    code = document.querySelector('#code textarea'),
    output = document.querySelector('#output textarea');

// 메모리 초기화
for(var i = 0; i < 100; i++) {
    memory.push(0);
}

// 메모리 덤프 주기적으로 업데이트
setInterval(function() {
	
    var dump = '누산기:\t\t' + format(accumulator) + 
        '\n명령 계수기:\t' + format(instructionCounter) + 
        '\n다음 명령어:\t' + format(nextCounter) +
        '\n명령 레지스터\t' + format(instructionRegister) + 
        '\n\n\t\t0\t\t1\t\t2\t\t3\t\t4\t\t5\t\t6\t\t7\t\t8\t\t9\n';
    
    for(var i1 = 0; i1 < 10; i1++) {
        dump += i1 * 10;
        
        for(var i2 = 0; i2 < 10; i2++) {
            dump += '\t' + format(memory[i1 * 10 + i2]);
        }
        
        dump += '\n'
    }
    
    document.querySelector('#dump textarea').innerText = dump;
}, 100);

// 코드를 메모리에 올림
btnLoad.addEventListener('click', function() {
    btnDebug.innerText = '한 줄씩 실행하기';
    
    debug = false;
    var lines = code.value.split('\n');

    if(isValid(lines)) {
        consoleStatus('프로그램을 메모리에 올렸습니다');

        memory.forEach(function(value, index) {
            if(index < lines.length) {
                memory[index] = ~~lines[index].substring(4);
            } else {
                memory[index] = 0;
            }
        });

    } else {
        error();
    }
});

// 코드를 메모리에 올림
btnExec.addEventListener('click', function() {
    if(debug) {
        alert('이미 디버깅 중입니다.');
        return;
    }
    
    consoleStatus('프로그램 시작');

    halted = false;
    instructionCounter = 0;
    nextCounter = 0;
    accumulator = 0;

    while(!halted) {
        execInstruction();
    }
});

// 한 줄씩 실행
btnDebug.addEventListener('click', function() {
    if(!debug) {
        debug = true;
        halted = false;
        instructionCounter = 0;
        nextCounter = 0;
        accumulator = 0;
        
        btnDebug.innerText = '다음 라인';
    }
    
    execInstruction();
});

// 콘솔창 클리어
btnClear.addEventListener('click', function() {
    output.value = '*** Welcome to Simpletron! ***\n' + 
    '*** Please enter your program one istruction ***\n' +
    '*** (or data word) at a time. I will type the ***\n' +
    '*** location num and a question mark (?) ***\n' + 
    '*** You then type the word for that location. ***\n' + 
    '*** Type the sectinel -99999 to stop entering ***\n' +
    '*** your program ****\n';
});

// 다음 명령을 실행
function execInstruction() {
    instructionCounter = nextCounter;

    if(instructionCounter === memory.length) {
        halt();
    }
    
    instructionRegister = ~~(memory[instructionCounter]);
    operator = ~~(instructionRegister / 100);
    operand = instructionRegister % 100;

    nextCounter = instructionCounter + 1;

    switch(operator) {
        case opcodes.READ:
            memory[operand] = parseInt(prompt('입력 범위 : -9999 to 9999'), 10) || 0;
            break;
        case opcodes.WRITE:
            consoleWrite(memory[operand]);
            break;
        case opcodes.LOAD:
            accumulator = memory[operand];
            break;
        case opcodes.STORE:
            memory[operand] = accumulator;
            break;
        case opcodes.ADD:
            accumulator += memory[operand];
            break;
        case opcodes.SUBTRACT:
            accumulator -= memory[operand];
            break;
        case opcodes.MULTIPLY:
            accumulator *= memory[operand];
            break;
        case opcodes.DIVIDE:
            if(accumulator == 0) {
                consoleStatus('에러: 0으로 나누었습니다');
                halt();
            } else {
                accumulator /= memory[operand];
            }
            break;
        case opcodes.BRANCH:
            nextCounter = operand;
            break;
        case opcodes.BRANCHNEG:
            if(accumulator < 0) {
                nextCounter = operand;
            }
            break;
        case opcodes.BRANCHZERO:
            if(accumulator === 0) {
                nextCounter = operand;
            }
            break;
        case opcodes.HALT:
            halt();
            break;
        default:
            consoleStatus('에러: 잘못된 요청');
            halt();
            break;
    }

    // 입력 값 확인
    if(accumulator > 9999) {
        consoleStatus('에러: 9999 이상 수 입력');
        halt();
    } else if(accumulator < -9999) {
        consoleStatus('에러: -9999 이하 수 입력');
        halt();
    }

    var loc = -1;
    var flow = 0;

    // 메모리 값 확인
    for(var i = 0; i < memory.length && loc === -1; i++) {
        if(Math.abs(memory[i]) > 9999) {
            loc = i;
            flow = Math.sign(memory[i]);
        }
    }

    if(loc > -1) {
        consoleStatus('에러: ' + (flow === -1 ? 'under' : 'over') + 'flow at memory location ' + loc);
        halt();
    }
}

// 코드가 유요한지 체크
function isValid(lines) {
    // 모든 행이 올바른 형식과 일치하는지 확인
    if(lines.filter(function(value) {
        return !value.match(/^\d{2}: (\+|-)?\d{4}$/ig);
    }).length) {
        return false;
    } else {
        var valid = true;

        // 메모리 위치가 올바른지 확인
        lines.forEach(function(value, index) {
            var num = parseInt(value.substring(0, 2), 10);

            if(index === 0) {
                if(num !== 0) {
                    valid = false;
                }
            } else {
                var prev = parseInt(lines[index - 1].substring(0, 2), 10);

                if(num - prev !== 1) {
                    valid = false;
                }
            }
        });

        return valid;
    }

    return true;
}

// 에러 메시지 출력
function error() {
    alert('옳바른 입력 식인지 확인하세요');
}

// 프로그램 종료
function halt() {
    consoleStatus('프로그램 종료');
    halted = true;
    debug = false;
    
    btnDebug.innerText = '한 줄씩 실행하기';
}

// 콘솔에 기록
function consoleWrite(val) {
    output.value += val + '\n';
    output.scrollTop = output.scrollHeight;
}

// 별 포함
function consoleStatus(val) {
    consoleWrite('*** ' + val + ' ***');
}

// 메모리 포맷
function format(num) {
    var sign = (num >= 0 ? '+' : '-');
    
    num = Math.abs(num) + '';
    
    while(num.length < 4) {
        num = '0' + num;
    }
    
    return sign + num;
}