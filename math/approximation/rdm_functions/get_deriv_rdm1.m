function [d, dd] = get_deriv_rdm1(X, t, toa, posts)
    cnt = length(toa);
    switch cnt
        case 4
            rd1 = toa(4) - toa(1);
            rd2 = toa(4) - toa(2);
            rd3 = toa(4) - toa(3);
            
            s1 = 3 * rd1 - rd2 - rd3;
            s2 = -rd1 + 3 * rd2 - rd3;
            s3 = -rd1 - rd2 + 3 * rd3;
            
            d = zeros(6,1);
            
%             dx
            A = dDdx(X,t,posts(:,4),posts(:,1))*s1+dDdx(X,t,posts(:,4),posts(:,2))*s2+dDdx(X,t,posts(:,4),posts(:,3))*s3;
            B = dD2dx(X,t,posts(:,4),posts(:,1)) + dD2dx(X,t,posts(:,4),posts(:,2)) + dD2dx(X,t,posts(:,4),posts(:,3));
            C = dDDdx(X,t,posts(:,4),posts(:,1),posts(:,2)) + dDDdx(X,t,posts(:,4),posts(:,1),posts(:,3)) + dDDdx(X,t,posts(:,4),posts(:,2),posts(:,3));
            d(1,1) = 1/4 * A - 1/8 * (3 * B - 2 * C);
%             dvx
            A = dDdvx(X,t,posts(:,4),posts(:,1))*s1+dDdvx(X,t,posts(:,4),posts(:,2))*s2+dDdvx(X,t,posts(:,4),posts(:,3))*s3;
            B = dD2dvx(X,t,posts(:,4),posts(:,1)) + dD2dvx(X,t,posts(:,4),posts(:,2)) + dD2dvx(X,t,posts(:,4),posts(:,3));
            C = dDDdvx(X,t,posts(:,4),posts(:,1),posts(:,2)) + dDDdvx(X,t,posts(:,4),posts(:,1),posts(:,3)) + dDDdvx(X,t,posts(:,4),posts(:,2),posts(:,3));
            d(2,1) = 1/4 * A - 1/8 * (3 * B - 2 * C);
%             dy
            A = dDdy(X,t,posts(:,4),posts(:,1))*s1+dDdy(X,t,posts(:,4),posts(:,2))*s2+dDdy(X,t,posts(:,4),posts(:,3))*s3;
            B = dD2dy(X,t,posts(:,4),posts(:,1)) + dD2dy(X,t,posts(:,4),posts(:,2)) + dD2dy(X,t,posts(:,4),posts(:,3));
            C = dDDdy(X,t,posts(:,4),posts(:,1),posts(:,2)) + dDDdy(X,t,posts(:,4),posts(:,1),posts(:,3)) + dDDdy(X,t,posts(:,4),posts(:,2),posts(:,3));
            d(3,1) = 1/4 * A - 1/8 * (3 * B - 2 * C);
%             vy
            A = dDdvy(X,t,posts(:,4),posts(:,1))*s1+dDdvy(X,t,posts(:,4),posts(:,2))*s2+dDdvy(X,t,posts(:,4),posts(:,3))*s3;
            B = dD2dvy(X,t,posts(:,4),posts(:,1)) + dD2dvy(X,t,posts(:,4),posts(:,2)) + dD2dvy(X,t,posts(:,4),posts(:,3));
            C = dDDdvy(X,t,posts(:,4),posts(:,1),posts(:,2)) + dDDdvy(X,t,posts(:,4),posts(:,1),posts(:,3)) + dDDdvy(X,t,posts(:,4),posts(:,2),posts(:,3));
            d(4,1) = 1/4 * A - 1/8 * (3 * B - 2 * C);
