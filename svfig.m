function [] = svfig( figureid, name )
    
    path = 'D:\Synology\��� ������\2023 - REEPE\img\';
    p1 = [path '\fig\' name '.fig'];
    p2 = [path '\png\' name '.png'];
    
    saveas(figureid, p1);
    saveas(figureid, p2);

end

