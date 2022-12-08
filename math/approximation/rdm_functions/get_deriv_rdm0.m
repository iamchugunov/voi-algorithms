function [d, dd] = get_deriv_rdm0(X, t, toa, posts)
    cnt = length(toa);
    switch cnt
        case 4
            rd1 = toa(4) - toa(1);
            rd2 = toa(4) - toa(2);
            rd3 = toa(4) - toa(3);
            
            s1 = 3 * rd1 - rd2 - rd3;
            s2 = -rd1 + 3 * rd2 - rd3;
            s3 = -rd1 - rd2 + 3 * rd3;
            
            d = zeros(3,1);
            
%             dx
            A = dDdx(X,t,posts(:,4),posts(:,1))*s1+dDdx(X,t,posts(:,4),posts(:,2))*s2+dDdx(X,t,posts(:,4),posts(:,3))*s3;
            B = dD2dx(X,t,posts(:,4),posts(:,1)) + dD2dx(X,t,posts(:,4),posts(:,2)) + dD2dx(X,t,posts(:,4),posts(:,3));
            C = dDDdx(X,t,posts(:,4),posts(:,1),posts(:,2)) + dDDdx(X,t,posts(:,4),posts(:,1),posts(:,3)) + dDDdx(X,t,posts(:,4),posts(:,2),posts(:,3));
            d(1,1) = 1/4 * A - 1/8 * (3 * B - 2 * C);
%             dy
            A = dDdy(X,t,posts(:,4),posts(:,1))*s1+dDdy(X,t,posts(:,4),posts(:,2))*s2+dDdy(X,t,posts(:,4),posts(:,3))*s3;
            B = dD2dy(X,t,posts(:,4),posts(:,1)) + dD2dy(X,t,posts(:,4),posts(:,2)) + dD2dy(X,t,posts(:,4),posts(:,3));
            C = dDDdy(X,t,posts(:,4),posts(:,1),posts(:,2)) + dDDdy(X,t,posts(:,4),posts(:,1),posts(:,3)) + dDDdy(X,t,posts(:,4),posts(:,2),posts(:,3));
            d(2,1) = 1/4 * A - 1/8 * (3 * B - 2 * C);
%             z
            A = dDdz(X,t,posts(:,4),posts(:,1))*s1+dDdz(X,t,posts(:,4),posts(:,2))*s2+dDdz(X,t,posts(:,4),posts(:,3))*s3;
            B = dD2dz(X,t,posts(:,4),posts(:,1)) + dD2dz(X,t,posts(:,4),posts(:,2)) + dD2dz(X,t,posts(:,4),posts(:,3));
            C = dDDdz(X,t,posts(:,4),posts(:,1),posts(:,2)) + dDDdz(X,t,posts(:,4),posts(:,1),posts(:,3)) + dDDdz(X,t,posts(:,4),posts(:,2),posts(:,3));
            d(3,1) = 1/4 * A - 1/8 * (3 * B - 2 * C);
            
            dd = zeros(3,3);
            
%             dx
% %             dx
            A = dDdxdx(X,t,posts(:,4),posts(:,1))*s1+dDdxdx(X,t,posts(:,4),posts(:,2))*s2+dDdxdx(X,t,posts(:,4),posts(:,3))*s3;
            B = dD2dxdx(X,t,posts(:,4),posts(:,1)) + dD2dxdx(X,t,posts(:,4),posts(:,2)) + dD2dxdx(X,t,posts(:,4),posts(:,3));
            C = dDDdxdx(X,t,posts(:,4),posts(:,1),posts(:,2)) + dDDdxdx(X,t,posts(:,4),posts(:,1),posts(:,3)) + dDDdxdx(X,t,posts(:,4),posts(:,2),posts(:,3));
            dd(1,1) = 1/4 * A - 1/8 * (3 * B - 2 * C);
