%% 基于WSNM的RNIPT算法
tic
clc;
clear;
close all;

%% setup parameters
lambdaL =8;
C=5;
p=0.9;
L1=8;
imgpath='..\FGLR-MCP代码公开\data\1\'; 
%%
imgDir = dir([imgpath '*.bmp']);
len = length(imgDir);
t1=clock;
for i=1:len
    picname=[imgpath  num2str(i),'.bmp'];
    I=imread(picname);%
    [m,n]=size(I);
    [~, ~, ch]=size(I);
    if ch==3
        I=rgb2gray(I); 
    end
    D(:,:,i)=I;
end
tenD=double(D);
[n1,n2,n3]=size(tenD);
n_1=max(n1,n2);%n(1)
n_2=min(n1,n2);%n(2)
patch_frames=L1;% temporal slide parameter
patch_num=n3/patch_frames;
for l=1:patch_num
    l
    for i=1:patch_frames
        temp(:,:,i)=tenD(:,:,patch_frames*(l-1)+i);
    end           
        T=C*sqrt(n1*n2);
        lambda4 =lambdaL / sqrt(min(n_1*patch_frames));
        mu =0.002;
[tenB, tenT,change] = WSNMSTIPT_FGLRMCP(temp, lambda4, mu,T,p); 
 for i=1:patch_frames
     tarImg=tenT(:,:,i);
     backImg=tenB(:,:,i);
     maxv = max(max(double(I)));
     E = uint8( mat2gray(tarImg)*maxv );
     A = uint8( mat2gray(backImg)*maxv );
     figure,imshow(E,[]);
 end 
t2=clock;
time_all = etime(t2,t1);
time_per_img = time_all/(128);
end
toc   