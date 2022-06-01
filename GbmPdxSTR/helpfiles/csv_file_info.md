### File format for cvs upload
___

Instead of manually entering your STR data in the app directly, users may also upload data through a `csv` file. The requirements of this file are:

* Must be a `csv` file
* Should contain the following column names: `GBM` (corresponds to sample names), `Marker` (corresponds to names of the markers), `Allele_1`, `Allele_2`, `Allele_3`, `Allele_4`
* Empty/non-data entries should contain `NA` or be left blank
* A blank template of the file can be downloaded from the option in the app which states __`Download template csv file`__
* The marker `Amel` also contains the following aliases which may be used instead (will be auto-converted to `Amel`): `Amelogenin`, `AM`, `Aml`, `AMEL`
* Similarly, the marker `Penta.D` has the alias `Penta D` and `Penta.E` has the alias `Penta E`
* A sample completed csv file may look like the following example:


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

</div>