% %             dy
            A = dDdxdy(X,t,posts(:,4),posts(:,1))*s1+dDdxdy(X,t,posts(:,4),posts(:,2))*s2+dDdxdy(X,t,posts(:,4),posts(:,3))*s3;
            B = dD2dxdy(X,t,posts(:,4),posts(:,1)) + dD2dxdy(X,t,posts(:,4),posts(:,2)) + dD2dxdy(X,t,posts(:,4),posts(:,3));
            C = dDDdxdy(X,t,posts(:,4),posts(:,1),posts(:,2)) + dDDdxdy(X,t,posts(:,4),posts(:,1),posts(:,3)) + dDDdxdy(X,t,posts(:,4),posts(:,2),posts(:,3));
            dd(2,1) = 1/4 * A - 1/8 * (3 * B - 2 * C);
            dd(1,2) = dd(2,1);
% %             dz
            A = dDdxdz(X,t,posts(:,4),posts(:,1))*s1+dDdxdz(X,t,posts(:,4),posts(:,2))*s2+dDdxdz(X,t,posts(:,4),posts(:,3))*s3;
            B = dD2dxdz(X,t,posts(:,4),posts(:,1)) + dD2dxdz(X,t,posts(:,4),posts(:,2)) + dD2dxdz(X,t,posts(:,4),posts(:,3));
            C = dDDdxdz(X,t,posts(:,4),posts(:,1),posts(:,2)) + dDDdxdz(X,t,posts(:,4),posts(:,1),posts(:,3)) + dDDdxdz(X,t,posts(:,4),posts(:,2),posts(:,3));
            dd(3,1) = 1/4 * A - 1/8 * (3 * B - 2 * C);
            dd(1,3) = dd(3,1);            
%             dy
% %             dy
            A = dDdydy(X,t,posts(:,4),posts(:,1))*s1+dDdydy(X,t,posts(:,4),posts(:,2))*s2+dDdydy(X,t,posts(:,4),posts(:,3))*s3;
            B = dD2dydy(X,t,posts(:,4),posts(:,1)) + dD2dydy(X,t,posts(:,4),posts(:,2)) + dD2dydy(X,t,posts(:,4),posts(:,3));
            C = dDDdydy(X,t,posts(:,4),posts(:,1),posts(:,2)) + dDDdydy(X,t,posts(:,4),posts(:,1),posts(:,3)) + dDDdydy(X,t,posts(:,4),posts(:,2),posts(:,3));
            dd(2,2) = 1/4 * A - 1/8 * (3 * B - 2 * C);           
% %             dz
            A = dDdydz(X,t,posts(:,4),posts(:,1))*s1+dDdydz(X,t,posts(:,4),posts(:,2))*s2+dDdydz(X,t,posts(:,4),posts(:,3))*s3;
            B = dD2dydz(X,t,posts(:,4),posts(:,1)) + dD2dydz(X,t,posts(:,4),posts(:,2)) + dD2dydz(X,t,posts(:,4),posts(:,3));
            C = dDDdydz(X,t,posts(:,4),posts(:,1),posts(:,2)) + dDDdydz(X,t,posts(:,4),posts(:,1),posts(:,3)) + dDDdydz(X,t,posts(:,4),posts(:,2),posts(:,3));
            dd(3,2) = 1/4 * A - 1/8 * (3 * B - 2 * C);
            dd(2,3) = dd(3,2);   
%             dz            
% %             dz
            A = dDdzdz(X,t,posts(:,4),posts(:,1))*s1+dDdzdz(X,t,posts(:,4),posts(:,2))*s2+dDdzdz(X,t,posts(:,4),posts(:,3))*s3;
            B = dD2dzdz(X,t,posts(:,4),posts(:,1)) + dD2dzdz(X,t,posts(:,4),posts(:,2)) + dD2dzdz(X,t,posts(:,4),posts(:,3));
            C = dDDdzdz(X,t,posts(:,4),posts(:,1),posts(:,2)) + dDDdzdz(X,t,posts(:,4),posts(:,1),posts(:,3)) + dDDdzdz(X,t,posts(:,4),posts(:,2),posts(:,3));
            dd(3,3) = 1/4 * A - 1/8 * (3 * B - 2 * C);                   
            
        case 3
            rd1 = toa(3) - toa(1);
            rd2 = toa(3) - toa(2);
        case 2
            rd1 = toa(2) - toa(1);
    end
end

