procedure showNews();
var
    newsFile    : TextFile;
    aline       : String;
    
begin
     
    DoorDisplayFile('scrnz\news.ans');
    if FileExists('news.txt') then begin
        try
            assignFile(newsFile, 'news.txt');
            while not eof(newsFile) do begin
                readln(newsFile, aline);
                DoorWriteC(aline);
                DoorWriteLn;
            end;
            paused;
            
        except
            DoorLWrite('`4*** UNABLE TO GET NEWS FILE ***',True);
            paused;            
        end;
        
    end else begin
        DoorLWrite('`7No news today. ', True);
    end;
    paused;
end;
