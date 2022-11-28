function [d, dd] = get_deriv_rdm2(X, t, toa, posts)
    cnt = length(toa);
    switch cnt
        case 4
            rd1 = toa(4) - toa(1);
            rd2 = toa(4) - toa(2);
            rd3 = toa(4) - toa(3);
            
            s1 = 3 * rd1 - rd2 - rd3;
            s2 = -rd1 + 3 * rd2 - rd3;
            s3 = -rd1 - rd2 + 3 * rd3;
            
            d = zeros(9,1);
            
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
%             dax
            A = dDdax(X,t,posts(:,4),posts(:,1))*s1+dDdax(X,t,posts(:,4),posts(:,2))*s2+dDdax(X,t,posts(:,4),posts(:,3))*s3;
            B = dD2dax(X,t,posts(:,4),posts(:,1)) + dD2dax(X,t,posts(:,4),posts(:,2)) + dD2dax(X,t,posts(:,4),posts(:,3));
            C = dDDdax(X,t,posts(:,4),posts(:,1),posts(:,2)) + dDDdax(X,t,posts(:,4),posts(:,1),posts(:,3)) + dDDdax(X,t,posts(:,4),posts(:,2),posts(:,3));
            d(3,1) = 1/4 * A - 1/8 * (3 * B - 2 * C);
%             dy
            A = dDdy(X,t,posts(:,4),posts(:,1))*s1+dDdy(X,t,posts(:,4),posts(:,2))*s2+dDdy(X,t,posts(:,4),posts(:,3))*s3;
            B = dD2dy(X,t,posts(:,4),posts(:,1)) + dD2dy(X,t,posts(:,4),posts(:,2)) + dD2dy(X,t,posts(:,4),posts(:,3));
            C = dDDdy(X,t,posts(:,4),posts(:,1),posts(:,2)) + dDDdy(X,t,posts(:,4),posts(:,1),posts(:,3)) + dDDdy(X,t,posts(:,4),posts(:,2),posts(:,3));
            d(4,1) = 1/4 * A - 1/8 * (3 * B - 2 * C);
%             vy
            A = dDdvy(X,t,posts(:,4),posts(:,1))*s1+dDdvy(X,t,posts(:,4),posts(:,2))*s2+dDdvy(X,t,posts(:,4),posts(:,3))*s3;
            B = dD2dvy(X,t,posts(:,4),posts(:,1)) + dD2dvy(X,t,posts(:,4),posts(:,2)) + dD2dvy(X,t,posts(:,4),posts(:,3));
            C = dDDdvy(X,t,posts(:,4),posts(:,1),posts(:,2)) + dDDdvy(X,t,posts(:,4),posts(:,1),posts(:,3)) + dDDdvy(X,t,posts(:,4),posts(:,2),posts(:,3));
            d(5,1) = 1/4 * A - 1/8 * (3 * B - 2 * C);
%             ay
            A = dDday(X,t,posts(:,4),posts(:,1))*s1+dDday(X,t,posts(:,4),posts(:,2))*s2+dDday(X,t,posts(:,4),posts(:,3))*s3;
            B = dD2day(X,t,posts(:,4),posts(:,1)) + dD2day(X,t,posts(:,4),posts(:,2)) + dD2day(X,t,posts(:,4),posts(:,3));
            C = dDDday(X,t,posts(:,4),posts(:,1),posts(:,2)) + dDDday(X,t,posts(:,4),posts(:,1),posts(:,3)) + dDDday(X,t,posts(:,4),posts(:,2),posts(:,3));
            d(6,1) = 1/4 * A - 1/8 * (3 * B - 2 * C);
%             z
            A = dDdz(X,t,posts(:,4),posts(:,1))*s1+dDdz(X,t,posts(:,4),posts(:,2))*s2+dDdz(X,t,posts(:,4),posts(:,3))*s3;
            B = dD2dz(X,t,posts(:,4),posts(:,1)) + dD2dz(X,t,posts(:,4),posts(:,2)) + dD2dz(X,t,posts(:,4),posts(:,3));
            C = dDDdz(X,t,posts(:,4),posts(:,1),posts(:,2)) + dDDdz(X,t,posts(:,4),posts(:,1),posts(:,3)) + dDDdz(X,t,posts(:,4),posts(:,2),posts(:,3));
            d(7,1) = 1/4 * A - 1/8 * (3 * B - 2 * C);
%             vz
            A = dDdvz(X,t,posts(:,4),posts(:,1))*s1+dDdvz(X,t,posts(:,4),posts(:,2))*s2+dDdvz(X,t,posts(:,4),posts(:,3))*s3;
            B = dD2dvz(X,t,posts(:,4),posts(:,1)) + dD2dvz(X,t,posts(:,4),posts(:,2)) + dD2dvz(X,t,posts(:,4),posts(:,3));
            C = dDDdvz(X,t,posts(:,4),posts(:,1),posts(:,2)) + dDDdvz(X,t,posts(:,4),posts(:,1),posts(:,3)) + dDDdvz(X,t,posts(:,4),posts(:,2),posts(:,3));
            d(8,1) = 1/4 * A - 1/8 * (3 * B - 2 * C);
