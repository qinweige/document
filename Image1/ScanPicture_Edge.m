function I = ScanPicture_Edge(Img_Ori)

[height,width]=size(Img_Ori);
I_X = zeros(height,width);
I_Y = zeros(height,width);
I = zeros(height,width);

for i = 2:height-1
    for j = 2:width-1
        if Img_Ori(i,j)~=Img_Ori(i+1,j)
            if Img_Ori(i,j)>Img_Ori(i+1,j)
                I_X(i,j) = Img_Ori(i,j);
            else
                I_X(i+1,j) = Img_Ori(i+1,j);
            end
        end
        if Img_Ori(i,j)~=Img_Ori(i,j+1)
            if Img_Ori(i,j)>Img_Ori(i,j+1)
                I_Y(i,j) = Img_Ori(i,j);
            else
                I_Y(i,j+1) = Img_Ori(i,j+1);
            end
        end
    end
end

% for i = 2:height-1
%     for j = 2:width-1
%         if I_X(i,j)==I_Y(i,j)
%             I(i,j)=I_X(i,j);
%         end      
%     end
% end
I = I_X+I_Y;
for i = 2:height-1
    for j = 2:width-1
                if I(i,j)==2
                    I(i,j)=1;
                end
    end
end
end