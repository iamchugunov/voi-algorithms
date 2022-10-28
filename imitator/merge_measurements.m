function [poits] = merge_measurements(tracks)
    N = 0;
    for i = 1:length(tracks)
        ppoits{i} = tracks(i).poits;
        N = N + length(tracks(i).poits);
    end
    poits(1:N) = tracks(1).poits(1);
    k = 0;
    while k < N
        nms = [];
        tot = [];
        for i = 1:length(tracks)
            if ~isempty(ppoits{i})
                nms = [nms i];
                tot = [tot ppoits{i}(1).true_ToT];
            end
        end
        [~, n] = min(tot);
        k = k + 1;
        poits(k) = ppoits{nms(n)}(1);
        ppoits{nms(n)}(1) = [];
        
    end
end