%             az
            A = dDdaz(X,t,posts(:,4),posts(:,1))*s1+dDdaz(X,t,posts(:,4),posts(:,2))*s2+dDdaz(X,t,posts(:,4),posts(:,3))*s3;
            B = dD2daz(X,t,posts(:,4),posts(:,1)) + dD2daz(X,t,posts(:,4),posts(:,2)) + dD2daz(X,t,posts(:,4),posts(:,3));
            C = dDDdaz(X,t,posts(:,4),posts(:,1),posts(:,2)) + dDDdaz(X,t,posts(:,4),posts(:,1),posts(:,3)) + dDDdaz(X,t,posts(:,4),posts(:,2),posts(:,3));
            d(9,1) = 1/4 * A - 1/8 * (3 * B - 2 * C);
            
            dd = zeros(9,9);
            
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
% %             dax
            A = dDdxdax(X,t,posts(:,4),posts(:,1))*s1+dDdxdax(X,t,posts(:,4),posts(:,2))*s2+dDdxdax(X,t,posts(:,4),posts(:,3))*s3;
            B = dD2dxdax(X,t,posts(:,4),posts(:,1)) + dD2dxdax(X,t,posts(:,4),posts(:,2)) + dD2dxdax(X,t,posts(:,4),posts(:,3));
            C = dDDdxdax(X,t,posts(:,4),posts(:,1),posts(:,2)) + dDDdxdax(X,t,posts(:,4),posts(:,1),posts(:,3)) + dDDdxdax(X,t,posts(:,4),posts(:,2),posts(:,3));
            dd(3,1) = 1/4 * A - 1/8 * (3 * B - 2 * C);
            dd(1,3) = dd(3,1);
% %             dy
            A = dDdxdy(X,t,posts(:,4),posts(:,1))*s1+dDdxdy(X,t,posts(:,4),posts(:,2))*s2+dDdxdy(X,t,posts(:,4),posts(:,3))*s3;
            B = dD2dxdy(X,t,posts(:,4),posts(:,1)) + dD2dxdy(X,t,posts(:,4),posts(:,2)) + dD2dxdy(X,t,posts(:,4),posts(:,3));
            C = dDDdxdy(X,t,posts(:,4),posts(:,1),posts(:,2)) + dDDdxdy(X,t,posts(:,4),posts(:,1),posts(:,3)) + dDDdxdy(X,t,posts(:,4),posts(:,2),posts(:,3));
            dd(4,1) = 1/4 * A - 1/8 * (3 * B - 2 * C);
            dd(1,4) = dd(4,1);
% %             dvy
            A = dDdxdvy(X,t,posts(:,4),posts(:,1))*s1+dDdxdvy(X,t,posts(:,4),posts(:,2))*s2+dDdxdvy(X,t,posts(:,4),posts(:,3))*s3;
            B = dD2dxdvy(X,t,posts(:,4),posts(:,1)) + dD2dxdvy(X,t,posts(:,4),posts(:,2)) + dD2dxdvy(X,t,posts(:,4),posts(:,3));
            C = dDDdxdvy(X,t,posts(:,4),posts(:,1),posts(:,2)) + dDDdxdvy(X,t,posts(:,4),posts(:,1),posts(:,3)) + dDDdxdvy(X,t,posts(:,4),posts(:,2),posts(:,3));
            dd(5,1) = 1/4 * A - 1/8 * (3 * B - 2 * C);
            dd(1,5) = dd(5,1);
% %             day
            A = dDdxday(X,t,posts(:,4),posts(:,1))*s1+dDdxday(X,t,posts(:,4),posts(:,2))*s2+dDdxday(X,t,posts(:,4),posts(:,3))*s3;
            B = dD2dxday(X,t,posts(:,4),posts(:,1)) + dD2dxday(X,t,posts(:,4),posts(:,2)) + dD2dxday(X,t,posts(:,4),posts(:,3));
            C = dDDdxday(X,t,posts(:,4),posts(:,1),posts(:,2)) + dDDdxday(X,t,posts(:,4),posts(:,1),posts(:,3)) + dDDdxday(X,t,posts(:,4),posts(:,2),posts(:,3));
            dd(6,1) = 1/4 * A - 1/8 * (3 * B - 2 * C);
            dd(1,6) = dd(6,1);
% %             dz
            A = dDdxdz(X,t,posts(:,4),posts(:,1))*s1+dDdxdz(X,t,posts(:,4),posts(:,2))*s2+dDdxdz(X,t,posts(:,4),posts(:,3))*s3;
            B = dD2dxdz(X,t,posts(:,4),posts(:,1)) + dD2dxdz(X,t,posts(:,4),posts(:,2)) + dD2dxdz(X,t,posts(:,4),posts(:,3));
            C = dDDdxdz(X,t,posts(:,4),posts(:,1),posts(:,2)) + dDDdxdz(X,t,posts(:,4),posts(:,1),posts(:,3)) + dDDdxdz(X,t,posts(:,4),posts(:,2),posts(:,3));
            dd(7,1) = 1/4 * A - 1/8 * (3 * B - 2 * C);
            dd(1,7) = dd(7,1);
% %             dvz
            A = dDdxdvz(X,t,posts(:,4),posts(:,1))*s1+dDdxdvz(X,t,posts(:,4),posts(:,2))*s2+dDdxdvz(X,t,posts(:,4),posts(:,3))*s3;
            B = dD2dxdvz(X,t,posts(:,4),posts(:,1)) + dD2dxdvz(X,t,posts(:,4),posts(:,2)) + dD2dxdvz(X,t,posts(:,4),posts(:,3));
            C = dDDdxdvz(X,t,posts(:,4),posts(:,1),posts(:,2)) + dDDdxdvz(X,t,posts(:,4),posts(:,1),posts(:,3)) + dDDdxdvz(X,t,posts(:,4),posts(:,2),posts(:,3));
            dd(8,1) = 1/4 * A - 1/8 * (3 * B - 2 * C);
            dd(1,8) = dd(8,1);
