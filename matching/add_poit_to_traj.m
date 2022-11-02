function [traj] = add_poit_to_traj(traj, poit, config)
    traj.count = traj.count + 1;
    traj.poits(traj.count) = poit;
end