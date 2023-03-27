### File format for multi-query csv upload
___

Multi-query must be uploaded via a csv file. Overall for the format is the same as the single-query csv, with the data for each sample concatenated into a single file. Please see the specifications below and the examples:

* Must be a `csv` file
* Should contain the following column names: `GBM` (corresponds to sample names), `Marker` (corresponds to names of the markers), `Allele_1`, `Allele_2`, `Allele_3`, `Allele_4`
* Empty/non-data entries should contain `NA` or be left blank
* A blank template of the multi-query file (for 2 samples as an example) can be downloaded from the option in the app which states __`Download template csv file`__
* The marker `Amel` also contains the following aliases which may be used instead (will be auto-converted to `Amel`): `Amelogenin`, `AM`, `Aml`, `AMEL`
* Similarly, the marker `Penta.D` has the alias `Penta D` and `Penta.E` has the alias `Penta E`
* Each sample should be concatenated into the same file (one below another, see example below)
* The maximum number of samples/GBM that can be processed together is 50. If you have more than 50 samples, the additional samples should be in separate upload (e.g.: for 100 samples, prepare two input files and perform two multi-query runs).
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
|JX39|Amel|X|X|NA|NA|
|JX39|CSF1PO|11|13|NA|NA|
|JX39|D10S1248|13|13|NA|NA|
|JX39|D12S391|18|18|NA|NA|
|JX39|D13s317|10|12|NA|NA|
|JX39|D16s539|11|13|NA|NA|
|JX39|D18s51|16|18|NA|NA|
|JX39|D19S433|14|14|NA|NA|
|JX39|D1S1656|11|16|NA|NA|
|JX39|D21s11|28|31|NA|NA|
|JX39|D22S1045|16|16|NA|NA|
|JX39|D2S1338|17|25|NA|NA|
|JX39|D2S441|11|11|NA|NA|
|JX39|D3s1358|18|18|NA|NA|
|JX39|D5s818|12|12|NA|NA|
|JX39|D7s820|10|10|NA|NA|
|JX39|D8s1179|13|14|NA|NA|
|JX39|DYS391|NA|NA|NA|NA|
|JX39|FGA|20|21|NA|NA|
|JX39|Penta.D|11|13|NA|NA|
|JX39|Penta.E|7|7|NA|NA|
|JX39|TH01|6|9.3|NA|NA|
|JX39|TPOX|8|11|NA|NA|
|JX39|vWA|15|16|NA|NA|
|XD456|Amel|X|NA|NA|NA|
|XD456|CSF1PO|12|13|NA|NA|
|XD456|D10S1248|11|12|15|NA|
|XD456|D12S391|18|23|24|27|
|XD456|D13s317|9|13|NA|NA|
|XD456|D16s539|13|14|NA|NA|
|XD456|D18s51|15|18|NA|NA|
|XD456|D19S433|13|NA|NA|NA|
|XD456|D1S1656|14|15.3|16.3|NA|
|XD456|D21s11|31|31.2|NA|NA|
|XD456|D22S1045|14|15|16|NA|
|XD456|D2S1338|23|24|26|NA|
|XD456|D2S441|10|11|12|NA|
|XD456|D3s1358|17|18|19|20|
|XD456|D5s818|10|11|12|NA|
|XD456|D7s820|9|10|NA|NA|
|XD456|D8s1179|10|11|NA|NA|
|XD456|DYS391|NA|NA|NA|NA|
|XD456|FGA|18|22|24|NA|
|XD456|Penta.D|9|11|NA|NA|
|XD456|Penta.E|18|19|NA|NA|
|XD456|TH01|7|NA|NA|NA|
|XD456|TPOX|8|11|NA|NA|
|XD456|vWA|17|18|NA|NA|

</div>
