function [posts, y, H, HDnHTrev] = RZPandMakeHmatrix(y, sigma_n, config)
    nums = find(y ~= 0);
    posts = config.posts(:,nums);
    y = y(nums);
    N = length(nums);

    H = zeros(N-1,N);
    H(:,end) = 1;
    for i = 1:N-1
        H(i,i) = -1;
    end 

    switch N
        case 4      
            HDnHT = sigma_n^2 * H * H';
            HDnHTrev = inv(HDnHT);
        case 3
            HDnHT = sigma_n^2 * H * H';
            HDnHTrev = inv(HDnHT);
        case 2
            HDnHT = 2 * sigma_n^2;
            HDnHTrev = inv(HDnHT);
    end
end