% %             daz
            A = dDdxdaz(X,t,posts(:,4),posts(:,1))*s1+dDdxdaz(X,t,posts(:,4),posts(:,2))*s2+dDdxdaz(X,t,posts(:,4),posts(:,3))*s3;
            B = dD2dxdaz(X,t,posts(:,4),posts(:,1)) + dD2dxdaz(X,t,posts(:,4),posts(:,2)) + dD2dxdaz(X,t,posts(:,4),posts(:,3));
            C = dDDdxdaz(X,t,posts(:,4),posts(:,1),posts(:,2)) + dDDdxdaz(X,t,posts(:,4),posts(:,1),posts(:,3)) + dDDdxdaz(X,t,posts(:,4),posts(:,2),posts(:,3));
            dd(9,1) = 1/4 * A - 1/8 * (3 * B - 2 * C);
            dd(1,9) = dd(9,1);            
%             dvx
% %             dvx
            A = dDdvxdvx(X,t,posts(:,4),posts(:,1))*s1+dDdvxdvx(X,t,posts(:,4),posts(:,2))*s2+dDdvxdvx(X,t,posts(:,4),posts(:,3))*s3;
            B = dD2dvxdvx(X,t,posts(:,4),posts(:,1)) + dD2dvxdvx(X,t,posts(:,4),posts(:,2)) + dD2dvxdvx(X,t,posts(:,4),posts(:,3));
            C = dDDdvxdvx(X,t,posts(:,4),posts(:,1),posts(:,2)) + dDDdvxdvx(X,t,posts(:,4),posts(:,1),posts(:,3)) + dDDdvxdvx(X,t,posts(:,4),posts(:,2),posts(:,3));
            dd(2,2) = 1/4 * A - 1/8 * (3 * B - 2 * C);
% %             dax
            A = dDdvxdax(X,t,posts(:,4),posts(:,1))*s1+dDdvxdax(X,t,posts(:,4),posts(:,2))*s2+dDdvxdax(X,t,posts(:,4),posts(:,3))*s3;
            B = dD2dvxdax(X,t,posts(:,4),posts(:,1)) + dD2dvxdax(X,t,posts(:,4),posts(:,2)) + dD2dvxdax(X,t,posts(:,4),posts(:,3));
            C = dDDdvxdax(X,t,posts(:,4),posts(:,1),posts(:,2)) + dDDdvxdax(X,t,posts(:,4),posts(:,1),posts(:,3)) + dDDdvxdax(X,t,posts(:,4),posts(:,2),posts(:,3));
            dd(3,2) = 1/4 * A - 1/8 * (3 * B - 2 * C);
            dd(2,3) = dd(3,2);
% %             dy
            A = dDdydvx(X,t,posts(:,4),posts(:,1))*s1+dDdydvx(X,t,posts(:,4),posts(:,2))*s2+dDdydvx(X,t,posts(:,4),posts(:,3))*s3;
            B = dD2dydvx(X,t,posts(:,4),posts(:,1)) + dD2dydvx(X,t,posts(:,4),posts(:,2)) + dD2dydvx(X,t,posts(:,4),posts(:,3));
            C = dDDdydvx(X,t,posts(:,4),posts(:,1),posts(:,2)) + dDDdydvx(X,t,posts(:,4),posts(:,1),posts(:,3)) + dDDdydvx(X,t,posts(:,4),posts(:,2),posts(:,3));
            dd(4,2) = 1/4 * A - 1/8 * (3 * B - 2 * C);
            dd(2,4) = dd(4,2);
% %             dvy
            A = dDdvxdvy(X,t,posts(:,4),posts(:,1))*s1+dDdvxdvy(X,t,posts(:,4),posts(:,2))*s2+dDdvxdvy(X,t,posts(:,4),posts(:,3))*s3;
            B = dD2dvxdvy(X,t,posts(:,4),posts(:,1)) + dD2dvxdvy(X,t,posts(:,4),posts(:,2)) + dD2dvxdvy(X,t,posts(:,4),posts(:,3));
            C = dDDdvxdvy(X,t,posts(:,4),posts(:,1),posts(:,2)) + dDDdvxdvy(X,t,posts(:,4),posts(:,1),posts(:,3)) + dDDdvxdvy(X,t,posts(:,4),posts(:,2),posts(:,3));
            dd(5,2) = 1/4 * A - 1/8 * (3 * B - 2 * C);
            dd(2,5) = dd(5,2);            
% %             day
            A = dDdvxday(X,t,posts(:,4),posts(:,1))*s1+dDdvxday(X,t,posts(:,4),posts(:,2))*s2+dDdvxday(X,t,posts(:,4),posts(:,3))*s3;
            B = dD2dvxday(X,t,posts(:,4),posts(:,1)) + dD2dvxday(X,t,posts(:,4),posts(:,2)) + dD2dvxday(X,t,posts(:,4),posts(:,3));
            C = dDDdvxday(X,t,posts(:,4),posts(:,1),posts(:,2)) + dDDdvxday(X,t,posts(:,4),posts(:,1),posts(:,3)) + dDDdvxday(X,t,posts(:,4),posts(:,2),posts(:,3));
            dd(6,2) = 1/4 * A - 1/8 * (3 * B - 2 * C);
            dd(2,6) = dd(6,2);       
