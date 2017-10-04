clear;
clc;

INPUT1
BiImage = Otsu(Charact1_Img);
Edge = ScanPicture_Edge(BiImage);
[Parts,Seg_Matrix] = Segment_Pic(BiImage);

Rotation_Img_Clockwise = Charact1_Img;
for i = 1:3
Rotation_Img_Clockwise = Character_Rotation(Rotation_Img_Clockwise,i,Seg_Matrix,2,0);
end
Rotation_Img_CountClockwise = Charact1_Img;
for i = 1:3
Rotation_Img_CountClockwise = Character_Rotation(Rotation_Img_CountClockwise,i,Seg_Matrix,6,1);
end
I1 = ScanPicture_Skeleton(BiImage);
Img_New = Character_Relocate(Charact1_Img,Seg_Matrix);

subplot(2,4,1),imshow(Charact1_Img);
subplot(2,4,2),imshow(BiImage.*255);
subplot(2,4,3),imshow(Edge);
subplot(2,4,4),imshow(Rotation_Img_Clockwise);
subplot(2,4,5),imshow(Rotation_Img_CountClockwise);
subplot(2,4,6),imshow(I1.*255);
subplot(2,4,7),imshow(Img_New);