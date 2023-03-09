function [hei_code] = split_by_rd(code_hei)
    poits = code_hei.poits;
    nms = find([poits.count] == 4);
    poits4 = poits(nms);
    poits(nms) = [];
    nms3 = find([poits.count] == 3);
    poits3 = poits(nms3);
    poits(nms3) = [];
    poit = [poits4 poits3];
    hei_code = [];
    codes_count = 0;
    

    [~,idx_sort] = sort([poit.Frame]);
    poit = poit(idx_sort);

    for i = 1:length(poit)
        match_flag = 0;
        for j = 1:codes_count
            last_rd = hei_code(j).poits(end).rd;
            new_rd = poit(i).rd;
            for k = 1:6
                if poit(i).rd_flag(k) ~= 0
                    if hei_code(j).poits(end).rd_flag(k) ~= 0
                        if abs(new_rd(k) - last_rd(k)) > 200
                         match_flag = 0;
                         break
                        end
                    else
                        if hei_code(j).count ~= 1
                            flag = hei_code(j).rd_flag;
                            nms = find(flag(k,:) ~= 0);
                            if nms ~= 0 
                                if abs(new_rd(k) - hei_code(j).poits(nms(end)).rd(k)) > 200
                                 match_flag = 0;
                                 break
                                end
                            else
                                match_flag = 0;
                                break
                            end
                        else
                            continue
                        end
                    end
                else
                    continue
                end
            end
            if k == 6
                match_flag = 1;
                break
            end
        end
        if match_flag == 0
            
            codes_count = codes_count + 1;
            newcode.code = code_hei.code;
            newcode.count = 1;
            newcode.rd(:,newcode.count) = poit(i).rd;
            newcode.poits(newcode.count) = poit(i);
            newcode.last_rd = poit(i).rd;
            newcode.rd_flag(:, newcode.count) = poit(i).rd_flag;
            hei_code = [hei_code newcode];
        else
            hei_code(j).count = hei_code(j).count + 1;
            hei_code(j).poits(hei_code(j).count) = poit(i);
            hei_code(j).rd(:,hei_code(j).count) = poit(i).rd;
            hei_code(j).last_rd = poit(i).rd;
            hei_code(j).rd_flag(:,hei_code(j).count) = poit(i).rd_flag;
        end
    end

    for i = 1:codes_count
            [~,idx_sort] = sort([hei_code(i).poits.Frame]);
            hei_code(i).poits = hei_code(i).poits(idx_sort);
            for j = 1:length(idx_sort)
                hei_code(i).rd(:,j) = hei_code(i).poits(j).rd;
            end
    end
    

    if codes_count >= 1
        for k = 1:codes_count
            rd = hei_code(k).rd;
            RD = [];
            for j = 1:6
                nms = find(rd(j,:) ~= 0);
                if length(nms) < 5
                    RD(j,:) = [0 0 0 0];
                else
                    rd_ = rd(j,nms);
                    t = [hei_code(k).poits(nms).Frame];
                    [koef, sko, X] = mnk_approx_step(t - t(1), rd_, 1);
                    RD(j,:) = [koef(1) koef(2) sko t(1)];
                end
            end
            hei_code(k).RD = RD;
            hei_code(k).hei = code_hei.hei;

        end
    end
    hei_code = rmfield(hei_code,"last_rd");
    hei_code = rmfield(hei_code,"rd_flag");
    
end