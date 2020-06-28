function push_to_g(url,title)
{
  window.open("https://plusone.google.com/_/+1/confirm?url="+encodeURIComponent(url));
}
function push_to_f(url,title)
{
  window.open("http://www.facebook.com/sharer.php?u="+encodeURIComponent(url)+"&t="+encodeURIComponent(title));
}

function push_to_p(url,title)
{
  window.open('http://www.plurk.com/?qualifier=shares&status='+encodeURIComponent(url)+' '+encodeURIComponent('('+title+')'));
}

function push_to_t(url,title)
{
  window.open("http://twitter.com/?status="+encodeURIComponent(title)+" ("+encodeURIComponent(url)+") ");
}
