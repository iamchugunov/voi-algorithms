function [d] = dDdydy(X, t, post1, post2)
%     d = dRdy(X,t,post1) - dRdy(X,t,post2);
    d = dRdydy(X,t,post1) - dRdydy(X,t,post2);
end
