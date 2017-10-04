%function [ output_args ] = Otsu( input_args )
%OTSU Summary of this function goes here
%   Detailed explanation goes here
%end

%Charact2_img_Gray = I;

function I = Otsu( Charact2_img_Gray )

NumPixel = zeros(1,256); 
st = 0;
nd = 0;
Img1 = Charact2_img_Gray;
Img2 = Charact2_img_Gray;
[height,width] = size(Charact2_img_Gray);
w = 0;

for i = 1:height  
    for j = 1: width  
        NumPixel(Charact2_img_Gray(i,j) + 1) = NumPixel(Charact2_img_Gray(i,j) + 1) + 1; 
    end
end 

ProbPixel = zeros(1,256);  
for i = 1:256  
    ProbPixel(i) = NumPixel(i) / (height * width * 1.0);  
end 

for i=2:256 
    if ProbPixel(i)~=0 
        st=i+1;
        break; 
    end 
end 

for i=256:-1:1 
    if ProbPixel(i)~=0
        nd=i-1;
        break;
    end 
end 

for t=st:nd
    qt1=0; 
    qt2=0;
    u1=0; 
    u2=0;
    for i=1:t 
        qt1=qt1+ProbPixel(i);
    end
    for i=1:t
        u1=u1+i*ProbPixel(i)/qt1;
    end
    for i=t+1:256
        qt2=qt2+ProbPixel(i);
    end
    for i=t+1:256
        u2=u2+i*ProbPixel(i)/qt2;
    end
    CHECK = qt1*qt2*((u1-u2).^2);
    if  CHECK > w
        TK = t; 
        w = CHECK ;
    end 
end 


 for i=1:height               
        for j=1:width
            tmp=Charact2_img_Gray(i,j);
            if(tmp>=TK)
                Img1(i,j)=255;
                Img2(i,j)=0;
            else
                Img1(i,j)=0;
                Img2(i,j)=255;
            end
        end
end
%figure,imshow(Img1);
%figure,imshow(Charact2_img_Gray);
%figure,imshow(Img2);
Charact2_img_Binary = Img1./255;
%figure,imshow(Charact2_img_Binary.*255);
I = Charact2_img_Binary;