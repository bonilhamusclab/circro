function drawLinks(matrix,threshold,startRadian,radius)
    numberLinks=size(matrix,1);

    links=triu(matrix>threshold);%# this is a random list of connections
    [ind1,ind2]=ind2sub(size(links),find(links(:)));
    
    for i=1:size(ind1,1);
        if ind1(i)~=ind2(i)
            
           thetaInd1=  ( (startRadian + ( (ind1(i)-1) *(2*pi/numberLinks) ))...
               + (startRadian + ( (ind1(i)) *(2*pi/numberLinks) )) )/2;
           thetaInd2=  ( (startRadian + ( (ind2(i)-1) *(2*pi/numberLinks) ))...
               + (startRadian + ( (ind2(i)) *(2*pi/numberLinks) )) )/2;
                             
           if thetaInd1>thetaInd2
                largerTheta=thetaInd1;
                smallerTheta=thetaInd2;
            else
                largerTheta=thetaInd2;
                smallerTheta=thetaInd1;
            end

            if largerTheta-smallerTheta<pi

                arc=linspace(smallerTheta,largerTheta,3);
                interTheta=(arc(2));
            else
                tempTheta=smallerTheta+(2*pi);
                arc=linspace(largerTheta,tempTheta,3);
                interTheta=(arc(2));
            end
            
            x1 = radius * cos(thetaInd1);
            y1 = radius * sin(thetaInd1);
            
            x2 = radius * cos(thetaInd2);
            y2 = radius * sin(thetaInd2);

            distance= sqrt(( x2-x1 )^2  + ( y2-y1 )^2);

            if distance>=2*radius;
                elevation=radius/2;
            end

            if distance<2*radius
               elevation=radius-(distance/2);
            end

            xInter = elevation * (cos(interTheta)) ;
            yInter = elevation * (sin(interTheta)) ;
 
            a=[x1;xInter;x2]'; % xs
            b=[y1;yInter;y2]'; % ys

            xx = pi*(0:1:2); 

            yy=[a;b];

            pp = spline(xx,yy);
            yyy = ppval(pp, linspace(0,2*pi,100));
            plot(yyy(1,:),yyy(2,:),'color',[0.5 0.5 0.5],'linewidth',1.5*matrix(ind1(i),ind2(i)) ) %,yy(1,2:3),yy(2,2:3),'or'), axis equal

            %pause(0.8)
        end

    end
end