%             z
            A = dDdz(X,t,posts(:,4),posts(:,1))*s1+dDdz(X,t,posts(:,4),posts(:,2))*s2+dDdz(X,t,posts(:,4),posts(:,3))*s3;
            B = dD2dz(X,t,posts(:,4),posts(:,1)) + dD2dz(X,t,posts(:,4),posts(:,2)) + dD2dz(X,t,posts(:,4),posts(:,3));
            C = dDDdz(X,t,posts(:,4),posts(:,1),posts(:,2)) + dDDdz(X,t,posts(:,4),posts(:,1),posts(:,3)) + dDDdz(X,t,posts(:,4),posts(:,2),posts(:,3));
            d(5,1) = 1/4 * A - 1/8 * (3 * B - 2 * C);
%             vz
            A = dDdvz(X,t,posts(:,4),posts(:,1))*s1+dDdvz(X,t,posts(:,4),posts(:,2))*s2+dDdvz(X,t,posts(:,4),posts(:,3))*s3;
            B = dD2dvz(X,t,posts(:,4),posts(:,1)) + dD2dvz(X,t,posts(:,4),posts(:,2)) + dD2dvz(X,t,posts(:,4),posts(:,3));
            C = dDDdvz(X,t,posts(:,4),posts(:,1),posts(:,2)) + dDDdvz(X,t,posts(:,4),posts(:,1),posts(:,3)) + dDDdvz(X,t,posts(:,4),posts(:,2),posts(:,3));
            d(6,1) = 1/4 * A - 1/8 * (3 * B - 2 * C);
            
            dd = zeros(6,6);
            
%             dx
% %             dx
            A = dDdxdx(X,t,posts(:,4),posts(:,1))*s1+dDdxdx(X,t,posts(:,4),posts(:,2))*s2+dDdxdx(X,t,posts(:,4),posts(:,3))*s3;
            B = dD2dxdx(X,t,posts(:,4),posts(:,1)) + dD2dxdx(X,t,posts(:,4),posts(:,2)) + dD2dxdx(X,t,posts(:,4),posts(:,3));
            C = dDDdxdx(X,t,posts(:,4),posts(:,1),posts(:,2)) + dDDdxdx(X,t,posts(:,4),posts(:,1),posts(:,3)) + dDDdxdx(X,t,posts(:,4),posts(:,2),posts(:,3));
            dd(1,1) = 1/4 * A - 1/8 * (3 * B - 2 * C);
% %             dvx
            A = dDdxdvx(X,t,posts(:,4),posts(:,1))*s1+dDdxdvx(X,t,posts(:,4),posts(:,2))*s2+dDdxdvx(X,t,posts(:,4),posts(:,3))*s3;
            B = dD2dxdvx(X,t,posts(:,4),posts(:,1)) + dD2dxdvx(X,t,posts(:,4),posts(:,2)) + dD2dxdvx(X,t,posts(:,4),posts(:,3));
            C = dDDdxdvx(X,t,posts(:,4),posts(:,1),posts(:,2)) + dDDdxdvx(X,t,posts(:,4),posts(:,1),posts(:,3)) + dDDdxdvx(X,t,posts(:,4),posts(:,2),posts(:,3));
            dd(2,1) = 1/4 * A - 1/8 * (3 * B - 2 * C);
            dd(1,2) = dd(2,1);
% %             dy
            A = dDdxdy(X,t,posts(:,4),posts(:,1))*s1+dDdxdy(X,t,posts(:,4),posts(:,2))*s2+dDdxdy(X,t,posts(:,4),posts(:,3))*s3;
            B = dD2dxdy(X,t,posts(:,4),posts(:,1)) + dD2dxdy(X,t,posts(:,4),posts(:,2)) + dD2dxdy(X,t,posts(:,4),posts(:,3));
            C = dDDdxdy(X,t,posts(:,4),posts(:,1),posts(:,2)) + dDDdxdy(X,t,posts(:,4),posts(:,1),posts(:,3)) + dDDdxdy(X,t,posts(:,4),posts(:,2),posts(:,3));
            dd(3,1) = 1/4 * A - 1/8 * (3 * B - 2 * C);
            dd(1,3) = dd(3,1);
