clear
fid=fopen('charact1.txt','r');
data_Ori = textscan(fid,'%s');
fclose(fid);
Charact1_Img_Char = cell2mat(data_Ori{1,1});
Charact1_Img = uint8(Charact1_Img_Char);

%subplot(1,2,1)
%imshow(uint8(Charact1_Img))
