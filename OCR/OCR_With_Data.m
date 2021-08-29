clc; clear;

str={'a', 'b', 'c', 'ç', 'd', 'e', 'f', 'g', 'h', 'k', 'l', 'm', 'n', 'o', ...
    'r', 's', 'þ', 't', 'u', 'v', 'y', 'z' 'B' 'E' 'F' 'P' 'Y'};

word=[ ]; word2=[]; comp=[]; empty=[]; leng=[]; grtleng=[]; ornek=[]; ornek2=[]; leng=[];

platon=imread('Platon.jpeg');
gray=rgb2gray(platon);
thresh=graythresh(gray);
BW=~im2bw(gray, thresh);
%T = adaptthresh(gray, 0.8);
%BW = ~imbinarize(gray,T);
%BW=adaptive(gray);
bw=bwareaopen(BW,40);
figure
imshow(bw);
re=bw;

fid=fopen('text.txt', 'wt');

load templates
global templates

while 1
    [fl, re]=lines(re);
    imgn=fl;
    cc=bwconncomp(imgn,4);

    for ob=1:cc.NumObjects
        grain = false(size(imgn));
        grain(cc.PixelIdxList{ob}) = true;
        [fr,fc] = find(grain==1);
        n1=grain(min(fr):max(fr),min(fc):max(fc));  
        img_r=imresize(n1,[87 50]);
        for ii=1:278
            sem=corr2(img_r,templates{1,ii});
            comp=[comp sem];
        end
        for iii=2:length(comp)
            for jjj=1:iii-1
                if comp(jjj)==comp(iii)
                    if comp(jjj)<=0 || comp(iii)<=0
                        break
                    end
                    comp(iii)=-1;
                end
            end
        end
    
        empty=[empty find(comp==max(comp))];
        comp=[];
    
    end
    new_img=imfill(imgn, 'holes');

    bwprm=bwperim(new_img);
        
    stats = struct2table(regionprops(bwprm,'PixelList'));
    
    for no=1:height(stats)-1
        dist = pdist2(stats.PixelList{no},stats.PixelList{no+1});
        [dmin,idx] = min(dist(:));
        leng=[leng dmin];
    end
    for number=1:length(leng)
        
        if leng(number)>11
            grtleng=[grtleng number];
        end
    end
    %ornek2=[ornek2 grtleng];
    for j=1:length(empty)
        if empty(j)>=1 && empty(j)<=31
            word=[word str{1,1}];
        elseif empty(j)>31 && empty(j)<=36
            word=[word str{1,2}];
        elseif empty(j)>36 && empty(j)<=37
            word=[word str{1,3}]; 
        elseif empty(j)>37 && empty(j)<=38
            word=[word str{1,4}];
        elseif empty(j)>38 && empty(j)<=49
            word=[word str{1,5}];
        elseif empty(j)>49 && empty(j)<=86
            word=[word str{1,6}];
        elseif empty(j)>86 && empty(j)<=89
            word=[word str{1,7}]; 
        elseif empty(j)>89 && empty(j)<=103
            word=[word str{1,8}];
        elseif empty(j)>103 && empty(j)<=104
            word=[word str{1,9}];
        elseif empty(j)>104 && empty(j)<=114
            word=[word str{1,10}];
        elseif empty(j)>114 && empty(j)<=135
            word=[word str{1,11}]; 
        elseif empty(j)>135 && empty(j)<=152
            word=[word str{1,12}];
        elseif empty(j)>152 && empty(j)<=180
            word=[word str{1,13}];
        elseif empty(j)>180 && empty(j)<=187
            word=[word str{1,14}];
        elseif empty(j)>187 && empty(j)<=205
            word=[word str{1,15}]; 
        elseif empty(j)>205 && empty(j)<=220
            word=[word str{1,16}];
        elseif empty(j)>220 && empty(j)<=226
            word=[word str{1,17}];
        elseif empty(j)>226 && empty(j)<=236
            word=[word str{1,18}];
        elseif empty(j)>236 && empty(j)<=260
            word=[word str{1,19}]; 
        elseif empty(j)>260 && empty(j)<=265
            word=[word str{1,20}];
        elseif empty(j)>265 && empty(j)<=270
            word=[word str{1,21}];
        elseif empty(j)>270 && empty(j)<=273
            word=[word str{1,22}];
        elseif empty(j)>273 && empty(j)<=274
            word=[word str{1,23}]; 
        elseif empty(j)>274 && empty(j)<=275
            word=[word str{1,24}];
        elseif empty(j)>275 && empty(j)<=276
            word=[word str{1,25}];
        elseif empty(j)>276 && empty(j)<=277
            word=[word str{1,26}];
        elseif empty(j)>277 && empty(j)<=278
            word=[word str{1,27}];
        end
    end

    for num=1:length(word)
        word2=[word2 word(num)];
        
        for num2=1:length(grtleng)
       
            if num==grtleng(num2)
            word2=[word2 ' ']; 
            end
        end
    end
    
    fprintf(fid,'%s\n',word2);
    
    empty=[]; word=[]; leng=[]; grtleng=[]; word2=[];
    
    if isempty(re) 
       break
    end 
end

fclose(fid);
winopen('text.txt')