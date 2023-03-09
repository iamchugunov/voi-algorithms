function [] = show_track2D(track)
    plot(track.crd(1,:)/1000,track.crd(2,:)/1000,'k-')
    hold on
    text(track.crd(1,1)/1000,track.crd(2,1)/1000,num2str(track.id))
end