% %             dvy
            A = dDdxdvy(X,t,posts(:,4),posts(:,1))*s1+dDdxdvy(X,t,posts(:,4),posts(:,2))*s2+dDdxdvy(X,t,posts(:,4),posts(:,3))*s3;
            B = dD2dxdvy(X,t,posts(:,4),posts(:,1)) + dD2dxdvy(X,t,posts(:,4),posts(:,2)) + dD2dxdvy(X,t,posts(:,4),posts(:,3));
            C = dDDdxdvy(X,t,posts(:,4),posts(:,1),posts(:,2)) + dDDdxdvy(X,t,posts(:,4),posts(:,1),posts(:,3)) + dDDdxdvy(X,t,posts(:,4),posts(:,2),posts(:,3));
            dd(4,1) = 1/4 * A - 1/8 * (3 * B - 2 * C);
            dd(1,4) = dd(4,1);
% %             dz
            A = dDdxdz(X,t,posts(:,4),posts(:,1))*s1+dDdxdz(X,t,posts(:,4),posts(:,2))*s2+dDdxdz(X,t,posts(:,4),posts(:,3))*s3;
            B = dD2dxdz(X,t,posts(:,4),posts(:,1)) + dD2dxdz(X,t,posts(:,4),posts(:,2)) + dD2dxdz(X,t,posts(:,4),posts(:,3));
            C = dDDdxdz(X,t,posts(:,4),posts(:,1),posts(:,2)) + dDDdxdz(X,t,posts(:,4),posts(:,1),posts(:,3)) + dDDdxdz(X,t,posts(:,4),posts(:,2),posts(:,3));
            dd(5,1) = 1/4 * A - 1/8 * (3 * B - 2 * C);
            dd(1,5) = dd(5,1);
% %             dvz
            A = dDdxdvz(X,t,posts(:,4),posts(:,1))*s1+dDdxdvz(X,t,posts(:,4),posts(:,2))*s2+dDdxdvz(X,t,posts(:,4),posts(:,3))*s3;
            B = dD2dxdvz(X,t,posts(:,4),posts(:,1)) + dD2dxdvz(X,t,posts(:,4),posts(:,2)) + dD2dxdvz(X,t,posts(:,4),posts(:,3));
            C = dDDdxdvz(X,t,posts(:,4),posts(:,1),posts(:,2)) + dDDdxdvz(X,t,posts(:,4),posts(:,1),posts(:,3)) + dDDdxdvz(X,t,posts(:,4),posts(:,2),posts(:,3));
            dd(6,1) = 1/4 * A - 1/8 * (3 * B - 2 * C);
            dd(1,6) = dd(6,1);   
%             dvx
% %             dvx
            A = dDdvxdvx(X,t,posts(:,4),posts(:,1))*s1+dDdvxdvx(X,t,posts(:,4),posts(:,2))*s2+dDdvxdvx(X,t,posts(:,4),posts(:,3))*s3;
            B = dD2dvxdvx(X,t,posts(:,4),posts(:,1)) + dD2dvxdvx(X,t,posts(:,4),posts(:,2)) + dD2dvxdvx(X,t,posts(:,4),posts(:,3));
            C = dDDdvxdvx(X,t,posts(:,4),posts(:,1),posts(:,2)) + dDDdvxdvx(X,t,posts(:,4),posts(:,1),posts(:,3)) + dDDdvxdvx(X,t,posts(:,4),posts(:,2),posts(:,3));
            dd(2,2) = 1/4 * A - 1/8 * (3 * B - 2 * C);
% %             dy
            A = dDdydvx(X,t,posts(:,4),posts(:,1))*s1+dDdydvx(X,t,posts(:,4),posts(:,2))*s2+dDdydvx(X,t,posts(:,4),posts(:,3))*s3;
            B = dD2dydvx(X,t,posts(:,4),posts(:,1)) + dD2dydvx(X,t,posts(:,4),posts(:,2)) + dD2dydvx(X,t,posts(:,4),posts(:,3));
            C = dDDdydvx(X,t,posts(:,4),posts(:,1),posts(:,2)) + dDDdydvx(X,t,posts(:,4),posts(:,1),posts(:,3)) + dDDdydvx(X,t,posts(:,4),posts(:,2),posts(:,3));
            dd(3,2) = 1/4 * A - 1/8 * (3 * B - 2 * C);
            dd(2,3) = dd(3,2);
