function [] = show_track3D(track, config)
    plot3(track.crd(1,:)/1000,track.crd(2,:)/1000,track.crd(3,:)/1000,'.-')
    hold on
    text(track.crd(1,1)/1000,track.crd(2,1)/1000,track.crd(3,1)/1000,num2str(track.id))
end

