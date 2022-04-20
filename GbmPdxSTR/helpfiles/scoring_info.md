### Scoring algorithms
___

Higher confidence scores are generated by the inclusion of as many STR loci as possible. Thus, A decrease in the accuracy of STR profiles are expected with low loci number.

#### Tanabe

Also known as the Sørensen-Dice coefficient:

$\large score = \frac{2 \; X \; No. \; of \; shared \; alleles}{Total \; No. \; query \; alleles \; + \; Total \; No. \; reference \; alleles}$

___
#### Masters

The original Masters algorithm:

$\large score =  \frac{No. \; of \; shared \; alleles}{Total \; No. \; query \; alleles}$

___
The modified Masters algorithm:

$\large score =  \frac{No. \; of \; shared \; alleles}{Total \; No. \; reference \; alleles}$

___

**References**

CLASTR: <https://doi.org/10.1002/ijc.32639>

Review: <https://doi.org/10.1002/ijc.27931>