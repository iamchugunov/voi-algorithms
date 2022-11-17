function [d, dd] = get_deriv_rdm(X, t, toa, posts, order)
    cnt = length(toa);
    switch cnt
        case 4
            rd1 = toa(4) - toa(1);
            rd2 = toa(4) - toa(2);
            rd3 = toa(4) - toa(3);
            
        case 3
            rd1 = toa(3) - toa(1);
            rd2 = toa(3) - toa(2);
        case 2
            rd1 = toa(2) - toa(1);
    end
end

