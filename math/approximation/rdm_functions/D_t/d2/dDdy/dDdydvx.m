function [d] = dDdydvx(X, t, post1, post2)
%     d = dRdy(X,t,post1) - dRdy(X,t,post2);
    d = dRdydvx(X,t,post1) - dRdydvx(X,t,post2);
end
