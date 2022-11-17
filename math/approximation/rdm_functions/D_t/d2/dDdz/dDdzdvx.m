function [d] = dDdzdvx(X, t, post1, post2)
%     d = dRdz(X,t,post1) - dRdz(X,t,post2);
    d = dRdzdvx(X,t,post1) - dRdzdvx(X,t,post2);
end