% %             dz
            A = dDdzdvx(X,t,posts(:,4),posts(:,1))*s1+dDdzdvx(X,t,posts(:,4),posts(:,2))*s2+dDdzdvx(X,t,posts(:,4),posts(:,3))*s3;
            B = dD2dzdvx(X,t,posts(:,4),posts(:,1)) + dD2dzdvx(X,t,posts(:,4),posts(:,2)) + dD2dzdvx(X,t,posts(:,4),posts(:,3));
            C = dDDdzdvx(X,t,posts(:,4),posts(:,1),posts(:,2)) + dDDdzdvx(X,t,posts(:,4),posts(:,1),posts(:,3)) + dDDdzdvx(X,t,posts(:,4),posts(:,2),posts(:,3));
            dd(7,2) = 1/4 * A - 1/8 * (3 * B - 2 * C);
            dd(2,7) = dd(7,2);
% %             dvz
            A = dDdvxdvz(X,t,posts(:,4),posts(:,1))*s1+dDdvxdvz(X,t,posts(:,4),posts(:,2))*s2+dDdvxdvz(X,t,posts(:,4),posts(:,3))*s3;
            B = dD2dvxdvz(X,t,posts(:,4),posts(:,1)) + dD2dvxdvz(X,t,posts(:,4),posts(:,2)) + dD2dvxdvz(X,t,posts(:,4),posts(:,3));
            C = dDDdvxdvz(X,t,posts(:,4),posts(:,1),posts(:,2)) + dDDdvxdvz(X,t,posts(:,4),posts(:,1),posts(:,3)) + dDDdvxdvz(X,t,posts(:,4),posts(:,2),posts(:,3));
            dd(8,2) = 1/4 * A - 1/8 * (3 * B - 2 * C);
            dd(2,8) = dd(8,2);            
% %             daz
            A = dDdvxdaz(X,t,posts(:,4),posts(:,1))*s1+dDdvxdaz(X,t,posts(:,4),posts(:,2))*s2+dDdvxdaz(X,t,posts(:,4),posts(:,3))*s3;
            B = dD2dvxdaz(X,t,posts(:,4),posts(:,1)) + dD2dvxdaz(X,t,posts(:,4),posts(:,2)) + dD2dvxdaz(X,t,posts(:,4),posts(:,3));
            C = dDDdvxdaz(X,t,posts(:,4),posts(:,1),posts(:,2)) + dDDdvxdaz(X,t,posts(:,4),posts(:,1),posts(:,3)) + dDDdvxdaz(X,t,posts(:,4),posts(:,2),posts(:,3));
            dd(9,2) = 1/4 * A - 1/8 * (3 * B - 2 * C);
            dd(2,9) = dd(9,2);      
%             dax
% %             dax
            A = dDdaxdax(X,t,posts(:,4),posts(:,1))*s1+dDdaxdax(X,t,posts(:,4),posts(:,2))*s2+dDdaxdax(X,t,posts(:,4),posts(:,3))*s3;
            B = dD2daxdax(X,t,posts(:,4),posts(:,1)) + dD2daxdax(X,t,posts(:,4),posts(:,2)) + dD2daxdax(X,t,posts(:,4),posts(:,3));
            C = dDDdaxdax(X,t,posts(:,4),posts(:,1),posts(:,2)) + dDDdaxdax(X,t,posts(:,4),posts(:,1),posts(:,3)) + dDDdaxdax(X,t,posts(:,4),posts(:,2),posts(:,3));
            dd(3,3) = 1/4 * A - 1/8 * (3 * B - 2 * C);
% %             dy
            A = dDdydax(X,t,posts(:,4),posts(:,1))*s1+dDdydax(X,t,posts(:,4),posts(:,2))*s2+dDdydax(X,t,posts(:,4),posts(:,3))*s3;
            B = dD2dydax(X,t,posts(:,4),posts(:,1)) + dD2dydax(X,t,posts(:,4),posts(:,2)) + dD2dydax(X,t,posts(:,4),posts(:,3));
            C = dDDdydax(X,t,posts(:,4),posts(:,1),posts(:,2)) + dDDdydax(X,t,posts(:,4),posts(:,1),posts(:,3)) + dDDdydax(X,t,posts(:,4),posts(:,2),posts(:,3));
            dd(4,3) = 1/4 * A - 1/8 * (3 * B - 2 * C);
            dd(3,4) = dd(4,3);    
% %             dvy
            A = dDdvydax(X,t,posts(:,4),posts(:,1))*s1+dDdvydax(X,t,posts(:,4),posts(:,2))*s2+dDdvydax(X,t,posts(:,4),posts(:,3))*s3;
            B = dD2dvydax(X,t,posts(:,4),posts(:,1)) + dD2dvydax(X,t,posts(:,4),posts(:,2)) + dD2dvydax(X,t,posts(:,4),posts(:,3));
            C = dDDdvydax(X,t,posts(:,4),posts(:,1),posts(:,2)) + dDDdvydax(X,t,posts(:,4),posts(:,1),posts(:,3)) + dDDdvydax(X,t,posts(:,4),posts(:,2),posts(:,3));
            dd(5,3) = 1/4 * A - 1/8 * (3 * B - 2 * C);
            dd(3,5) = dd(5,3);            
