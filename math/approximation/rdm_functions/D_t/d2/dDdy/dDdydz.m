function [d] = dDdydz(X, t, post1, post2)
%     d = dRdy(X,t,post1) - dRdy(X,t,post2);
    d = dRdydz(X,t,post1) - dRdydz(X,t,post2);
end
