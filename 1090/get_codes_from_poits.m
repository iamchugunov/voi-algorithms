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
            if isempty(nms)
                RD(j,:) = [0 0];
            else
                RD(j,:) = [mean(rd(j,nms)) std(rd(j,nms))];
            end
        end
        codes(i).RD = RD;
    end
end