% %             dvy
            A = dDdvxdvy(X,t,posts(:,4),posts(:,1))*s1+dDdvxdvy(X,t,posts(:,4),posts(:,2))*s2+dDdvxdvy(X,t,posts(:,4),posts(:,3))*s3;
            B = dD2dvxdvy(X,t,posts(:,4),posts(:,1)) + dD2dvxdvy(X,t,posts(:,4),posts(:,2)) + dD2dvxdvy(X,t,posts(:,4),posts(:,3));
            C = dDDdvxdvy(X,t,posts(:,4),posts(:,1),posts(:,2)) + dDDdvxdvy(X,t,posts(:,4),posts(:,1),posts(:,3)) + dDDdvxdvy(X,t,posts(:,4),posts(:,2),posts(:,3));
            dd(4,2) = 1/4 * A - 1/8 * (3 * B - 2 * C);
            dd(2,4) = dd(4,2);             
% %             dz
            A = dDdzdvx(X,t,posts(:,4),posts(:,1))*s1+dDdzdvx(X,t,posts(:,4),posts(:,2))*s2+dDdzdvx(X,t,posts(:,4),posts(:,3))*s3;
            B = dD2dzdvx(X,t,posts(:,4),posts(:,1)) + dD2dzdvx(X,t,posts(:,4),posts(:,2)) + dD2dzdvx(X,t,posts(:,4),posts(:,3));
            C = dDDdzdvx(X,t,posts(:,4),posts(:,1),posts(:,2)) + dDDdzdvx(X,t,posts(:,4),posts(:,1),posts(:,3)) + dDDdzdvx(X,t,posts(:,4),posts(:,2),posts(:,3));
            dd(5,2) = 1/4 * A - 1/8 * (3 * B - 2 * C);
            dd(2,5) = dd(5,2);
% %             dvz
            A = dDdvxdvz(X,t,posts(:,4),posts(:,1))*s1+dDdvxdvz(X,t,posts(:,4),posts(:,2))*s2+dDdvxdvz(X,t,posts(:,4),posts(:,3))*s3;
            B = dD2dvxdvz(X,t,posts(:,4),posts(:,1)) + dD2dvxdvz(X,t,posts(:,4),posts(:,2)) + dD2dvxdvz(X,t,posts(:,4),posts(:,3));
            C = dDDdvxdvz(X,t,posts(:,4),posts(:,1),posts(:,2)) + dDDdvxdvz(X,t,posts(:,4),posts(:,1),posts(:,3)) + dDDdvxdvz(X,t,posts(:,4),posts(:,2),posts(:,3));
            dd(6,2) = 1/4 * A - 1/8 * (3 * B - 2 * C);
            dd(2,6) = dd(6,2);
%             dy
% %             dy
            A = dDdydy(X,t,posts(:,4),posts(:,1))*s1+dDdydy(X,t,posts(:,4),posts(:,2))*s2+dDdydy(X,t,posts(:,4),posts(:,3))*s3;
            B = dD2dydy(X,t,posts(:,4),posts(:,1)) + dD2dydy(X,t,posts(:,4),posts(:,2)) + dD2dydy(X,t,posts(:,4),posts(:,3));
            C = dDDdydy(X,t,posts(:,4),posts(:,1),posts(:,2)) + dDDdydy(X,t,posts(:,4),posts(:,1),posts(:,3)) + dDDdydy(X,t,posts(:,4),posts(:,2),posts(:,3));
            dd(3,3) = 1/4 * A - 1/8 * (3 * B - 2 * C);
