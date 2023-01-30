function [codes_squawk, codes_hei] = codes_analysis(codes)
    
    codes_squawk = [];
    codes_hei = [];
    
    if length(codes) == 0
        return;
    end

    nms = find([codes.count] < 30);
    codes(nms) = [];

    for i = 1:length(codes)
        codes(i).hei = decodeACcode(dec2hex(codes(i).code,4));
    end
    
    nms = find([codes.hei] == -1000);
    codes_squawk = codes(nms);
    
    codes(nms) = [];
    codes_hei = codes;
    
    for i = 1:length(codes_squawk)
        fprintf('%3d %4X\t%6.0f\t%5d\t%7.0f\t%4.0f\t%7.0f\t%4.0f\t%7.0f\t%4.0f\t%7.0f\t%4.0f\t%7.0f\t%4.0f\t%7.0f\t%4.0f\n',i, codes_squawk(i).code,codes_squawk(i).hei,codes_squawk(i).count,codes_squawk(i).RD(1,1),codes_squawk(i).RD(1,2),codes_squawk(i).RD(2,1),codes_squawk(i).RD(2,2),codes_squawk(i).RD(3,1),codes_squawk(i).RD(3,2),codes_squawk(i).RD(4,1),codes_squawk(i).RD(4,2),codes_squawk(i).RD(5,1),codes_squawk(i).RD(5,2),codes_squawk(i).RD(6,1),codes_squawk(i).RD(6,2))
    end
    fprintf("\n")
    for i = 1:length(codes_hei)
        fprintf('%3d %4X\t%6.0f\t%5d\t%7.0f\t%4.0f\t%7.0f\t%4.0f\t%7.0f\t%4.0f\t%7.0f\t%4.0f\t%7.0f\t%4.0f\t%7.0f\t%4.0f\n',i, codes_hei(i).code,codes_hei(i).hei,codes_hei(i).count,codes_hei(i).RD(1,1),codes_hei(i).RD(1,2),codes_hei(i).RD(2,1),codes_hei(i).RD(2,2),codes_hei(i).RD(3,1),codes_hei(i).RD(3,2),codes_hei(i).RD(4,1),codes_hei(i).RD(4,2),codes_hei(i).RD(5,1),codes_hei(i).RD(5,2),codes_hei(i).RD(6,1),codes_hei(i).RD(6,2))
    end
    
end

