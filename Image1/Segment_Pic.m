function [Parts,Seg_Matrix] = Segment_Pic(Img_Ori)
[hei,wid] = size(Img_Ori);
Parts = 0;
Seg_Matrix  = [];
for i = 1:hei
    for j = 1:wid
        if Img_Ori(i,j)
            Parts = Parts + 1;
            [Matrix,Img_Ori]=RegionGrowing(Img_Ori,i,j);
            l = max([length(Seg_Matrix),length(Matrix)]);
            Seg_Matrix = [padarray(Seg_Matrix,[l-length(Seg_Matrix) 0],'post') padarray(Matrix,[l-length(Matrix) 0],'post')]; 
        end
    end
end
end

function [MaTrix,Img_New] = RegionGrowing(Img_Ori,x,y)
RegionGrowing_Matrix = [-1,-1;-1,0;-1,1;0,-1;0,1;1,-1;1,0;1,1];
Img_New = Img_Ori;
Pointer = 1;
Pointer_MT = 1;
Matrix_RG = zeros(1,2);
MaTrix = zeros(1,2);
[Matrix_RG(Pointer,1),Matrix_RG(Pointer,2)]=deal(x,y);
[MaTrix(Pointer_MT,1),MaTrix(Pointer_MT,2)]=deal(x,y);
while(Pointer)
    Img_New(x,y)=0;
    [x,y] = deal(Matrix_RG(Pointer,1),Matrix_RG(Pointer,2));
    Pointer = Pointer - 1;
    for i = 1:8
        if Img_New(x+RegionGrowing_Matrix(i,1),y+RegionGrowing_Matrix(i,2))
            Pointer = Pointer + 1;
            Pointer_MT = Pointer_MT + 1;
            [Matrix_RG(Pointer,1),Matrix_RG(Pointer,2)]=deal(x+RegionGrowing_Matrix(i,1),y+RegionGrowing_Matrix(i,2));
            [MaTrix(Pointer_MT,1),MaTrix(Pointer_MT,2)]=deal(x+RegionGrowing_Matrix(i,1),y+RegionGrowing_Matrix(i,2));
            Img_New(x+RegionGrowing_Matrix(i,1),y+RegionGrowing_Matrix(i,2)) = 0;
        end
    end
end    

end