% %             dvy
            A = dDdydvy(X,t,posts(:,4),posts(:,1))*s1+dDdydvy(X,t,posts(:,4),posts(:,2))*s2+dDdydvy(X,t,posts(:,4),posts(:,3))*s3;
            B = dD2dydvy(X,t,posts(:,4),posts(:,1)) + dD2dydvy(X,t,posts(:,4),posts(:,2)) + dD2dydvy(X,t,posts(:,4),posts(:,3));
            C = dDDdydvy(X,t,posts(:,4),posts(:,1),posts(:,2)) + dDDdydvy(X,t,posts(:,4),posts(:,1),posts(:,3)) + dDDdydvy(X,t,posts(:,4),posts(:,2),posts(:,3));
            dd(4,3) = 1/4 * A - 1/8 * (3 * B - 2 * C);
            dd(3,4) = dd(4,3);        
% %             dz
            A = dDdydz(X,t,posts(:,4),posts(:,1))*s1+dDdydz(X,t,posts(:,4),posts(:,2))*s2+dDdydz(X,t,posts(:,4),posts(:,3))*s3;
            B = dD2dydz(X,t,posts(:,4),posts(:,1)) + dD2dydz(X,t,posts(:,4),posts(:,2)) + dD2dydz(X,t,posts(:,4),posts(:,3));
            C = dDDdydz(X,t,posts(:,4),posts(:,1),posts(:,2)) + dDDdydz(X,t,posts(:,4),posts(:,1),posts(:,3)) + dDDdydz(X,t,posts(:,4),posts(:,2),posts(:,3));
            dd(5,3) = 1/4 * A - 1/8 * (3 * B - 2 * C);
            dd(3,5) = dd(5,3);   
% %             dvz
            A = dDdydvz(X,t,posts(:,4),posts(:,1))*s1+dDdydvz(X,t,posts(:,4),posts(:,2))*s2+dDdydvz(X,t,posts(:,4),posts(:,3))*s3;
            B = dD2dydvz(X,t,posts(:,4),posts(:,1)) + dD2dydvz(X,t,posts(:,4),posts(:,2)) + dD2dydvz(X,t,posts(:,4),posts(:,3));
            C = dDDdydvz(X,t,posts(:,4),posts(:,1),posts(:,2)) + dDDdydvz(X,t,posts(:,4),posts(:,1),posts(:,3)) + dDDdydvz(X,t,posts(:,4),posts(:,2),posts(:,3));
            dd(6,3) = 1/4 * A - 1/8 * (3 * B - 2 * C);
            dd(3,6) = dd(6,3);  
%             dvy
% %             dvy
            A = dDdvydvy(X,t,posts(:,4),posts(:,1))*s1+dDdvydvy(X,t,posts(:,4),posts(:,2))*s2+dDdvydvy(X,t,posts(:,4),posts(:,3))*s3;
            B = dD2dvydvy(X,t,posts(:,4),posts(:,1)) + dD2dvydvy(X,t,posts(:,4),posts(:,2)) + dD2dvydvy(X,t,posts(:,4),posts(:,3));
            C = dDDdvydvy(X,t,posts(:,4),posts(:,1),posts(:,2)) + dDDdvydvy(X,t,posts(:,4),posts(:,1),posts(:,3)) + dDDdvydvy(X,t,posts(:,4),posts(:,2),posts(:,3));
            dd(4,4) = 1/4 * A - 1/8 * (3 * B - 2 * C);
% %             dz
            A = dDdzdvy(X,t,posts(:,4),posts(:,1))*s1+dDdzdvy(X,t,posts(:,4),posts(:,2))*s2+dDdzdvy(X,t,posts(:,4),posts(:,3))*s3;
            B = dD2dzdvy(X,t,posts(:,4),posts(:,1)) + dD2dzdvy(X,t,posts(:,4),posts(:,2)) + dD2dzdvy(X,t,posts(:,4),posts(:,3));
            C = dDDdzdvy(X,t,posts(:,4),posts(:,1),posts(:,2)) + dDDdzdvy(X,t,posts(:,4),posts(:,1),posts(:,3)) + dDDdzdvy(X,t,posts(:,4),posts(:,2),posts(:,3));
            dd(5,4) = 1/4 * A - 1/8 * (3 * B - 2 * C);
            dd(4,5) = dd(5,4);            
