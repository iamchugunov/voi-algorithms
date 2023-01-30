function [d] = dDdydax(X, t, post1, post2)
%     d = dRdy(X,t,post1) - dRdy(X,t,post2);
    d = dRdydax(X,t,post1) - dRdydax(X,t,post2);
end
