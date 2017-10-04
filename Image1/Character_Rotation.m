function I = Character_Rotation(Img_Ori,Part,Seg_Matrix,angle,countclock)

matrix_x = Seg_Matrix(:,Part*2-1);
matrix_y = Seg_Matrix(:,Part*2);
num = sum(matrix_x~=0);
I = Img_Ori;

[hei,wid] = size(Img_Ori);
alpha = pi/angle;
XZImg = double(Img_Ori);
min_x = min(matrix_x(matrix_x~=0));
min_y = min(matrix_y(matrix_y~=0));
max_x = max(matrix_x);
max_y = max(matrix_y);
wnew = (max_x-min_x)*sin(alpha)+(max_y-min_y)*cos(alpha);
hnew = (max_x-min_x)*cos(alpha)+(max_y-min_y)*sin(alpha);
[Xc,Yc] = deal((max_x+min_x)/2,(max_y+min_y)/2);
if countclock
    T = [cos(alpha),-sin(alpha);sin(alpha),cos(alpha)];
else
    T = [cos(alpha),sin(alpha);-sin(alpha),cos(alpha)];
end

for i = 1:num
    I(matrix_x(i),matrix_y(i)) = min(min(Img_Ori));
end

for u = ceil(Xc-hnew/2):ceil(Xc+hnew/2)
    for v = ceil(Yc-wnew/2):ceil(Yc+wnew/2)
        abc = ([u,v]-[Xc,Yc])*T+[Xc,Yc]; 
        x = abc(1);
        y = abc(2);
        if x>1&&x<hei&&y>1&&y<wid
            x_low = floor(x);
            x_up = ceil(x);
            y_low = floor(y);
            y_up = ceil(y);
            p1 = XZImg(x_low,y_low);
            p2 = XZImg(x_up,y_low);
            p3 = XZImg(x_low,y_low);
            p4 = XZImg(x_up,y_up);
            s = x-x_low;
            t = y-y_low;
            I(u,v) = (1-s)*(1-t)*p1+(1-s)*t*p3+(1-t)*s*p2+s*t*p4;
        end
    end
end

end
