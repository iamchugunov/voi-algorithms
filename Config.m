function [config] = Config(cfg)
%% general parametrs
    config.c = 299792458;
    config.c_ns = config.c/1e9;
%% stations positions

    if nargin == 0
        R = 10e3; %% distance (radius)
        posts = [];
        hp = 15;
        alphap = [30 150 270]*pi/180;
        for i = 1:3
            posts(:,i) = [R * cos(alphap(i)); R * sin(alphap(i)); hp + normrnd(0, 5)];
        end
        posts(:,4) = [0;0;hp];
    %     posts = [-5e3 -5e3 5e3 5e3; -5e3 5e3 -5e3 5e3; 100 100 100 100];
        config.posts = posts;
        config.BLHref = [55.75361828302028; 37.62241947547497; 0];
        
        config.PostsBLH = [];
        for i = 1:4
            [config.PostsBLH(1,i),config.PostsBLH(2,i),config.PostsBLH(3,i)] = enu2geodetic(config.posts(1,i),config.posts(2,i),config.posts(3,i),config.BLHref(1),config.BLHref(2),config.BLHref(3),wgs84Ellipsoid);
        end
    else
        switch cfg
            case 'vor'
                PostsBLH(:,1) = [51.400773; 39.035690; 172.5];
                PostsBLH(:,2) = [51.535456; 39.286083; 119.0];
                PostsBLH(:,3) = [51.552025; 38.989821; 196.4];
                PostsBLH(:,4) = [51.504039; 39.108616; 124.4];
            case 'egypt1221'
                PostsBLH(:,1) = [30.097498; 30.962812; 198.3];
                PostsBLH(:,2) = [30.032239; 30.852883; 161.8];
                PostsBLH(:,3) = [30.192029; 30.857960; 108.8];
                PostsBLH(:,4) = [30.095264; 30.888045; 183.3];
            case 'arm21' % march
                PostsBLH(:,1) = [40.106768; 44.325031; 852.8];
                PostsBLH(:,2) = [40.221664; 44.518638; 1251.5];
                PostsBLH(:,3) = [40.356445; 44.270861; 1680.5];
                PostsBLH(:,4) = [40.204057; 44.378471; 1007.7];
            case 'z2107'
                PostsBLH(:,1) = [48.792618; 45.835995; 24.7];
                PostsBLH(:,2) = [48.703001; 45.767556; 15.9];
                PostsBLH(:,3) = [48.785485; 45.714025; 24.1];
                PostsBLH(:,4) = [48.758968; 45.770506; 21.1];
            case 'z2207'
                PostsBLH(:,1) = [48.792631; 45.835989; 23.2];
                PostsBLH(:,2) = [48.702968; 45.767606; 16.4];
                PostsBLH(:,3) = [48.785444; 45.713924; 21.7];
                PostsBLH(:,4) = [48.758983; 45.770486; 21.5];
            case 'z2307'
                PostsBLH(:,1) = [48.792601; 45.836086; 27.3];
                PostsBLH(:,2) = [48.702967; 45.767594; 24.2];
                PostsBLH(:,3) = [48.785481; 45.713999; 29.2];
                PostsBLH(:,4) = [48.759045; 45.770527; 26.2];
            case 'z2807'
                PostsBLH(:,1) = [48.698175; 46.316440; 31.6];
                PostsBLH(:,2) = [48.678927; 46.262791; 28.0];
                PostsBLH(:,3) = [48.719295; 46.260390; 22.9];
                PostsBLH(:,4) = [48.692336; 46.276395; 28.8];
            case 'z2907'
                PostsBLH(:,1) = [48.792629; 45.835988; 22.9];
                PostsBLH(:,2) = [48.702977; 45.767592; 15.7];
                PostsBLH(:,3) = [48.785345; 45.713752; 25.0];
                PostsBLH(:,4) = [48.759006; 45.770542; 19.8];
            case 'z1708'
                PostsBLH(:,1) = [48.696896; 46.313795; 23.8];
                PostsBLH(:,2) = [48.678962; 46.262833; 26.1];
                PostsBLH(:,3) = [48.715450; 46.276811; 23.9];
                PostsBLH(:,4) = [48.692480; 46.276309; 22.3];
            case 'iran22'
                PostsBLH(:,1) = [35.430865; 51.295750; 1207.0];
                PostsBLH(:,2) = [35.564486; 51.544807; 1088.9];
                PostsBLH(:,3) = [35.747997; 51.355299; 1460.0];
                PostsBLH(:,4) = [35.551633; 51.446939; 1045.8];
            case 'iran2809'
                PostsBLH(:,1) = [35.430876; 51.295711; 1204.6];
                PostsBLH(:,2) = [35.564474; 51.544826; 1087.7];
                PostsBLH(:,3) = [35.747985; 51.355318; 1458.9];
                PostsBLH(:,4) = [35.551633; 51.446950; 1043.1];
            case 'egypt1122'
                PostsBLH(:,1) = [30.097503; 30.962798; 197.1];
                PostsBLH(:,2) = [30.032244; 30.852901; 156.6];
                PostsBLH(:,3) = [30.190650; 30.858347; 115.7];
                PostsBLH(:,4) = [30.095271; 30.888044; 181.9];
        end
        BLHref = PostsBLH(:,4);
        BLHref(3) = 0;
        for i = 1:size(PostsBLH,2)
            [PostsENU(1,i), PostsENU(2,i), PostsENU(3,i)] = geodetic2enu(PostsBLH(1,i),PostsBLH(2,i),PostsBLH(3,i),BLHref(1),BLHref(2),BLHref(3),wgs84Ellipsoid);
        end
        config.BLHref = BLHref;
        config.PostsBLH = PostsBLH;
        config.posts = PostsENU;
    end

%% accuracy
    config.sigma_n_ns = 10;
    
end

