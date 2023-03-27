### File format for custom reference csv upload
___

The file format to the custom reference csv is the same as the multi-query format (multiple references can be uploaded as shown in the multi-query examples). As a reminder, the following is a description of the format:

* Must be a `csv` file
* Should contain the following column names: `GBM` (corresponds to tumor reference name), `Marker` (corresponds to names of the markers), `Allele_1`, `Allele_2`, `Allele_3`, `Allele_4`
* Empty/non-data entries should contain `NA` or be left blank
* The marker `Amel` also contains the following aliases which may be used instead (will be auto-converted to `Amel`): `Amelogenin`, `AM`, `Aml`, `AMEL`
* Similarly, the marker `Penta.D` has the alias `Penta D` and `Penta.E` has the alias `Penta E`
* Each reference should be concatenated into the same file (one below another)
* A properly formatted table example is:

__NOTE__: the choice of markers should match the markers supported by the app as seen in the single-query page or multi-query examples. If your reference does not contain data for a specific supported markers, you may add `NA` to each allele column.

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
|cust_ref|Amel|X|X|NA|NA|
|cust_ref|CSF1PO|11|13|NA|NA|
|cust_ref|D10S1248|13|13|NA|NA|
|cust_ref|D12S391|18|18|NA|NA|
|cust_ref|D13s317|10|12|NA|NA|
|cust_ref|D16s539|11|13|NA|NA|
|cust_ref|D18s51|16|18|NA|NA|
|cust_ref|D19S433|14|14|NA|NA|
|cust_ref|D1S1656|11|16|NA|NA|
|cust_ref|D21s11|28|31|NA|NA|
|cust_ref|D22S1045|16|16|NA|NA|
|cust_ref|D2S1338|17|25|NA|NA|
|cust_ref|D2S441|11|11|NA|NA|
|cust_ref|D3s1358|18|18|NA|NA|
|cust_ref|D5s818|12|12|NA|NA|
|cust_ref|D7s820|10|10|NA|NA|
|cust_ref|D8s1179|13|14|NA|NA|
|cust_ref|DYS391|NA|NA|NA|NA|
|cust_ref|FGA|20|21|NA|NA|
|cust_ref|Penta.D|11|13|NA|NA|
|cust_ref|Penta.E|7|7|NA|NA|
|cust_ref|TH01|6|9.3|NA|NA|
|cust_ref|TPOX|8|11|NA|NA|
|cust_ref|vWA|15|16|NA|NA|

</div>
