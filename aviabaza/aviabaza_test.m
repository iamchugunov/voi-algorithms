%%
P(:,1) = [0; 0; 0];
P(:,2) = [200; 0; 0];

X(:,1) = [-10e3; 10e3; 1e3];
X(:,2) = [100; 7e3; 1e3];
X(:,3) = [10e3; 10e3; 1e3];

figure
daspect([1 1 1])
hold on
grid minor
plot3(P(1,:),P(2,:),P(3,:),'o')
plot3(X(1,:),X(2,:),X(3,:),'v')
%%
sigma_h = 10;
sigma_r = 0.1;

N = 1000;
R(1,1) = norm(X(:,1) - P(:,1));
R(2,1) = norm(X(:,1) - P(:,2));
R(3,1) = norm(X(:,2) - P(:,1));
R(4,1) = norm(X(:,2) - P(:,2));
R(5,1) = norm(X(:,3) - P(:,1));
R(6,1) = norm(X(:,3) - P(:,2));
R(7,1) = norm(X(:,1) - X(:,2));
R(8,1) = norm(X(:,1) - X(:,3));
R(9,1) = norm(X(:,2) - X(:,3));
R(10,1) = X(3,1);
R(11,1) = X(3,2);
R(12,1) = X(3,3);

for i = 1:N
    y(:,i) = R + [normrnd(0, sigma_r, [9, 1]); normrnd(0, sigma_h, [3, 1])];
end

X0 = [X(:,1); X(:,2); X(:,3)];
X0 = [-5e3;5e3;1e3;0;5e3;1e3;5e3;5e3;1e3];
for i = 1:N
    [X_oc1(:,i)] = one_post_solver(y([1 2 10],i), P, sigma_r, sigma_h, [0; 10e3; 1e3]);
    [X_oc2(:,i)] = one_post_solver(y([3 4 11],i), P, sigma_r, sigma_h, [0; 10e3; 1e3]);
    [X_oc3(:,i)] = one_post_solver(y([5 6 12],i), P, sigma_r, sigma_h, [0; 10e3; 1e3]);
    X_oc(:,i) = all_post_solver(y(:,i), P, sigma_r, sigma_h, X0);
end
[std(X_oc1')' std(X_oc2')' std(X_oc3')']
[std(X_oc')']

plot3(X_oc1(1,:),X_oc1(2,:),X_oc1(3,:),'.')
plot3(X_oc2(1,:),X_oc2(2,:),X_oc2(3,:),'.')
plot3(X_oc3(1,:),X_oc3(2,:),X_oc3(3,:),'.')

plot3(X_oc(1,:),X_oc(2,:),X_oc(3,:),'x')
plot3(X_oc(4,:),X_oc(5,:),X_oc(6,:),'x')
plot3(X_oc(7,:),X_oc(8,:),X_oc(9,:),'x')