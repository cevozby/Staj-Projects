function adp_img=adaptive(imgg)

%I=imread('Platon2.jpg');
%I=rgb2gray(I);
%figure
%imshow(I);
I=medfilt2(imgg);
%H=fspecial('gaussian');
%I=imfilter(I,H,'replicate');
%figure
%imshow(I);
%T = adaptthresh(I, 0.79);
%BW = ~imbinarize(I,T);
%bw=~im2bw(I);
%crp=imcrop(I,[0 0 80 50]);
%imshow(crp)
%thresh2=graythresh(I);
%bw=~im2bw(I, thresh);
sizee=size(I);
bw=zeros(sizee);
%matris=bw(51:100, 81:160);
thresh=[];
n=[]; adp_img=[];
emp=[]; b=[];
for y=1:50:sizee(1)
    for x=1:320:sizee(2)
        %if y>1 && x==1
        %    continue
        %end
        img=imcrop(I,[x y 319 49]);
        thresh=graythresh(img);
        emp=[emp thresh];
        if thresh>0.81
            thresh=0.5;
        end
        binary=~im2bw(img, thresh);
        %bw=[bw(y:y+49, x:x+79)+binary];
        n=[n binary];
        
        %figure
        %imshow(thresh);
    end
    %figure
    %imshow(n);
    adp_img=vertcat(adp_img,n);
    b=vertcat(b,emp);
    n=[]; emp=[];
end
%a=bwareaopen(a,400);
%figure
%imshow(a);