% %             day
            A = dDdaxday(X,t,posts(:,4),posts(:,1))*s1+dDdaxday(X,t,posts(:,4),posts(:,2))*s2+dDdaxday(X,t,posts(:,4),posts(:,3))*s3;
            B = dD2daxday(X,t,posts(:,4),posts(:,1)) + dD2daxday(X,t,posts(:,4),posts(:,2)) + dD2daxday(X,t,posts(:,4),posts(:,3));
            C = dDDdaxday(X,t,posts(:,4),posts(:,1),posts(:,2)) + dDDdaxday(X,t,posts(:,4),posts(:,1),posts(:,3)) + dDDdaxday(X,t,posts(:,4),posts(:,2),posts(:,3));
            dd(6,3) = 1/4 * A - 1/8 * (3 * B - 2 * C);
            dd(3,6) = dd(6,3);             
% %             dz
            A = dDdzdax(X,t,posts(:,4),posts(:,1))*s1+dDdzdax(X,t,posts(:,4),posts(:,2))*s2+dDdzdax(X,t,posts(:,4),posts(:,3))*s3;
            B = dD2dzdax(X,t,posts(:,4),posts(:,1)) + dD2dzdax(X,t,posts(:,4),posts(:,2)) + dD2dzdax(X,t,posts(:,4),posts(:,3));
            C = dDDdzdax(X,t,posts(:,4),posts(:,1),posts(:,2)) + dDDdzdax(X,t,posts(:,4),posts(:,1),posts(:,3)) + dDDdzdax(X,t,posts(:,4),posts(:,2),posts(:,3));
            dd(7,3) = 1/4 * A - 1/8 * (3 * B - 2 * C);
            dd(3,7) = dd(7,3);
% %             dvz
            A = dDdvzdax(X,t,posts(:,4),posts(:,1))*s1+dDdvzdax(X,t,posts(:,4),posts(:,2))*s2+dDdvzdax(X,t,posts(:,4),posts(:,3))*s3;
            B = dD2dvzdax(X,t,posts(:,4),posts(:,1)) + dD2dvzdax(X,t,posts(:,4),posts(:,2)) + dD2dvzdax(X,t,posts(:,4),posts(:,3));
            C = dDDdvzdax(X,t,posts(:,4),posts(:,1),posts(:,2)) + dDDdvzdax(X,t,posts(:,4),posts(:,1),posts(:,3)) + dDDdvzdax(X,t,posts(:,4),posts(:,2),posts(:,3));
            dd(8,3) = 1/4 * A - 1/8 * (3 * B - 2 * C);
            dd(3,8) = dd(8,3);            
% %             daz
            A = dDdaxdaz(X,t,posts(:,4),posts(:,1))*s1+dDdaxdaz(X,t,posts(:,4),posts(:,2))*s2+dDdaxdaz(X,t,posts(:,4),posts(:,3))*s3;
            B = dD2daxdaz(X,t,posts(:,4),posts(:,1)) + dD2daxdaz(X,t,posts(:,4),posts(:,2)) + dD2daxdaz(X,t,posts(:,4),posts(:,3));
            C = dDDdaxdaz(X,t,posts(:,4),posts(:,1),posts(:,2)) + dDDdaxdaz(X,t,posts(:,4),posts(:,1),posts(:,3)) + dDDdaxdaz(X,t,posts(:,4),posts(:,2),posts(:,3));
            dd(9,3) = 1/4 * A - 1/8 * (3 * B - 2 * C);
            dd(3,9) = dd(9,3);
%             dy
% %             dy
            A = dDdydy(X,t,posts(:,4),posts(:,1))*s1+dDdydy(X,t,posts(:,4),posts(:,2))*s2+dDdydy(X,t,posts(:,4),posts(:,3))*s3;
            B = dD2dydy(X,t,posts(:,4),posts(:,1)) + dD2dydy(X,t,posts(:,4),posts(:,2)) + dD2dydy(X,t,posts(:,4),posts(:,3));
            C = dDDdydy(X,t,posts(:,4),posts(:,1),posts(:,2)) + dDDdydy(X,t,posts(:,4),posts(:,1),posts(:,3)) + dDDdydy(X,t,posts(:,4),posts(:,2),posts(:,3));
            dd(4,4) = 1/4 * A - 1/8 * (3 * B - 2 * C);
% %             dvy
            A = dDdydvy(X,t,posts(:,4),posts(:,1))*s1+dDdydvy(X,t,posts(:,4),posts(:,2))*s2+dDdydvy(X,t,posts(:,4),posts(:,3))*s3;
            B = dD2dydvy(X,t,posts(:,4),posts(:,1)) + dD2dydvy(X,t,posts(:,4),posts(:,2)) + dD2dydvy(X,t,posts(:,4),posts(:,3));
            C = dDDdydvy(X,t,posts(:,4),posts(:,1),posts(:,2)) + dDDdydvy(X,t,posts(:,4),posts(:,1),posts(:,3)) + dDDdydvy(X,t,posts(:,4),posts(:,2),posts(:,3));
            dd(5,4) = 1/4 * A - 1/8 * (3 * B - 2 * C);
            dd(4,5) = dd(5,4);
