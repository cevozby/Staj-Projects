clc; clear;

a=imread('characters\a.bmp'); b=imread('characters\b.bmp'); c=imread('characters\c.bmp');
c2=imread('characters\ç.bmp'); d=imread('characters\d.bmp'); e=imread('characters\e.bmp');
f=imread('characters\f.bmp'); g=imread('characters\g.bmp'); h=imread('characters\h.bmp'); 
i2=imread('characters\ý.bmp'); j=imread('characters\j.bmp'); k=imread('characters\k.bmp'); 
l=imread('characters\l.bmp'); m=imread('characters\m.bmp'); n=imread('characters\n.bmp'); 
o=imread('characters\o.bmp'); p=imread('characters\p.bmp'); r=imread('characters\r.bmp'); 
s=imread('characters\s.bmp'); s2=imread('characters\þ.bmp'); t=imread('characters\t.bmp'); 
u=imread('characters\u.bmp'); v=imread('characters\v.bmp'); y=imread('characters\y.bmp'); 
z=imread('characters\z.bmp');

B=imread('characters\bb.bmp'); E=imread('characters\be.bmp'); F=imread('characters\bf.bmp');
P=imread('characters\bp.bmp'); Y=imread('characters\by.bmp');

a=im2bw(a); b=im2bw(b); c=im2bw(c); c2=im2bw(c2); d=im2bw(d);
e=im2bw(e); f=im2bw(f); g=im2bw(g); h=im2bw(h); i2=im2bw(i2);
j=im2bw(j); k=im2bw(k); l=im2bw(l); m=im2bw(m); n=im2bw(n);
o=im2bw(o); p=im2bw(p); r=im2bw(r); s=im2bw(s); s2=im2bw(s2);
t=im2bw(t); u=im2bw(u); v=im2bw(v); y=im2bw(y); z=im2bw(z);

B=im2bw(B); E=im2bw(E); F=im2bw(F); P=im2bw(P); Y=im2bw(Y);

letter=[a b c c2 d e f g h i2 j k l m n o p r s s2 t u v y z B E F P Y];

str={'a', 'b', 'c', 'ç', 'd', 'e', 'f', 'g', 'h', 'ý', 'j', 'k', 'l', 'm', 'n', 'o', ...
    'p', 'r', 's', 'þ', 't', 'u', 'v', 'y', 'z' 'B' 'E' 'F' 'P' 'Y'};

templates=mat2cell(letter, 87,[50 50 50 50 50 50 50 50 50 50 ...
    50 50 50 50 50 50 50 50 50 50 50 50 50 50 50 50 50 50 50 50 ]);

word=[ ]; word2=[]; comp=[]; empty=[]; leng=[]; grtleng=[];

platon=imread('Platon.jpeg');
gray=rgb2gray(platon);
bw=~im2bw(gray);
bw=bwareaopen(bw,30);
figure
imshow(bw);
re=bw;

fid=fopen('text.txt', 'wt');

while 1
    [fl, re]=lines(re);
    imgn=fl;
    cc=bwconncomp(imgn,4);

    for ob=1:cc.NumObjects
        grain = false(size(imgn));
        grain(cc.PixelIdxList{ob}) = true;
        [r,c] = find(grain==1);
        n1=grain(min(r):max(r),min(c):max(c));  
        img_r=imresize(n1,[87 50]);
        
        for ii=1:30
            sem=corr2(img_r,templates{1,ii});
            comp=[comp sem];
        end
        
        empty=[empty find(comp==max(comp))];
        comp=[];
    
    end
    
    for no=1:cc.NumObjects
        
        if no==cc.NumObjects
            break
        end
        
        bwprm=bwperim(imgn);
    
        stats = struct2table(regionprops(bwprm,'PixelList'));
        dist = pdist2(stats.PixelList{no},stats.PixelList{no+1});
        [dmin,idx] = min(dist(:));
        
        if dmin>=3
            leng=[leng dmin];
        end
        
    end
    
    for number=1:length(leng)
        
        if leng(number)>11
        grtleng=[grtleng number];
        end
    end
    
    for j=1:length(empty)
        if empty(j)==1
            word=[word str{1,1}];
        elseif empty(j)==2
            word=[word str{1,2}];
        elseif empty(j)==3
            word=[word str{1,3}]; 
        elseif empty(j)==4
            word=[word str{1,4}];
        elseif empty(j)==5
            word=[word str{1,5}];
        elseif empty(j)==6
            word=[word str{1,6}];
        elseif empty(j)==7
            word=[word str{1,7}]; 
        elseif empty(j)==8
            word=[word str{1,8}];
        elseif empty(j)==9
            word=[word str{1,9}];
        elseif empty(j)==10
            word=[word str{1,10}];
        elseif empty(j)==11
            word=[word str{1,11}]; 
        elseif empty(j)==12
            word=[word str{1,12}];
        elseif empty(j)==13
            word=[word str{1,13}];
        elseif empty(j)==14
            word=[word str{1,14}];
        elseif empty(j)==15
            word=[word str{1,15}]; 
        elseif empty(j)==16
            word=[word str{1,16}];
        elseif empty(j)==17
            word=[word str{1,17}];
        elseif empty(j)==18
            word=[word str{1,18}];
        elseif empty(j)==19
            word=[word str{1,19}]; 
        elseif empty(j)==20
            word=[word str{1,20}];
        elseif empty(j)==21
            word=[word str{1,21}];
        elseif empty(j)==22
            word=[word str{1,22}];
        elseif empty(j)==23
            word=[word str{1,23}]; 
        elseif empty(j)==24
            word=[word str{1,24}];
        elseif empty(j)==25
            word=[word str{1,25}];
        elseif empty(j)==26
            word=[word str{1,26}];
        elseif empty(j)==27
            word=[word str{1,27}];
        elseif empty(j)==28
            word=[word str{1,28}]; 
        elseif empty(j)==29
            word=[word str{1,29}];
        elseif empty(j)==30
            word=[word str{1,30}];
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