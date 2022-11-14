function [R] = is_match_traj(traj, poit, config, k)
%вектор значений, по которому буду определять подходящую траекторию
    for j = 1:k
        last_poit = traj(j).poits(end);
        new_crd = poit.est_crd;
        delta = last_crd - new_crd;
        Rnorm = norm(delta(1:2));
        R.count = R.count + 1
        R.poits(R.count) = Rnorm;
    end