% %             day
            A = dDdyday(X,t,posts(:,4),posts(:,1))*s1+dDdyday(X,t,posts(:,4),posts(:,2))*s2+dDdyday(X,t,posts(:,4),posts(:,3))*s3;
            B = dD2dyday(X,t,posts(:,4),posts(:,1)) + dD2dyday(X,t,posts(:,4),posts(:,2)) + dD2dyday(X,t,posts(:,4),posts(:,3));
            C = dDDdyday(X,t,posts(:,4),posts(:,1),posts(:,2)) + dDDdyday(X,t,posts(:,4),posts(:,1),posts(:,3)) + dDDdyday(X,t,posts(:,4),posts(:,2),posts(:,3));
            dd(6,4) = 1/4 * A - 1/8 * (3 * B - 2 * C);
            dd(4,6) = dd(6,4);            
% %             dz
            A = dDdydz(X,t,posts(:,4),posts(:,1))*s1+dDdydz(X,t,posts(:,4),posts(:,2))*s2+dDdydz(X,t,posts(:,4),posts(:,3))*s3;
            B = dD2dydz(X,t,posts(:,4),posts(:,1)) + dD2dydz(X,t,posts(:,4),posts(:,2)) + dD2dydz(X,t,posts(:,4),posts(:,3));
            C = dDDdydz(X,t,posts(:,4),posts(:,1),posts(:,2)) + dDDdydz(X,t,posts(:,4),posts(:,1),posts(:,3)) + dDDdydz(X,t,posts(:,4),posts(:,2),posts(:,3));
            dd(7,4) = 1/4 * A - 1/8 * (3 * B - 2 * C);
            dd(4,7) = dd(7,4);   
% %             dvz
            A = dDdydvz(X,t,posts(:,4),posts(:,1))*s1+dDdydvz(X,t,posts(:,4),posts(:,2))*s2+dDdydvz(X,t,posts(:,4),posts(:,3))*s3;
            B = dD2dydvz(X,t,posts(:,4),posts(:,1)) + dD2dydvz(X,t,posts(:,4),posts(:,2)) + dD2dydvz(X,t,posts(:,4),posts(:,3));
            C = dDDdydvz(X,t,posts(:,4),posts(:,1),posts(:,2)) + dDDdydvz(X,t,posts(:,4),posts(:,1),posts(:,3)) + dDDdydvz(X,t,posts(:,4),posts(:,2),posts(:,3));
            dd(8,4) = 1/4 * A - 1/8 * (3 * B - 2 * C);
            dd(4,8) = dd(8,4); 
% %             daz
            A = dDdydaz(X,t,posts(:,4),posts(:,1))*s1+dDdydaz(X,t,posts(:,4),posts(:,2))*s2+dDdydaz(X,t,posts(:,4),posts(:,3))*s3;
            B = dD2dydaz(X,t,posts(:,4),posts(:,1)) + dD2dydaz(X,t,posts(:,4),posts(:,2)) + dD2dydaz(X,t,posts(:,4),posts(:,3));
            C = dDDdydaz(X,t,posts(:,4),posts(:,1),posts(:,2)) + dDDdydaz(X,t,posts(:,4),posts(:,1),posts(:,3)) + dDDdydaz(X,t,posts(:,4),posts(:,2),posts(:,3));
            dd(9,4) = 1/4 * A - 1/8 * (3 * B - 2 * C);
            dd(4,9) = dd(9,4);  
%             dvy
% %             dvy
            A = dDdvydvy(X,t,posts(:,4),posts(:,1))*s1+dDdvydvy(X,t,posts(:,4),posts(:,2))*s2+dDdvydvy(X,t,posts(:,4),posts(:,3))*s3;
            B = dD2dvydvy(X,t,posts(:,4),posts(:,1)) + dD2dvydvy(X,t,posts(:,4),posts(:,2)) + dD2dvydvy(X,t,posts(:,4),posts(:,3));
            C = dDDdvydvy(X,t,posts(:,4),posts(:,1),posts(:,2)) + dDDdvydvy(X,t,posts(:,4),posts(:,1),posts(:,3)) + dDDdvydvy(X,t,posts(:,4),posts(:,2),posts(:,3));
            dd(5,5) = 1/4 * A - 1/8 * (3 * B - 2 * C);
% %             day
            A = dDdvyday(X,t,posts(:,4),posts(:,1))*s1+dDdvyday(X,t,posts(:,4),posts(:,2))*s2+dDdvyday(X,t,posts(:,4),posts(:,3))*s3;
            B = dD2dvyday(X,t,posts(:,4),posts(:,1)) + dD2dvyday(X,t,posts(:,4),posts(:,2)) + dD2dvyday(X,t,posts(:,4),posts(:,3));
            C = dDDdvyday(X,t,posts(:,4),posts(:,1),posts(:,2)) + dDDdvyday(X,t,posts(:,4),posts(:,1),posts(:,3)) + dDDdvyday(X,t,posts(:,4),posts(:,2),posts(:,3));
            dd(6,5) = 1/4 * A - 1/8 * (3 * B - 2 * C);
            dd(5,6) = dd(6,5);
% %             dz
            A = dDdzdvy(X,t,posts(:,4),posts(:,1))*s1+dDdzdvy(X,t,posts(:,4),posts(:,2))*s2+dDdzdvy(X,t,posts(:,4),posts(:,3))*s3;
            B = dD2dzdvy(X,t,posts(:,4),posts(:,1)) + dD2dzdvy(X,t,posts(:,4),posts(:,2)) + dD2dzdvy(X,t,posts(:,4),posts(:,3));
            C = dDDdzdvy(X,t,posts(:,4),posts(:,1),posts(:,2)) + dDDdzdvy(X,t,posts(:,4),posts(:,1),posts(:,3)) + dDDdzdvy(X,t,posts(:,4),posts(:,2),posts(:,3));
            dd(7,5) = 1/4 * A - 1/8 * (3 * B - 2 * C);
            dd(5,7) = dd(7,5);            
