    Dim str="A123456"
     
    For i = 1 To n
        c = Mid(str, i, 1)
        
        If c >= "0" And c <= "9" Then
            c = c - "0"
        ElseIf c >= "A" And c <= "Z" Then
            c = Asc(c) - Asc("A") + 10
        ElseIf c >= "a" And c <= "z" Then
            c = Asc(c) - Asc("a") + 10
        Else
            c = frombase
        End If
        
        If c < frombase Then
            num = num * frombase + c
        End If
    Next
    Do
        ptr = ptr & Mid(digits, (num Mod 2 + 1), 1)
        num = num \ 2
    Loop While num
    
    base_convert = StrReverse(ptr)