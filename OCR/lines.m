function [fl, re]=lines(im_texto)
im_texto=clip(im_texto);
num_filas=size(im_texto,1);
for s=1:num_filas
    if sum(im_texto(s,:))==0
        nm=im_texto(1:s-1, :); 
        rm=im_texto(s:end, :);
        fl = clip(nm);
        re=clip(rm);
        break
    else
        fl=im_texto;
        re=[ ];
    end
end