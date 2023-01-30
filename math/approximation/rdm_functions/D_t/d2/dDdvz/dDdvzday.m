function [d] = dDdvzday(X, t, post1, post2)
%     d = dRdvz(X,t,post1) - dRdvz(X,t,post2);
    d = dRdvzday(X,t,post1) - dRdvzday(X,t,post2);
end
