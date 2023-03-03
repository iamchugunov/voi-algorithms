function [pair_flag, pair_code] = codes_pairing(first_code,second_code)
    for i = 1:6
        if first_code.RD(i,3) ~= 0 && first_code.RD(i,3) > 30
            pair_flag = 0;
            pair_code = [];
            return
        end
        if second_code.RD(i,3) ~= 0 && second_code.RD(i,3) > 30
            pair_flag = 0;
            pair_code = [];
            return
        end
        
        if abs(first_code.RD(i,1) - second_code.RD(i,1)) > 300
            pair_flag = 0;
            pair_code = [];
            return
        end
    end
    pair = [first_code.poits second_code.poits];
    [~,idx_sort] = sort([pair.Frame]);
    pair = pair(idx_sort);
    pair_code = [];
    for k = 1:length(pair)
            rd = [pair.rd];
            RD = [];
            for j = 1:6
                nms = find(rd(j,:) ~= 0);
                if length(nms) < 5
                    RD(j,:) = [0 0 0 0];
                else
                    rd_ = rd(j,nms);
                    t = [pair(nms).Frame];
                    [koef, sko, X] = mnk_approx_step(t - t(1), rd_, 1);
                    RD(j,:) = [koef(1) koef(2) sko t(1)];
                end
            end
    end
    
    pair_flag = 1;
    rd_count = 0;
    for i = 1:6
        if RD(i,3) ~= 0
            if RD(i,3) < 30
                rd_count = rd_count + 1;
            else
                pair_flag = 0;
                break
            end
        end
    end  

    if rd_count < 3
        pair_flag = 0;
    end

    if pair_flag ~= 0
        pair_code.poits = pair;
        pair_code.count_poits = length(first_code.poits) + length(second_code.poits);
        pair_code.first_code = first_code.code;
        pair_code.second_code = second_code.code;
        pair_code.RD = RD;

    end

end