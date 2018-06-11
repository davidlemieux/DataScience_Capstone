

library(shiny)
library(dplyr)
library(stringr)
library(stringdist)
library(textclean)
library(quanteda)
library(igraph)
library(Matrix)
library(doParallel)
library(foreach)
library(DT)



# Function 1, 2 and 3


g_1 <- readMM("unigram_network.mtx")
uni_name <- readLines("unigram_row_name.txt")
rownames(g_1) <- uni_name
colnames(g_1) <- uni_name

g_2 <- readMM("bigram_network.mtx")
bigram_name <- readLines("bigram_row_name.txt")
rownames(g_2) <- bigram_name
colnames(g_2) <- bigram_name



g_3<- readMM("trigram_network.mtx")
trigram_name <- readLines("trigram_row_name.txt")
rownames(g_3) <- trigram_name
colnames(g_3) <- trigram_name

g_4 <- readMM("quadrigram_network.mtx")
quadrigram_name <- readLines("quadrigram_row_name.txt")
rownames(g_4) <- quadrigram_name
colnames(g_4) <- quadrigram_name

remove(uni_name,bigram_name,trigram_name,quadrigram_name)




# Define server logic required to draw a histogram
shinyServer(function(input, output) {
        
        
        clean_text_DL <- function(my_string){
                my_string <- gsub(x=my_string,pattern = "<.*>|@", replacement = "")
                my_string <- gsub(x=my_string,"([_])\\1+","\\1", replacement="") 
                my_string <- quanteda::tokens(my_string,what="word",remove_numbers=T,
                                              remove_punct=T, remove_symbols=T,remove_hyphens=T)
                
                my_string <- quanteda::tokens_tolower(my_string)
                
                my_string <- tokens_wordstem(my_string,language = "english")
                
                my_cleaned_string  <- my_string
                return(my_cleaned_string)
        } 
        word_pred <- function(my_source,g_1,g_2,g_3,g_4){
                
                
                all_sub_source <- unlist(clean_text_DL(my_source))
                nb_words <- length(all_sub_source)
                all_pred <- data.frame()
                
                for (allpos in seq(1,min(nb_words,4))) {
                        my_sg <- eval(as.name(paste("g_",allpos,sep="")))
                        my_ss <- paste(all_sub_source[(nb_words-allpos+1):nb_words],collapse =" ")
                        if (length(which(rownames(my_sg)==my_ss))!=0){
                                my_pred <- sort(my_sg[my_ss,],decreasing = T)[1:4]
                                my_pred <- data.frame("words"=names(my_pred),"prob"=my_pred,row.names = seq(length(my_pred)))
                                
                                if (nrow(all_pred) ==0){
                                        all_pred <- my_pred    
                                } else{all_pred <- rbind(all_pred,my_pred)}
                                
                                
                        } 
                        
                if (nrow(all_pred)>0){
                        all_pred <- all_pred %>% group_by(words)%>% summarise("prob"=sum(prob)) %>%arrange(desc(prob))
                        all_pred <- all_pred[1:4,] 
                        }
                        
                }
               
                return(all_pred)
        }
        
        
        the_pred<- eventReactive(input$run,{word_pred(input$source,g_1,g_2,g_3,g_4)})
        output$prediction <- DT::renderDataTable({the_pred()})

})
  