% %             dvz
            A = dDdvydvz(X,t,posts(:,4),posts(:,1))*s1+dDdvydvz(X,t,posts(:,4),posts(:,2))*s2+dDdvydvz(X,t,posts(:,4),posts(:,3))*s3;
            B = dD2dvydvz(X,t,posts(:,4),posts(:,1)) + dD2dvydvz(X,t,posts(:,4),posts(:,2)) + dD2dvydvz(X,t,posts(:,4),posts(:,3));
            C = dDDdvydvz(X,t,posts(:,4),posts(:,1),posts(:,2)) + dDDdvydvz(X,t,posts(:,4),posts(:,1),posts(:,3)) + dDDdvydvz(X,t,posts(:,4),posts(:,2),posts(:,3));
            dd(6,4) = 1/4 * A - 1/8 * (3 * B - 2 * C);
            dd(4,6) = dd(6,4);
%             dz            
% %             dz
            A = dDdzdz(X,t,posts(:,4),posts(:,1))*s1+dDdzdz(X,t,posts(:,4),posts(:,2))*s2+dDdzdz(X,t,posts(:,4),posts(:,3))*s3;
            B = dD2dzdz(X,t,posts(:,4),posts(:,1)) + dD2dzdz(X,t,posts(:,4),posts(:,2)) + dD2dzdz(X,t,posts(:,4),posts(:,3));
            C = dDDdzdz(X,t,posts(:,4),posts(:,1),posts(:,2)) + dDDdzdz(X,t,posts(:,4),posts(:,1),posts(:,3)) + dDDdzdz(X,t,posts(:,4),posts(:,2),posts(:,3));
            dd(5,5) = 1/4 * A - 1/8 * (3 * B - 2 * C);
% %             dvz
            A = dDdzdvz(X,t,posts(:,4),posts(:,1))*s1+dDdzdvz(X,t,posts(:,4),posts(:,2))*s2+dDdzdvz(X,t,posts(:,4),posts(:,3))*s3;
            B = dD2dzdvz(X,t,posts(:,4),posts(:,1)) + dD2dzdvz(X,t,posts(:,4),posts(:,2)) + dD2dzdvz(X,t,posts(:,4),posts(:,3));
            C = dDDdzdvz(X,t,posts(:,4),posts(:,1),posts(:,2)) + dDDdzdvz(X,t,posts(:,4),posts(:,1),posts(:,3)) + dDDdzdvz(X,t,posts(:,4),posts(:,2),posts(:,3));
            dd(6,5) = 1/4 * A - 1/8 * (3 * B - 2 * C);
            dd(5,6) = dd(6,5);   
%             dvz            
% %             dvz
            A = dDdvzdvz(X,t,posts(:,4),posts(:,1))*s1+dDdvzdvz(X,t,posts(:,4),posts(:,2))*s2+dDdvzdvz(X,t,posts(:,4),posts(:,3))*s3;
            B = dD2dvzdvz(X,t,posts(:,4),posts(:,1)) + dD2dvzdvz(X,t,posts(:,4),posts(:,2)) + dD2dvzdvz(X,t,posts(:,4),posts(:,3));
            C = dDDdvzdvz(X,t,posts(:,4),posts(:,1),posts(:,2)) + dDDdvzdvz(X,t,posts(:,4),posts(:,1),posts(:,3)) + dDDdvzdvz(X,t,posts(:,4),posts(:,2),posts(:,3));
            dd(6,6) = 1/4 * A - 1/8 * (3 * B - 2 * C);    
            
        case 3
            rd1 = toa(3) - toa(1);
            rd2 = toa(3) - toa(2);
        case 2
            rd1 = toa(2) - toa(1);
    end
end

