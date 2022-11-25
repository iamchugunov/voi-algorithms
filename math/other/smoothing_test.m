function [] = smoothing_test(poits, config)
    X = zeros(3,length(poits));
    t = zeros(length(poits));
    k = 0;
    for i = 1:length(poits)
        if poits(i).crd_valid
            k = k + 1;
            X(:,k) = poits(i).est_crd;
            t(k) = poits(i).Frame;
        end
    end
    X = X(:,1:k);
    t = t(1:k);
%     plot3(X(1,:)/1000,X(2,:)/1000,X(3,:)/1000,'.')
    
    a = 0.9;
    Xf = X;
    for i = 2:length(t)
        Xf(:,i) = (1 - a) * X(:,i) + a * Xf(:,i-1);
    end
    
    figure
    subplot(131)
    plot(t,X(1,:),'.-r')
    hold on
    plot(t,Xf(1,:),'.-b')
    grid on
    subplot(132)
    plot(t,X(2,:),'.-r')
    hold on
    plot(t,Xf(2,:),'.-b')
    grid on
    subplot(133)
    plot(t,X(3,:),'.-r')
    hold on
    plot(t,Xf(3,:),'.-b')
    grid on
    figure
    show_posts2D
    show_primary_points2D(poits)
    plot(Xf(1,:)/1000,Xf(2,:)/1000,'b.-')
end

