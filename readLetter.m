function letter=readLetter(s)


load NewTemplates % Loads the templates of characters in the memory.
s=imresize(s,[42 24]); % Resize the input image so it can be compared with the template's images.
comp=[ ];
for n=1:length(NewTemplates)
    sem=corr2(NewTemplates{1,n},s); % Correlation the input image with every image in the template for best matching.
    comp=[comp sem]; % Record the value of correlation for each template's character.
    
end
v=find(comp==max(comp)); % Find the index which correspond to the highest matched character.

if v==1 || v==2
    letter='A';
elseif v==3 || v==4
    letter='B';
elseif v==5
    letter='C';
elseif v==6 || v==7
    letter='D';
elseif v==8
    letter='E';
elseif v==9
    letter='F';
elseif v==10
    letter='G';
elseif v==11
    letter='H';
elseif v==12
    letter='I';
elseif v==13
    letter='J';
elseif v==14
    letter='K';
elseif v==15
    letter='L';
elseif v==16
    letter='M';
elseif v==17
    letter='N';
elseif v==18 || v==19
    letter='O';
elseif v==20 || v==21
    letter='P';
elseif v==22 || v==23
    letter='Q';
elseif v==24 || v==25
    letter='R';
elseif v==26
    letter='S';
elseif v==27
    letter='T';
elseif v==28
    letter='U';
elseif v==29
    letter='V';
elseif v==30
    letter='W';
elseif v==31
    letter='X';
elseif v==32
    letter='Y';
elseif v==33
    letter='Z';
    %*-*-*-*-*
% Numerals listings.
elseif v==34
    letter='1';
elseif v==35
    letter='2';
elseif v==36
    letter='3';
elseif v==37 || v==38
    letter='4';
elseif v==39
    letter='5';
elseif v==40 || v==41 || v==42
    letter='6';
elseif v==43
    letter='7';
elseif v==44 || v==45
    letter='8';
elseif v==46 || v==47 || v==48
    letter='9';
else
    letter='0';
end
end