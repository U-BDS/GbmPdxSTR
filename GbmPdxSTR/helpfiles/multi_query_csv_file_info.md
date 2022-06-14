### File format for multi-query csv upload
___

Multi-query must be uploaded via a csv file. Overal for the format is the same as the single-query csv, with the data for each sample concatenated into a single file. Please see the specifications below and the examples:

* Must be a `csv` file
* Should contain the following column names: `GBM` (corresponds to sample names), `Marker` (corresponds to names of the markers), `Allele_1`, `Allele_2`, `Allele_3`, `Allele_4`
* Empty/non-data entries should contain `NA` or be left blank
* A blank template of the multi-query file (for 2 samples as an example) can be downloaded from the option in the app which states __`Download template csv file`__
* The marker `Amel` also contains the following aliases which may be used instead (will be auto-converted to `Amel`): `Amelogenin`, `AM`, `Aml`, `AMEL`
* Similarly, the marker `Penta.D` has the alias `Penta D` and `Penta.E` has the alias `Penta E`
* Each sample should be concatenated into the same file (one below another, see example below)
* A properly formatted table example is:

<style>
.basic-styling td,
.basic-styling th {
  border: 1px solid #999;
  padding: 0.5rem;
  text-align: center;
}
.basic-styling tr:nth-child(even) {
  background-color: #f2f2f2;
}
</style>

<div class="ox-hugo-table basic-styling">
<div></div>
<div class="table-caption">
  <span class="table-number"></span>
</div>

|GBM|Marker|Allele_1|Allele_2|Allele_3|Allele_4|
|---|---|---|---|---|---|
|JX39_sample|Amel|X|X|NA|NA|
|JX39_sample|CSF1PO|11|13|NA|NA|
|JX39_sample|D10S1248|13|13|NA|NA|
|JX39_sample|D12S391|18|18|NA|NA|
|JX39_sample|D13s317|10|12|NA|NA|
|JX39_sample|D16s539|11|13|NA|NA|
|JX39_sample|D18s51|16|18|NA|NA|
|JX39_sample|D19S433|14|14|NA|NA|
|JX39_sample|D1S1656|11|16|NA|NA|
|JX39_sample|D21s11|28|31|NA|NA|
|JX39_sample|D22S1045|16|16|NA|NA|
|JX39_sample|D2S1338|17|25|NA|NA|
|JX39_sample|D2S441|11|11|NA|NA|
|JX39_sample|D3s1358|18|18|NA|NA|
|JX39_sample|D5s818|12|12|NA|NA|
|JX39_sample|D7s820|10|10|NA|NA|
|JX39_sample|D8s1179|13|14|NA|NA|
|JX39_sample|DYS391|NA|NA|NA|NA|
|JX39_sample|FGA|20|21|NA|NA|
|JX39_sample|Penta.D|11|13|NA|NA|
|JX39_sample|Penta.E|7|7|NA|NA|
|JX39_sample|TH01|6|9.3|NA|NA|
|JX39_sample|TPOX|8|11|NA|NA|
|JX39_sample|vWA|15|16|NA|NA|
|XD456p47|Amel|X|NA|NA|NA|
|XD456p47|CSF1PO|12|13|NA|NA|
|XD456p47|D10S1248|11|12|15|NA|
|XD456p47|D12S391|18|23|24|27|
|XD456p47|D13s317|9|13|NA|NA|
|XD456p47|D16s539|13|14|NA|NA|
|XD456p47|D18s51|15|18|NA|NA|
|XD456p47|D19S433|13|NA|NA|NA|
|XD456p47|D1S1656|14|15.3|16.3|NA|
|XD456p47|D21s11|31|31.2|NA|NA|
|XD456p47|D22S1045|14|15|16|NA|
|XD456p47|D2S1338|23|24|26|NA|
|XD456p47|D2S441|10|11|12|NA|
|XD456p47|D3s1358|17|18|19|20|
|XD456p47|D5s818|10|11|12|NA|
|XD456p47|D7s820|9|10|NA|NA|
|XD456p47|D8s1179|10|11|NA|NA|
|XD456p47|DYS391|NA|NA|NA|NA|
|XD456p47|FGA|18|22|24|NA|
|XD456p47|Penta.D|9|11|NA|NA|
|XD456p47|Penta.E|18|19|NA|NA|
|XD456p47|TH01|7|NA|NA|NA|
|XD456p47|TPOX|8|11|NA|NA|
|XD456p47|vWA|17|18|NA|NA|

</div>
