---
title: "Natural Language Processing"
date: 2022-08-24T09:49:01+05:30
draft: false
tags: ["Computer-Science", "Machine-Learning"]
math: true
---

## Part of Speech Tagging

### HMM-based Tagging

#### Parameters

- *Input*: A sequence of words and labels
- *Output*: A sequence of labels for every word

> Penn tag-set is generally used for POS tagging in english language.

#### Hidden Markov Model

There are 2 kinds of probabilities:

1. Bigram Probabilities $(P(t_1|t_0))$ : Probability of current word being tag $t_1$ when previous word was tagged $t_0$.
2. Lexical Probabilities $(P(w|t))$: Probability of word $w$ given it is tagged $t$.

> By Markov assumption, current word's tag only depends on previous word's tag.

#### Viterbi Algorithm

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

HMM based POS tagging cannot handle "free word order" and "agglutination" well.

#### Feature Engineering

1. Word-based features
   - $f_{21}$: Dictionary index of the current word
   - $f_{22}$: Dictionary index of the previous word
   - $f_{23}$: Dictionary index of the next word
2. Part of Speech tag-based features
   - $f_{24}$: Index of POS of previous word
3. Morphology-based features
   - $f_{25}$: does the current word have a noun suffix like 's', 'es', 'ies', etc.
   - $f_{26}$: does the current word have a verbal suffix like 'd', 'ed', 't', etc.
   - $f_{27}$ and $f_{28}$: above two for previous word.
   - $f_{29}$ and $f_{2,10}$: above two for next word.

#### Morphology

Morphemes
: Smallest meaning-bearing units forming a word.
e.g.: In "quickly", "quick" and "ly".

- **Analytic Languages**: Morphemes largely separate from one another.
- **Synthetic Languages**: Joins the morphemes.

Syncretism
: Overloading of roles per morpheme is called ***syncretism***.
e.g.: "will go": since number and person are indeterminate here

#### Maximum Entropy Markov Model

$$
    P(t_i=t|F_i)=\dfrac{e^{\sum_{j=1.k}\lambda_jf_{ij}}}{{\sum_{t'\in S}}e^{\sum_{j=1.k}\lambda_jf_{ij}(t')}}
$$

#### Beam Search Algorithm


```cpp
#define Prob(t,w) ()

vector<string> beam_search(vector<string> sentence, vector<string> labels){
    int n = sentence.size();
    int l = labels.size();
    int k = 3; // Beam size
    // labels[0] = "^"
    vector<vector<pair<float,vector<int>>>> best(n+1, vector<pair<float,
        vector<int>>>(k, make_pair(0,vector<int>(n))));
    best[0][0].first = 1;
    best[0][0].second[0] = 0;
    for(int i=1;i<k;i++){
        best[0][i].first = 0;
        best[0][i].second[0] = min(i,l-1);
    }
    for(int i=0;i<n;i++)
        for(int j=0;j<k;j++)
            for(int u=0;u<l;u++){
                pair<float,vector<int>> p = make_pair(best[i][j].first*
                    Prob(best[i][j].second, i+1, label[u]),best[i][j].second);
                labls[i] = u;
                for(int v=0;v<k;v++)
                    if(p>best[i+1][v])
                        swap(p,best[i+1][v]);
            }
    vector<string> res(n);
    pair<float,vector<int>> maxp = max_element(best[n].begin(),best[n].end());
    for(int i=0;i<maxp.second.size();i++)
        res[i] = labels[maxp.second[i]];
    return res;
}
```

## Parsing

### Context Free Grammar Parsing

We are given a CFG with terminals as POS tags from the language and vairables from segment labels. This grammar is converted to Chomsky form.

#### CYK Algorithm

```cpp
class node{
    string label;
    node* left;
    node* right;
};

node* CYK(vector<pair<string,string>> sent, map<pair<string,string>,string> rules)
{
    int n = pos_labels.size();
    vector<vector<pair<int,string>>> dp(n, vector<
            pair<int, string>>(n, make_pair(0,"")));
    for(int i=0;i<n;i++)
        for(int j=i;j>=0;j--)
            if(i==j)
                dp[j][i] = make_pair(i, sent[i][0]);
            else{
                dp[j][i] = make_pair(-1, "---");
                for(int k=j+1;k<=i;k++){
                    pair<string,string> rule = make_pair(dp[j][k-1].second,
                                                         dp[k][i].second);
                    if(rules.find(rule)!=rules.end()){
                        dp[j][i] = make_pair(k, rules[rule]);
                        break;
                    }
                }
            }
    node* r;
    // make the tree
    return r;
}
```

#### Shift reduce algorithm

Using a stack and working through a Push-down automaton based on the language.

### Probabilistic Parsing

In the normal CFG related to the language, we add probability value to each rule. This can be found using the dataset.

Probability of a Parse Tree is defined as the product probabilities of all the rules used in the parse tree. This way we find the parse tree with highest probability.

We can also define the probability of a sentence as the sum of probabilities of its parse trees.
$$
    P(S) = \sum_{t} P(t)\cdot P(S|t) = \sum_{t} P(t)
$$

### Dependency Parsing

Instead of creating chunks of words we create dependency relations between words itself. This creates a tree of words as nodes.

## FFNNBP

Use softmax or sigmoid for sentiment analysis.

## WordNet

- ***Syntagmatic***: Based on relations such as Synonym, antonym, etc. *CAT* and *ANIMAL*
- ***Paradigmatic***: Based on Co-occurences. *CAT* and *MEW*

### Wordnet Engineering

Principles of Synset creation
:   - Minimality
    - Coverage
    - Replacibility

These synsets are used to create Syntagmatic ConceptNets.

Calculate Lexical Semantic Association(LSA) i.e. matrix of co-occurence frequencies. Apply PCA to get Paradigmatic WordNets.

### Using WordNets

$$P(Context\\ word | input\\ word)=P(w_1|w_2)=\frac{e^{(u_{w_1}^Tu_{w_2})}}{\Sigma_k e^{(u_{w_1}^Tu_{w_k})}}$$

> Here $u_w$ is the word vector for $w$.