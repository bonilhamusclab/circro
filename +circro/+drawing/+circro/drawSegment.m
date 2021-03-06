function drawSegment(startRadian, endRadian, innerR, outerR, color, alpha)
    
    radialSteps = linspace(startRadian, endRadian, 100);

    outerX = outerR * cos(radialSteps);
    outerY = outerR * sin(radialSteps);

    innerX = innerR * cos(radialSteps);
    innerY = innerR * sin(radialSteps);
    
    % flip inner rim
    innerX=flip(innerX,2);
    innerY=flip(innerY,2);

    X=[outerX innerX];
    Y=[outerY innerY];

    pol=fill(X,Y,'r');
    
    set(pol, 'FaceColor', color);
    set(pol, 'EdgeColor', 'k');
    set(pol, 'FaceAlpha', alpha);

end % drawSegment

