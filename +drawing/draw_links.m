function draw_links(matrix,threshold,start_radian,radius)
    number_links=size(matrix,1);

    links=triu(matrix>threshold);%# this is a random list of connections
    [ind1,ind2]=ind2sub(size(links),find(links(:)));
    
    for i=1:size(ind1,1);
        if ind1(i)~=ind2(i)
            
           theta_ind1=  ( (start_radian + ( (ind1(i)-1) *(2*pi/number_links) ))...
               + (start_radian + ( (ind1(i)) *(2*pi/number_links) )) )/2;
           theta_ind2=  ( (start_radian + ( (ind2(i)-1) *(2*pi/number_links) ))...
               + (start_radian + ( (ind2(i)) *(2*pi/number_links) )) )/2;
                             
           if theta_ind1>theta_ind2
                larger_theta=theta_ind1;
                smaller_theta=theta_ind2;
            else
                larger_theta=theta_ind2;
                smaller_theta=theta_ind1;
            end

            if larger_theta-smaller_theta<pi

                arc=linspace(smaller_theta,larger_theta,3);
                inter_theta=(arc(2));
            else
                temp_theta=smaller_theta+(2*pi);
                arc=linspace(larger_theta,temp_theta,3);
                inter_theta=(arc(2));
            end
            
            x_1 = radius * cos(theta_ind1);
            y_1 = radius * sin(theta_ind1);
            
            x_2 = radius * cos(theta_ind2);
            y_2 = radius * sin(theta_ind2);

            distance= sqrt(( x_2-x_1 )^2  + ( y_2-y_1 )^2);

            if distance>=2*radius;
                elevation=radius/2;
            end

            if distance<2*radius
               elevation=radius-(distance/2);
            end

            x_inter = elevation * (cos(inter_theta)) ;
            y_inter = elevation * (sin(inter_theta)) ;
 
            a=[x_1;x_inter;x_2]'; % xs
            b=[y_1;y_inter;y_2]'; % ys

            xx = pi*(0:1:2); 

            yy=[a;b];

            pp = spline(xx,yy);
            yyy = ppval(pp, linspace(0,2*pi,100));
            plot(yyy(1,:),yyy(2,:),'color',[0.5 0.5 0.5],'linewidth',1.5*matrix(ind1(i),ind2(i)) ) %,yy(1,2:3),yy(2,2:3),'or'), axis equal

            %pause(0.8)
        end

    end
end