% %             dvz
            A = dDdvydvz(X,t,posts(:,4),posts(:,1))*s1+dDdvydvz(X,t,posts(:,4),posts(:,2))*s2+dDdvydvz(X,t,posts(:,4),posts(:,3))*s3;
            B = dD2dvydvz(X,t,posts(:,4),posts(:,1)) + dD2dvydvz(X,t,posts(:,4),posts(:,2)) + dD2dvydvz(X,t,posts(:,4),posts(:,3));
            C = dDDdvydvz(X,t,posts(:,4),posts(:,1),posts(:,2)) + dDDdvydvz(X,t,posts(:,4),posts(:,1),posts(:,3)) + dDDdvydvz(X,t,posts(:,4),posts(:,2),posts(:,3));
            dd(8,5) = 1/4 * A - 1/8 * (3 * B - 2 * C);
            dd(5,8) = dd(8,5);
% %             daz
            A = dDdvydaz(X,t,posts(:,4),posts(:,1))*s1+dDdvydaz(X,t,posts(:,4),posts(:,2))*s2+dDdvydaz(X,t,posts(:,4),posts(:,3))*s3;
            B = dD2dvydaz(X,t,posts(:,4),posts(:,1)) + dD2dvydaz(X,t,posts(:,4),posts(:,2)) + dD2dvydaz(X,t,posts(:,4),posts(:,3));
            C = dDDdvydaz(X,t,posts(:,4),posts(:,1),posts(:,2)) + dDDdvydaz(X,t,posts(:,4),posts(:,1),posts(:,3)) + dDDdvydaz(X,t,posts(:,4),posts(:,2),posts(:,3));
            dd(9,5) = 1/4 * A - 1/8 * (3 * B - 2 * C);
            dd(5,9) = dd(9,5);
%             day
% %             day
            A = dDdayday(X,t,posts(:,4),posts(:,1))*s1+dDdayday(X,t,posts(:,4),posts(:,2))*s2+dDdayday(X,t,posts(:,4),posts(:,3))*s3;
            B = dD2dayday(X,t,posts(:,4),posts(:,1)) + dD2dayday(X,t,posts(:,4),posts(:,2)) + dD2dayday(X,t,posts(:,4),posts(:,3));
            C = dDDdayday(X,t,posts(:,4),posts(:,1),posts(:,2)) + dDDdayday(X,t,posts(:,4),posts(:,1),posts(:,3)) + dDDdayday(X,t,posts(:,4),posts(:,2),posts(:,3));
            dd(6,6) = 1/4 * A - 1/8 * (3 * B - 2 * C);
% %             dz
            A = dDdzday(X,t,posts(:,4),posts(:,1))*s1+dDdzday(X,t,posts(:,4),posts(:,2))*s2+dDdzday(X,t,posts(:,4),posts(:,3))*s3;
            B = dD2dzday(X,t,posts(:,4),posts(:,1)) + dD2dzday(X,t,posts(:,4),posts(:,2)) + dD2dzday(X,t,posts(:,4),posts(:,3));
            C = dDDdzday(X,t,posts(:,4),posts(:,1),posts(:,2)) + dDDdzday(X,t,posts(:,4),posts(:,1),posts(:,3)) + dDDdzday(X,t,posts(:,4),posts(:,2),posts(:,3));
            dd(7,6) = 1/4 * A - 1/8 * (3 * B - 2 * C);
            dd(6,7) = dd(7,6);    
% %             dvz
            A = dDdvzday(X,t,posts(:,4),posts(:,1))*s1+dDdvzday(X,t,posts(:,4),posts(:,2))*s2+dDdvzday(X,t,posts(:,4),posts(:,3))*s3;
            B = dD2dvzday(X,t,posts(:,4),posts(:,1)) + dD2dvzday(X,t,posts(:,4),posts(:,2)) + dD2dvzday(X,t,posts(:,4),posts(:,3));
            C = dDDdvzday(X,t,posts(:,4),posts(:,1),posts(:,2)) + dDDdvzday(X,t,posts(:,4),posts(:,1),posts(:,3)) + dDDdvzday(X,t,posts(:,4),posts(:,2),posts(:,3));
            dd(8,6) = 1/4 * A - 1/8 * (3 * B - 2 * C);
            dd(6,8) = dd(8,6);
% %             daz            
            A = dDdaydaz(X,t,posts(:,4),posts(:,1))*s1+dDdaydaz(X,t,posts(:,4),posts(:,2))*s2+dDdaydaz(X,t,posts(:,4),posts(:,3))*s3;
            B = dD2daydaz(X,t,posts(:,4),posts(:,1)) + dD2daydaz(X,t,posts(:,4),posts(:,2)) + dD2daydaz(X,t,posts(:,4),posts(:,3));
            C = dDDdaydaz(X,t,posts(:,4),posts(:,1),posts(:,2)) + dDDdaydaz(X,t,posts(:,4),posts(:,1),posts(:,3)) + dDDdaydaz(X,t,posts(:,4),posts(:,2),posts(:,3));
            dd(9,6) = 1/4 * A - 1/8 * (3 * B - 2 * C);
            dd(6,9) = dd(9,6);
