function [codes] = AC_analysys(traj)
    
    poits = traj.poits;
    Tnak = 5;
    T = 5;
    k = 0;
    n1 = 1;
    n2 = 2;
    n2_last = 1;
    
    t0 = poits(1).Frame;
    
    while n2 <= length(poits)
        if poits(n2).Frame - poits(n1).Frame > Tnak
            break
        else
            n2 = n2+1;
        end
    end
    
    
    while n2 <= length(poits)
        if poits(n2).Frame - poits(n2_last).Frame > T
            nums = find(poits(n2).Frame - [poits.Frame] > Tnak);
            n1 = nums(end) + 1;
            cur_poits = poits(n1:n2);
            nums = find([cur_poits.Smode] < 0);
            cur_poits = cur_poits(nums);
            
            codes = get_codes_from_poits(cur_poits);
            
            if length(codes) == 0
                continue;
            end
            
            nms = find([codes.count] < 5);
            codes(nms) = [];
            
            for i = 1:length(codes)
                codes(i).hei = decodeACcode(dec2hex(codes(i).code,4));
            end
            
            
            
            fprintf(['\n' num2str(poits(n1).Frame - t0) '-' num2str(poits(n2).Frame - t0) ' sec\n'] );
            [codes_squawk, codes_hei] = codes_analysis(codes);
%             for kk = 1:2
%                 
%                 for i = 1:length(codes)
%                     if (kk == 1) && codes(i).hei ~= -1000
%                         continue
%                     end
%                     if (kk == 2) && codes(i).hei == -1000
%                         continue
%                     end
%                     rd = codes(i).rd;
%                     RD = [];
%                     for j = 1:6
%                         nms = find(rd(j,:) ~= 0);
%                         if isempty(nms)
%                             RD(j,:) = [0 0];
%                         else
%                             RD(j,:) = [mean(rd(j,nms)) std(rd(j,nms))];
%                         end
%                     end
%     %                 fprintf([dec2hex(codes(i).code,4) '\t' num2str(codes(i).hei) '\t' num2str(codes(i).count) '\n']);
%                     fprintf('%3d %4X\t%6.0f\t%5d\t%7.0f\t%4.0f\t%7.0f\t%4.0f\t%7.0f\t%4.0f\t%7.0f\t%4.0f\t%7.0f\t%4.0f\t%7.0f\t%4.0f\n',i, codes(i).code,codes(i).hei,codes(i).count,RD(1,1),RD(1,2),RD(2,1),RD(2,2),RD(3,1),RD(3,2),RD(4,1),RD(4,2),RD(5,1),RD(5,2),RD(6,1),RD(6,2))
%     %                 fprintf([num2str(codes(i).code) '\t' dec2hex(codes(i).code,4) '\t' dec2bin(codes(i).code,16) '\t' num2str(codes(i).hei) '\t' num2str(codes(i).count) '\n']);
%                 end
%             end
            
            n2_last = n2;
            n2 = n2+1;
        else
            n2 = n2+1;
        end
    end
    
    
end

