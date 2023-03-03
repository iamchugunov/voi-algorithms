function [new_pairs] = pairs_unity(pairs)
    squawks = unique([pairs.first_code]);
    
    new_pairs = [];
    for j = 1:length(squawks)
        nms = find([pairs.first_code] == squawks(j));
        pairs1 = pairs(nms);
        h = [];
        poits = [];
        for i = 1:length(pairs1)
            h(i) = decodeACcode(dec2hex(pairs1(i).second_code,4));
            poits = [poits pairs1(i).poits];

        end
        new_pair.squawk = dec2hex(squawks(j),4);
        new_pair.poits = poits;
        new_pair.h = h;
        new_pairs = [new_pairs new_pair];
    end
end