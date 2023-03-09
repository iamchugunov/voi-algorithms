function [] = poits_analysis(poits)
    
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
    t = [];
    data = [];
    while n2 <= length(poits)
        if poits(n2).Frame - poits(n2_last).Frame > T
            nums = find(poits(n2).Frame - [poits.Frame] > Tnak);
            n1 = nums(end) + 1;
            cur_poits = poits(n1:n2);
            nums = find([cur_poits.Smode] < 0);
            cur_poits = cur_poits(nums);
            
            cnt = length(cur_poits);
            cnt4 = length(find([cur_poits.count] == 4));
            cnt3 = length(find([cur_poits.count] == 3));
            cnt2 = length(find([cur_poits.count] == 2));
            
            toa = [cur_poits.ToA];
            cnt_1 = length(find(toa(1,:)));
            cnt_2 = length(find(toa(2,:)));
            cnt_3 = length(find(toa(3,:)));
            cnt_4 = length(find(toa(4,:)));
            
            t = [t cur_poits(end).Frame];
            data = [data [poits(n2).Frame - t0; cnt_1/cnt*100; cnt_2/cnt*100; cnt_3/cnt*100; cnt_4/cnt*100; cnt4/cnt*100; cnt3/cnt*100; cnt2/cnt*100; cnt]];
            fprintf('%4.0f-%4.0f сек\tЧетверки/Тройки/Двойки: %3.0f/%3.0f/%3.0f\tПосты: %3.0f/%3.0f/%3.0f/%3.0f\tОтметок: %d\n',cur_poits(1).Frame-t0,cur_poits(end).Frame-t0, cnt4/cnt*100, cnt3/cnt*100, cnt2/cnt*100,cnt_1/cnt*100,cnt_2/cnt*100,cnt_3/cnt*100,cnt_4/cnt*100,cnt); 
            
            n2_last = n2;
            n2 = n2+1;
        else
            n2 = n2+1;
        end
    end
    
    cnt = length(poits);
    cnt4 = length(find([poits.count] == 4));
    cnt3 = length(find([poits.count] == 3));
    cnt2 = length(find([poits.count] == 2));
    
    toa = [poits.ToA];
    cnt_1 = length(find(toa(1,:)));
    cnt_2 = length(find(toa(2,:)));
    cnt_3 = length(find(toa(3,:)));
    cnt_4 = length(find(toa(4,:)));
    
    fprintf('Всего:\tЧетверки/Тройки/Двойки: %3.0f/%3.0f/%3.0f\tПосты: %3.0f/%3.0f/%3.0f/%3.0f\tОтметок: %d\n',cnt4/cnt*100, cnt3/cnt*100, cnt2/cnt*100,cnt_1/cnt*100,cnt_2/cnt*100,cnt_3/cnt*100,cnt_4/cnt*100,cnt); 
%     plot(data(1,:),data(2:end,:)','.-')
    
    figure
    hold on
    grid minor
    xlabel('t, сек')
    yyaxis left
    plot(data(1,:),data(6,:),'.-','linewidth',2)
    ylabel('Процент полных отметок')
    ylim([0 100])
    set(gca,'FontSize',18)
    set(gca,'FontName','Times')
    yyaxis right
    plot(data(1,:),data(9,:),'.-','linewidth',2)
    ylabel('Количество отметок')

    figure
    hold on
    grid minor
    xlabel('t, сек')
%     yyaxis left
    plot(data(1,:),data(2:5,:),'.-','linewidth',2)
    ylabel('%')
    legend('ПП№1','ПП№2','ПП№3','ПП№4')
    set(gca,'FontSize',18)
    set(gca,'FontName','Times')
%     yyaxis right
%     plot(data(1,:),data(9,:),'k.-')
%     ylabel('Количество отметок')
    
end

