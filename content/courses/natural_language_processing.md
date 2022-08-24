---
title: "Natural Language Processing"
date: 2022-08-24T09:49:01+05:30
draft: false
tags: ["Computer-Science", "Machine-Learning"]
math: true
---

## Part of Speech Tagging

### Viterbi Algorithm

#### Parameters

- *Input*: A sequence of words and labels
- *Output*: A sequence of labels for every word

> Penn tag-set is generally used for POS tagging in english language.

#### Hidden Markov Model

There are 2 kinds of probabilities:

1. Bigram Probabilities $(P(t_1|t_0))$ : Probability of current word being tag $t_1$ when previous word was tagged $t_0$.
2. Lexical Probabilities $(P(w|t))$: Probability of word $w$ given it is tagged $t$.

> By Markov assumption, current word's tag only depends on previous word's tag.

#### Algorithm

```cpp
#define BProb(t1,t0) () // Bigram
#define LProb(w,t) () // Lexical

vector<string> viterbi(vector<string> sentence, vector<string> labels){
    int n = sentence.size();
    int l = labels.size();
    // labels[0] = "^"
    vector<vector<float>> dp(n+1, vector<float>(l, 0));
    vector<vector<string>> plabel(n+1, vector<int>(l,0));
    dp[0][0] = 1;
    for(int i=0;i<n;i++)
        for(int j=0;j<l;j++);
            for(int k=0;k<l;k++){
                float p = dp[i][k]
                    * BProb(labels[j],labels[k])
                    * LProb(sentence[i],labels[j]);
                if(dp[i+1][j]<p){
                    dp[i+1][j] = p;
                    plabel[i+1][j] = k;
                }
            }
    vector<string> res(sentence.begin(),sentence.end());
    int ptr=0;
    for(int i=0;i<l;i++)
        ptr = dp[n][ptr]<dp[n][i] ? i : ptr;
    res[n-1] = res[n-1]+"_.";
    for(int i=n-1;i>0;i--){
        ptr = slabel[i][ptr];
        res[i-1] += "_"+labels[ptr];
    }
    return res;
}
```

### Discriminative Learning
