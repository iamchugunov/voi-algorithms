function [codes] = get_codes_from_poits(poits)
    codes = [];
    for i = 1:length(poits)
        match_flag = 0;
        for j = 1:length(codes)
            %                     if strcmp(cur_poits(i).ACdata,codes(j).code)
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
        else
            codes(j).count = codes(j).count + 1;
            codes(j).rd(:,codes(j).count) = poits(i).rd;
            codes(j).poits(:,codes(j).count) = poits(i);
        end
    end
end

