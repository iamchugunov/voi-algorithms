function [codes] = split_code(code)
    poits = code.poits;
    codes = [];
    get_rd_from_poits(poits);
    for i = 1:6
        nms = find(code.rd(i,:) ~= 0);
        rd{i} =  code.rd(i,nms);
        s = sort(rd{i});
        sd = diff(s);
        nms = find(sd > 300);
        cur_rd = {};
        nms = [0 nms length(s)];
        for j = 2:length(nms)
            cur_rd{j-1} = s(nms(j-1)+1:nms(j));
            RD{i}(j-1) = mean(cur_rd{j-1});
        end
            
    end
    
    for i = 1:length(poits)
        if poits(i).count < 3
            continue
        end
        match_flag = 0;
        for j = 1:length(codes)
            last_rd = codes(j).last_rd;
            if la
            if poits(i).ACdata == codes(j).code
                match_flag = 1;
                break
            end
        end

        if match_flag == 0
            j = length(codes) + 1;
            codes(j).code = code.code;
            codes(j).count = 1;
            codes(j).rd(:,codes(j).count) = poits(i).rd;
            codes(j).poits(:,codes(j).count) = poits(i);
            codes(j).RD = [];
            codes(j).last_rd;
        else
            codes(j).count = codes(j).count + 1;
            codes(j).rd(:,codes(j).count) = poits(i).rd;
            codes(j).poits(:,codes(j).count) = poits(i);
        end
    end
end

