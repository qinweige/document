function Img = ScanPicture_Skeleton(Img)
[height,width]=size(Img);
neighbor = [-1,0;-1,1;0,1;1,1;1,0;1,-1;0,-1;-1,-1;-1,0];
num_1 = 1;
num_2 = 1;
Judge = 1;
Img = double(Img);

while Judge
    Img_Ori = Img;
    Delete_Pixel_1 = zeros(1,2);
    Delete_Pixel_2 = zeros(1,2);
    for i = 1:height
        for j = 1:width
            sum_neighbor = 0;
            sum_Change = 0;
            if Img(i,j)
                for u = 1:8
                    m = u+1;
                    sum_neighbor = sum_neighbor + Img(i+neighbor(u,1),j+neighbor(u,2));
                    if Img(i+neighbor(m,1),j+neighbor(m,2))-Img(i+neighbor(u,1),j+neighbor(u,2))==1
                        sum_Change = sum_Change+1;
                    end
                end
                    Judge_1 = Img(i+neighbor(1,1),j+neighbor(1,2))*...
                        Img(i+neighbor(3,1),j+neighbor(3,2))*...
                        Img(i+neighbor(5,1),j+neighbor(5,2));
                    Judge_2 = Img(i+neighbor(3,1),j+neighbor(3,2))*...
                        Img(i+neighbor(5,1),j+neighbor(5,2))*...
                        Img(i+neighbor(7,1),j+neighbor(7,2));
                    if sum_neighbor<=6&&sum_neighbor>=2&&...
                            sum_Change==1&&Judge_1==0&&Judge_2==0
                        Delete_Pixel_1(num_1,1)=i;
                        Delete_Pixel_1(num_1,2)=j;
                        num_1 = num_1+1;
                    end
            end
        end
    end
    
    for i =1:num_1-1
        Img(Delete_Pixel_1(i,1),Delete_Pixel_1(i,2)) = 0;
    end
    
    for i = 1:height
        for j = 1:width
            sum_neighbor = 0;
            sum_Change = 0;
            if Img(i,j)
                for u = 1:8
                    m = u+1;
                    sum_neighbor = sum_neighbor + Img(i+neighbor(u,1),j+neighbor(u,2));
                    if Img(i+neighbor(m,1),j+neighbor(m,2))-Img(i+neighbor(u,1),j+neighbor(u,2))==1
                        sum_Change = sum_Change+1;
                    end
                end
                    Judge_3 = Img(i+neighbor(1,1),j+neighbor(1,2))*...
                        Img(i+neighbor(3,1),j+neighbor(3,2))*...
                        Img(i+neighbor(7,1),j+neighbor(7,2));
                    Judge_4 = Img(i+neighbor(1,1),j+neighbor(1,2))*...
                        Img(i+neighbor(5,1),j+neighbor(5,2))*...
                        Img(i+neighbor(7,1),j+neighbor(7,2));
                    if sum_neighbor<=6&&sum_neighbor>=2&&...
                            sum_Change==1&&Judge_3==0&&Judge_4==0                     
                        Delete_Pixel_2(num_2,1)=i;
                        Delete_Pixel_2(num_2,2)=j;
                        num_2 = num_2+1;
                    end
            end
        end
    end
    

    for i =1:num_2-1
        Img(Delete_Pixel_2(i,1),Delete_Pixel_2(i,2)) = 0;
    end
    num_1=1;
    num_2=1;
    
    if Img_Ori == Img
        Judge = 0;
    end
end
Img = uint8(Img);
end