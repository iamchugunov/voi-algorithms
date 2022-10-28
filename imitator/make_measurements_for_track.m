function [track] = make_measurements_for_track(track, measurements_params, config)

    sigma_n_ns = measurements_params.sigma_n_ns;
    period_sec = measurements_params.period_sec;
    n_periods = measurements_params.n_periods;
    strob_dur = measurements_params.strob_dur;
    
    t = track.t;
    current_t = t(1);
    k = 0;
    while current_t < t(end)
        k = k + 1;
        ToT(k) = current_t + period_sec * ( 1 + randi([0 n_periods]) );
        current_t = ToT(k);
    end
    
    for k = 1:length(ToT)
        nums = find(t < ToT(k));
        crd = track.crd(:,nums(end));
        vel = track.vel(:,nums(end));
        dt = ToT(k) - t(nums(end));
        h_geo(k) = track.h_geo(nums(end));
        
        SV(:,k) = [ crd(1,:) + vel(1,:) * dt; vel(1,:);
            crd(2,:) + vel(2,:) * dt; vel(2,:);
            crd(3,:) + vel(3,:) * dt; vel(3,:);];
    end
    
    poits = [];
    posts = config.posts;
    
    t_strob = 0;
    while t_strob < t(end)
        nms = find(ToT < t_strob + strob_dur);
        for j = 1:length(nms)
            cur_tot = ToT(nms(j));
            cur_sv = SV(:,nms(j));
            poit = [];
            poit.Frame = t_strob;
            Ranges = [];
            ToA = [];
            for i = 1:length(posts)
                Ranges(i,1) = norm(posts(:,i) - cur_sv([1 3 5]));
                ToA(i,1) = Ranges(i,1)/config.c + cur_tot - t_strob;
            end
            ToA = ToA * 1e9;
            ToA = ToA + normrnd(0, sigma_n_ns, [4, 1]);
            ToA = round(ToA);
            rd = [];
            rd(1,1) = (ToA(4) - ToA(1))*config.c_ns;
            rd(2,1) = (ToA(4) - ToA(2))*config.c_ns;
            rd(3,1) = (ToA(4) - ToA(3))*config.c_ns;
            rd(4,1) = (ToA(3) - ToA(1))*config.c_ns;
            rd(5,1) = (ToA(3) - ToA(2))*config.c_ns;
            rd(6,1) = (ToA(2) - ToA(1))*config.c_ns;
            poit.ToA = ToA;
            poit.Ranges = Ranges;
            poit.rd = rd;
            poit.rd_flag = ones(6,1);
            poit.count = 4;
            poit.true_ToT = cur_tot;
            poit.true_crd = cur_sv([1 3 5]);
            poit.true_vel = cur_sv([2 4 6]);
            poit.h_geo = h_geo(nms(j));
            poit.track_id = track.id;
            poit.crd_valid = 0;
            poit.est_ToT = 0;
            poit.est_crd = zeros(3,1);
            poit.res = [];
            poits = [poits poit];
            
        end
        ToT(nms) = [];
        SV(:,nms) = [];
        t_strob = t_strob + strob_dur;
    end     
        
    
    track.poits = poits;
end



