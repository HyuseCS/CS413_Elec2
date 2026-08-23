> intersect<-function (x, y){
y<-as.vector(y)
output<-unique(y[match(as.vector(x), y, 0L)])
return(output)}
