function [d] = dDdzday(X, t, post1, post2)
%     d = dRdz(X,t,post1) - dRdz(X,t,post2);
    d = dRdzday(X,t,post1) - dRdzday(X,t,post2);
end