%             dz            
% %             dz
            A = dDdzdz(X,t,posts(:,4),posts(:,1))*s1+dDdzdz(X,t,posts(:,4),posts(:,2))*s2+dDdzdz(X,t,posts(:,4),posts(:,3))*s3;
            B = dD2dzdz(X,t,posts(:,4),posts(:,1)) + dD2dzdz(X,t,posts(:,4),posts(:,2)) + dD2dzdz(X,t,posts(:,4),posts(:,3));
            C = dDDdzdz(X,t,posts(:,4),posts(:,1),posts(:,2)) + dDDdzdz(X,t,posts(:,4),posts(:,1),posts(:,3)) + dDDdzdz(X,t,posts(:,4),posts(:,2),posts(:,3));
            dd(7,7) = 1/4 * A - 1/8 * (3 * B - 2 * C);
% %             dvz
            A = dDdzdvz(X,t,posts(:,4),posts(:,1))*s1+dDdzdvz(X,t,posts(:,4),posts(:,2))*s2+dDdzdvz(X,t,posts(:,4),posts(:,3))*s3;
            B = dD2dzdvz(X,t,posts(:,4),posts(:,1)) + dD2dzdvz(X,t,posts(:,4),posts(:,2)) + dD2dzdvz(X,t,posts(:,4),posts(:,3));
            C = dDDdzdvz(X,t,posts(:,4),posts(:,1),posts(:,2)) + dDDdzdvz(X,t,posts(:,4),posts(:,1),posts(:,3)) + dDDdzdvz(X,t,posts(:,4),posts(:,2),posts(:,3));
            dd(8,7) = 1/4 * A - 1/8 * (3 * B - 2 * C);
            dd(7,8) = dd(8,7); 
% %             daz
            A = dDdzdaz(X,t,posts(:,4),posts(:,1))*s1+dDdzdaz(X,t,posts(:,4),posts(:,2))*s2+dDdzdaz(X,t,posts(:,4),posts(:,3))*s3;
            B = dD2dzdaz(X,t,posts(:,4),posts(:,1)) + dD2dzdaz(X,t,posts(:,4),posts(:,2)) + dD2dzdaz(X,t,posts(:,4),posts(:,3));
            C = dDDdzdaz(X,t,posts(:,4),posts(:,1),posts(:,2)) + dDDdzdaz(X,t,posts(:,4),posts(:,1),posts(:,3)) + dDDdzdaz(X,t,posts(:,4),posts(:,2),posts(:,3));
            dd(9,7) = 1/4 * A - 1/8 * (3 * B - 2 * C);
            dd(7,9) = dd(9,7);   
%             dvz            
% %             dvz
            A = dDdvzdvz(X,t,posts(:,4),posts(:,1))*s1+dDdvzdvz(X,t,posts(:,4),posts(:,2))*s2+dDdvzdvz(X,t,posts(:,4),posts(:,3))*s3;
            B = dD2dvzdvz(X,t,posts(:,4),posts(:,1)) + dD2dvzdvz(X,t,posts(:,4),posts(:,2)) + dD2dvzdvz(X,t,posts(:,4),posts(:,3));
            C = dDDdvzdvz(X,t,posts(:,4),posts(:,1),posts(:,2)) + dDDdvzdvz(X,t,posts(:,4),posts(:,1),posts(:,3)) + dDDdvzdvz(X,t,posts(:,4),posts(:,2),posts(:,3));
            dd(8,8) = 1/4 * A - 1/8 * (3 * B - 2 * C);
% %             daz
            A = dDdvzdaz(X,t,posts(:,4),posts(:,1))*s1+dDdvzdaz(X,t,posts(:,4),posts(:,2))*s2+dDdvzdaz(X,t,posts(:,4),posts(:,3))*s3;
            B = dD2dvzdaz(X,t,posts(:,4),posts(:,1)) + dD2dvzdaz(X,t,posts(:,4),posts(:,2)) + dD2dvzdaz(X,t,posts(:,4),posts(:,3));
            C = dDDdvzdaz(X,t,posts(:,4),posts(:,1),posts(:,2)) + dDDdvzdaz(X,t,posts(:,4),posts(:,1),posts(:,3)) + dDDdvzdaz(X,t,posts(:,4),posts(:,2),posts(:,3));
            dd(9,8) = 1/4 * A - 1/8 * (3 * B - 2 * C);
            dd(8,9) = dd(9,8); 
%             daz  
% %             daz
            A = dDdazdaz(X,t,posts(:,4),posts(:,1))*s1+dDdazdaz(X,t,posts(:,4),posts(:,2))*s2+dDdazdaz(X,t,posts(:,4),posts(:,3))*s3;
            B = dD2dazdaz(X,t,posts(:,4),posts(:,1)) + dD2dazdaz(X,t,posts(:,4),posts(:,2)) + dD2dazdaz(X,t,posts(:,4),posts(:,3));
            C = dDDdazdaz(X,t,posts(:,4),posts(:,1),posts(:,2)) + dDDdazdaz(X,t,posts(:,4),posts(:,1),posts(:,3)) + dDDdazdaz(X,t,posts(:,4),posts(:,2),posts(:,3));
            dd(9,9) = 1/4 * A - 1/8 * (3 * B - 2 * C);       
            
            
        case 3
            rd1 = toa(3) - toa(1);
            rd2 = toa(3) - toa(2);
        case 2
            rd1 = toa(2) - toa(1);
    end
end

