function output=fover2(zstack,centroidlist,zsize,intscale,overscale); 

[pixx,pixy,stackz] = size(zstack);

for i=1:stackz
    %colormap 'gray',imagesc(zstack(:,:,i));
    %hold on
    centers = centroidlist(:,1:2);
    centerx = centers(:,2);
    centery = centers(:,1);
    centers = [centerx, centery]
    peakimage = zeros(pixx,pixy);
    [clx,cly]=size(centers);
    for j = 1:clx
        peakimage((max(1,round(centers(j,1))-3)):(min(pixx,round(centers(j,1))+3)),(max(1,round(centers(j,2))-3)):(min(pixy,round(centers(j,2))+3))) = overscale;
    end
    peakimage = uint8(zstack(:,:,i)*intscale)+uint8(peakimage);
    colormap 'gray',imagesc(peakimage);
    pause
    %hold off
end
end
    
    