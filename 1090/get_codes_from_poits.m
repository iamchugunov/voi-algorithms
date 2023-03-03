function [codes] = get_codes_from_poits(poits)
    codes = [];
    for i = 1:length(poits)
        if poits(i).ACdata == 0
            continue;
        end
        match_flag = 0;
        for j = 1:length(codes)
            if poits(i).ACdata == codes(j).code
                match_flag = 1;
                break
            end
        end

        if match_flag == 0
            j = length(codes) + 1;
            codes(j).code = poits(i).ACdata;
            codes(j).count = 1;
            codes(j).rd(:,codes(j).count) = poits(i).rd;
            codes(j).poits(:,codes(j).count) = poits(i);
            codes(j).RD = [];
        else
            codes(j).count = codes(j).count + 1;
            codes(j).rd(:,codes(j).count) = poits(i).rd;
            codes(j).poits(:,codes(j).count) = poits(i);
        end
    end
    
    for i = 1:length(codes)
        rd = codes(i).rd;
        RD = [];
        for j = 1:6
            nms = find(rd(j,:) ~= 0);
            if length(nms) < 5
                RD(j,:) = [0 0 0 0];
            else
                rd_ = rd(j,nms);
                t = [codes(i).poits(nms).Frame];
                [koef, sko, X] = mnk_approx_step(t - t(1), rd_, 1);
                RD(j,:) = [koef(1) koef(2) sko t(1)];
            end
        end
        codes(i).RD = RD;
    end
end

