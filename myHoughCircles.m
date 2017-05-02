function [HoughCircles] = myHoughCircles(Image, minCircleSize, maxCircleSize, detectionTreshold)
    
    figure(1)
    imshow(Image)
    
    I = im2bw(Image);
    [Bw, treshold] = edge(I, 'sobel');
    fudgeFactor = 0.5;
    Bws = edge(I, 'sobel', treshold * fudgeFactor);
    figure(2)
    imshow(Bws)
    
    figure(1)
    hold on;
    display('press enter to process');
    pause
    [h,l] = size(Bws);
    acc = zeros(h,l,100);
    res = double(Bws);
    
    display('processing...')
    for i = 1:h
        for j = 1:l
           if res(i,j) == 1
               for k = minCircleSize:maxCircleSize
                   for a = 1:2:360
                       x = i + k * cosd(a);
                       y = j + k * sind(a);
                       if x>1 && y>1 && x<=h &&y<=l
                           acc(round(x),round(y),k)=acc(round(x),round(y),k)+1;
                       end
                   end
               end
           end
        end   
    end
    exit = 1;

    figure(1)
    i = 1;
    while (exit == 1)
        [maxA,ind] = max(acc(:));
        [m,n,o] = ind2sub(size(acc),ind);
        acc(m,n,o) = 0;
        if(maxA > detectionTreshold)
            if (o > 5)
                viscircles([n,m],o);
                hold on;
                plot(n, m, '*');
                HoughCircles(i, :) = [n m o];
                i = i + 1;
            end
        else
            exit=0;
        end
    end
end
