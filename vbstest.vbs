Function base_convert(number, frombase, tobase)
    'Author: Demon
    'Date: 2011/12/17
    'Website: http://demon.tw

'大的数据量这个函数就不可以用了
    Dim digits, num, ptr, i, n, c
    digits = "0123456789abcdefghijklmnopqrstuvwxyz"
    
    If frombase < 2 Or frombase > 36 Then
        Err.Raise vbObjectError + 7575,,"Invalid from base"
    End If
    
    If tobase < 2 Or tobase > 36 Then
        Err.Raise vbObjectError + 7575,,"Invalid to base"
    End If
    
    number = CStr(number) : n = Len(number)
    
    For i = 1 To n
        c = Mid(number, i, 1)
        
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
        ptr = ptr & Mid(digits, (num Mod tobase + 1), 1)
        num = num \ tobase
    Loop While num
    
    base_convert = StrReverse(ptr)
End Function

WScript.Echo base_convert("A37334", 16, 2)