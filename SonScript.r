install.packages("tidyverse")
install.packages("cluster")
install.packages("factoextra")
install.packages("ggthemes") # gerekli olan paketlerin yüklenmesi
install.packages("ggplot2")
install.packages("FactoMineR")

library(tidyverse)
library(cluster)
library(ggthemes)
library(ggplot2)
library(factoextra)
library(FactoMineR)
tma<-theme_igray()
asil <- read.csv('winemag-data_first150k.csv') # Veri setinin değişkene atanma işlemi


asil[1] <- NULL
asil[2] <- NULL
asil[2] <- NULL       # Veri setinden kullanmak istediğim satırlar haricini siliyorum.
asil[4] <- NULL
asil[5] <- NULL
asil[6] <-  NULL

summary(asil) # Veri setinin değerlerinin özetini basmaktadır.


df <- na.omit(asil)            # NA, NULL veya anlamsız bulunan verilerin çıkarılma işlemini yapar.
df$points <- scale(df$points)  # Scale standartlaştırma işlemi yapılmaktadır.
df$price <- scale(df$price)	   # Veri seti içinde string olduğu için ayrı oldu.


library(factoextra) # factoextra adlı kütüphaneyi aktif edildi.

set.seed(123) # Random atanacak değerlerin tutarlı olması için yapılan işlemdir.


#fviz_nbclust(df, kmeans, method="wss") # k değerinin hangi değerlerde verimli olacağını hesaplanması için 
# Fakat hata alıyorum : Error: cannot allocate vector of size 70.2 Gb
# Bu yüzden veri setini 20000 binlik rastgele seçilen elemanlardan tekrar oluşturup yaptım.
# Bu nedenle değerler sizde farklı çıkabilir. Nedeni rastgele satırların seçilmesi ve yeterli ram miktarına sahip olmamam

df1 <- df[sample(nrow(df), 10000), ] # rastgele seçilen satırlar df1 değişkenine atanır.

fviz_nbclust(df1[,2:3], kmeans, method = 'wss') # Burada seçilen sütünların k değerinin hangi değerleri sağladığını göstermek
# için grafik çizmektedir.

set.seed(123)

km.res<-kmeans(df1[2:3], 2, nstart=25) # 2 değeri için k yakınlık değerleri ve kümeler belirlenir.
print("k=2 icin \n")
print(km.res) # Bastırılır.
k2 <- fviz_cluster(km.res, data=df1[,2:3])+ tma # Kümelenmiş olarak grafik bastırır.

# k = 5 değeri için ayrıca yaptım.

km.res1<-kmeans(df1[2:3], 5, nstart=25)
k5 <- fviz_cluster(km.res1, data=df1[,2:3])+ tma
print("k=5 icin \n" )
print(km.res) # Bastırılır.

#k=4 degeri icin de ayrica yaptim.
k4 <- fviz_cluster(km.res1, data=df1[,2:3])+ tma
print("k=4 icin \n")
      
print(km.res) # Bastırılır.



t2=c('US','Italy','France','Spain','Chile','Argentine','Other') 	# Ülkeri karakter dizisine aldım.
t3=c(62139,18784,14785,8160,5766,5587,22014)		                  # 150 bin değer üzerinden bulunan değer alıp karakter dizisine atadım.
pct <- round(t3/sum(t3)*100)	                                    # pct değişkenine yüzde değerlerini alabilmek için, her değerin toplamının 100 ile çarpımına böldüm. 
lbls <- paste(t2, pct)                                            # Ülkelerin isimleriyle pct değerlerini eşleştirdim.
lbls <- paste(lbls,"%",sep="")                                    # Her değerin başına yüzde işareti ve boşluksuz yazılmasını sağladım.
pie(t3,labels = lbls, col=rainbow(length(lbls)),main="Ülkelerin şarap üretimi")	


Puanlandirma.ve.Fiyat <- qplot(asil$country,asil$points,data=asil,geom=c("boxplot", "jitter"),xlab = "Ülkeler",ylab = "Şarap Puanlaması",main = "Şarap puanlaması ve üretildiği ülkeler") + theme(axis.title=element_text(face="bold", size="24",color="red"), legend.position="top")
