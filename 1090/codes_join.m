function [codes_squawk, codes_hei,codes_squawk_nopair,codes_hei_nopair] = codes_join(codes_squawk, codes_hei)
    codes_squawk_nopair = [];
    codes_hei_nopair = [];
    assumed_position = [];
    for i=1:length(codes_squawk)
        if codes_squawk(i).RD(:,3)<30
            codes_squawk(i).match = 0; 
        else
            codes_squawk(i).match = 1; 
        end
    end
    for i=1:length(codes_hei)
        if codes_hei(i).RD(:,3)<30
            codes_hei(i).match = 0;
        else
            codes_hei(i).match = 1; 
        end
    end
    nms = find([codes_squawk.match]==1);
    codes_squawk_nopair=codes_squawk(nms);
    codes_squawk(nms)=[];
    nms = find([codes_hei.match]==1);
    codes_hei_nopair = codes_hei(nms);
    codes_hei(nms)=[];
    for i = 1:length(codes_hei)
        codes_hei(i).scount = 0;
    end
    for i = 1:length(codes_squawk)
        t_squawk = codes_squawk(i).RD(:,4);
        for j = 1:length(codes_hei)
            t_hei = codes_hei(j).RD(:,4);
            delta_t = t_squawk - t_hei;
            for k = 1:6
                assumed_position(k,1) = [codes_squawk(i).RD(k,1) + codes_squawk(i).RD(k,2)*delta_t(k)];
            end
            max = assumed_position(:,1) + 3*codes_squawk(i).RD(:,3);
            min = assumed_position(:,1) - 3*codes_squawk(i).RD(:,3);
            if min(:) <= codes_hei(j).RD(:,1)
                if max(:) >= codes_hei(j).RD(:,1)
                    codes_hei(j).scount = codes_hei(j).scount + 1;
                    codes_hei(j).squawk(codes_hei(j).scount) = i;
                    codes_hei(j).sRD(codes_hei(j).scount) = norm(abs(assumed_position(:)) - abs(codes_hei(j).RD(:,1)));
                else
                    continue
                end

            else
                continue
            end
        end
    end
    for i = 1:length(codes_hei)
        if codes_hei(i).scount ~= 0 
          if codes_hei(i).scount ~= 1
              min_sRD = min(codes_hei(i).sRD);
              idx_squawk = find
          else
              idx_squawk = codes_hei(i).squawk;
          end
        end
    end
%     for j = 1:length(codes_hei)
%         if codes_hei(j).sRD(:) ~= 0
% 
% 
%         end
%     end

end