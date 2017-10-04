function I = Character_Relocate(Img_Ori,Seg_Matrix)

[hei,wid] = size(Img_Ori);
hnew = ceil(hei/2);
wnew = wid*2;
I = zeros(hnew,wnew);

for i = 1:hnew
    for j = 1:wnew
        I(i,j) = min(min(Img_Ori));
    end
end

matrix_x = Seg_Matrix(:,1);
matrix_y = Seg_Matrix(:,2);
matrix_y_next = Seg_Matrix(:,4);
min_x = min(matrix_x(matrix_x~=0));
max_y = max(matrix_y);
Distant = min(matrix_y_next(matrix_y_next~=0))-max(matrix_y);
num = sum(matrix_x~=0);

for i = 1:num
    I(matrix_x(i),matrix_y(i)) = Img_Ori(matrix_x(i),matrix_y(i));
end

[I,max_y] = Relocate(Img_Ori,I,Seg_Matrix(:,7),Seg_Matrix(:,8),min_x,max_y,Distant);
[I,max_y] = Relocate(Img_Ori,I,Seg_Matrix(:,3),Seg_Matrix(:,4),min_x,max_y,Distant);
[I,max_y] = Relocate(Img_Ori,I,Seg_Matrix(:,9),Seg_Matrix(:,10),min_x,max_y,Distant);
[I,max_y] = Relocate(Img_Ori,I,Seg_Matrix(:,5),Seg_Matrix(:,6),min_x,max_y,Distant);
[I,~] = Relocate(Img_Ori,I,Seg_Matrix(:,11),Seg_Matrix(:,12),min_x,max_y,Distant);


I = uint8(I);
end

function [I,New_maxy] = Relocate(Img_Ori,I,Matrix_1,Matrix_2,min_x,max_y,distant)
num = sum(Matrix_1~=0);
x_distant = 0;
if min(Matrix_1(Matrix_1~=0)) > min_x
    x_distant = min(Matrix_1(Matrix_1~=0)) - min_x;
end
Matrix_1_new = Matrix_1 - x_distant;
min_y = min(Matrix_2(Matrix_2~=0));
if min_y >= max_y+distant
    y_distant = min_y - max_y - distant;
    Matrix_2_new = Matrix_2 - y_distant;
else
    y_distant = max_y + distant - min_y;
    Matrix_2_new = Matrix_2 + y_distant;
end

New_maxy = max(Matrix_2_new);
for i = 1:num
    I(Matrix_1_new(i),Matrix_2_new(i)) = Img_Ori(Matrix_1(i),Matrix_2(i));
end

end