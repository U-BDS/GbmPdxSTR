# GBM PDX STR Similarity Search Tool
___

This web tool provides you with the ability to search for Short Tandem Repeat (STR) similarity between your sample (query) to the glioblastoma (GBM) patient-derived xenograft (PDX) tumors present at UAB. This tool is inspired by the [Cellosaurus CLASTR search tool](https://web.expasy.org/cellosaurus-str-search/). Additional information about this resource can be found at <https://doi.org/10.1002/ijc.32639>.

### Purpose

To enable improved tracking of tumor line identity and provide collaborators to quickly confirm matching of their specimens/tumors/cells with existing PDX models.

### Reference set

The default reference set of GBM PDX tumors include the following:

<!-- Tip: use VS code CSV to Markdown Table converter for quick conversion -->
<!-- file STR_GBM_PDX_Standards_metadata_overview.csv used as input -->

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

|GBM|Source|
|---|---|
|JX39|Mayo Clinic|
|JX14|Mayo Clinic|
|JX12|Mayo Clinic|
|JX6|Mayo Clinic|
|JX59|Mayo Clinic|
|JX10|Mayo Clinic|
|JX22|Mayo Clinic|
|X1016|UAB|
|X1052|UAB|
|X1066|UAB|
|X1153|UAB|
|X1238|UAB|
|X1441|UAB|
|X1465|UAB|
|X1516|UAB|
|X1524|UAB|
|XD456|Duke|

</div>

`J` refers to Dr. Jann Sarkaria, who provided the Mayo Clinic tumors.

`X` indicates the sample is a xenograph.

Custom tumor line references containing the markers present in the app is also supported in the `STR multi-query Search` tab. If you would like to see your reference integrated into the app's default reference please contact Dr. Chris Willey.

### Contact information

Please feel free to contact the lead investigator, __Dr. Chris Willey__ if you have any general questions about our site or would like more information: `cwilley [at] uabmc.edu`
___
### Issues

If you encounter any errors or issues with the app, please open an issue to the git repository of this app located [here](https://github.com/U-BDS/GbmPdxSTR).
___
### About the app

The GBM PDX STR Similarity Search Tool was written by [Dr. Lara Ianov](https://github.com/lianov).

The app was written with support of [Dr. Chris Willey](https://scholars.uab.edu/display/cwilley), UAB and funding from the NIH U01 CA223976 grant.

Aid with web-hosting was provided by [Austyn Trull](https://github.com/atrull314). We would like to thank the UAB Research Computing group for the UAB cloud resources being used to host this application.

Lastly, Dr. Lara Ianov and Austyn Trull are members of the [UAB Biological Data Science core](https://www.uab.edu/cores/ircp/bds).