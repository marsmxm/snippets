N    IS    23
X    GREG
Y    GREG
Z    GREG
eax    GREG
ebx    GREG
ecx    GREG
edx    GREG
esi    GREG
edi    GREG
temp    GREG
    LOC    Data_Segment
magic    GREG    @
    LOC    #100
Main    SET    ebx,N
    SET    edx,ebx
    SET    esi,ebx         % 7
    SRU    esi,esi,1       % start column = 3
    SET    edi,esi         % 3
    ADD    edi,edi,1       % start row = 4
    MUL    ebx,ebx,ebx     % 49
    ADD    ebx,ebx,1
    SET    Z,ebx           % 50
    SET    ebx,0
nxt    ADD    ebx,ebx,1
    CMP    temp,Z,ebx      % 50
    BZ    temp,print
magic_2    SET    ecx,esi
    SLU    ecx,ecx,2       % column * 4
    SET    eax,edi
    MUL    eax,eax,edx
    SLU    eax,eax,2       % row * n * 4
    ADD    eax,eax,magic
    LDTU    X,eax,ecx
    CMPU    temp,X,0          % numbered?
    BZ    temp,magic_1
    SUB    esi,esi,1       % column -= 1
    BNN    esi,magic_3     % past first?
    SET    esi,edx
    SUB    esi,esi,1       % set to last
magic_3    ADD    edi,edi,1       % row += 1
    CMP    temp,edi,edx    % past last?
    BNZ    temp,magic_4
    SET    edi,0           % set to first
magic_4    JMP    magic_2
magic_1    STT    ebx,eax,ecx     % number it
wrap    ADD    esi,esi,1       % column += 1
    CMP    temp,esi,edx    % past last?
    BNZ    temp,no_wrap
    SET    esi,0           % set to first
no_wrap    ADD    edi,edi,1       % row +=1
    CMP    temp,edi,edx    % past last?
    BNZ    temp,nxt
    SET    edi,0           % set to first
no_wrap_1 JMP       nxt    
print    TRAP    0,Halt,0