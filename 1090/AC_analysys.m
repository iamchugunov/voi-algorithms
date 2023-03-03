function [new_pairs] = AC_analysys(poits)
    
    
    Tnak = 10;
    T = 10;
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
    
    pairs_count = 0;
    clear pairs;
    clear ncodes_hei;

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
            [codes_squawk, codes_hei] = codes_analysis(codes);
%             pairs = [];
%             k = 0;
%             dlina_squawk = length(codes_squawk);
%             dlina_hei = length(codes_hei);
            hei_codes = [];
            idx = [];
            k = 1;
%             pairs_count = 0;
%             clear pairs;
            for p = 1:length(codes_hei)
                hei_flag = 0;
                for l = 1:6
                    if codes_hei(p).RD(l,3) > 30
                        hei_flag = 0;
                        break
                    end
                end
                if k == 6
                    hei_flag = 1;
                    break
                end
                if hei_flag == 0
                    nms = find([codes_hei(p).poits.count] == 4);
                    if nms > 0 
                        code_hei = codes_hei(p);
                        [hei_code] = split_by_rd(code_hei);
                        idx = [idx p];
                        hei_codes = [hei_codes hei_code];
                    end
                end
            end
            codes_hei(idx) = [];
            codes_hei = [codes_hei hei_codes];
            fprintf("\n")
            for i = 1:length(codes_hei)
                fprintf('%3d %4X\t%6.0f\t%5d\t%7.0f\t%4.0f\t%7.0f\t%4.0f\t%7.0f\t%4.0f\t%7.0f\t%4.0f\t%7.0f\t%4.0f\t%7.0f\t%4.0f\n',i, codes_hei(i).code,codes_hei(i).hei,codes_hei(i).count,codes_hei(i).RD(1,1),codes_hei(i).RD(1,2),codes_hei(i).RD(2,1),codes_hei(i).RD(2,2),codes_hei(i).RD(3,1),codes_hei(i).RD(3,2),codes_hei(i).RD(4,1),codes_hei(i).RD(4,2),codes_hei(i).RD(5,1),codes_hei(i).RD(5,2),codes_hei(i).RD(6,1),codes_hei(i).RD(6,2))
            end
            while k < length(codes_squawk)
                for i = 1:length(codes_hei)
                    [pair_flag, pair_code] = codes_pairing(codes_squawk(k),codes_hei(i));
                    if pair_flag
                        pairs_count = pairs_count + 1;
                        pairs(pairs_count) = pair_code;
                        fprintf('\n')
                        fprintf('%3d %4X\t%4X\t%7.0f\t%4.0f\t%7.0f\t%4.0f\t%7.0f\t%4.0f\t%7.0f\t%4.0f\t%7.0f\t%4.0f\t%7.0f\t%4.0f\n', pairs_count, pairs(pairs_count).first_code, pairs(pairs_count).second_code, pairs(pairs_count).RD(1,1),pairs(pairs_count).RD(1,3),pairs(pairs_count).RD(2,1),pairs(pairs_count).RD(2,3),pairs(pairs_count).RD(3,1),pairs(pairs_count).RD(3,3),pairs(pairs_count).RD(4,1),pairs(pairs_count).RD(4,3))
                        codes_squawk(k) = [];
                        codes_hei(i) = [];
                        k = k - 1;
                        break
                    end
                end
                k = k + 1;
            end
            
            


            n2_last = n2;
            n2 = n2+1;
        else
            n2 = n2+1;
        end
    end
    
    fprintf('\n')
    for pairs_count = 1:length(new_pairs)
        fprintf('%3d %4X\t%4X\t%7.0f\t%7.0f\t%4.0f\t%7.0f\t%4.0f\t%7.0f\t%4.0f\t%7.0f\t%4.0f\t%7.0f\t%4.0f\t%7.0f\t%4.0f\n', pairs_count, pairs(pairs_count).first_code, pairs(pairs_count).second_code, decodeACcode(dec2hex(pairs(pairs_count).second_code,4)), pairs(pairs_count).RD(1,1),pairs(pairs_count).RD(1,3),pairs(pairs_count).RD(2,1),pairs(pairs_count).RD(2,3),pairs(pairs_count).RD(3,1),pairs(pairs_count).RD(3,3),pairs(pairs_count).RD(4,1),pairs(pairs_count).RD(4,3),pairs(pairs_count).RD(5,1),pairs(pairs_count).RD(5,3),pairs(pairs_count).RD(6,1),pairs(pairs_count).RD(6,3))
    end                      
    
end

