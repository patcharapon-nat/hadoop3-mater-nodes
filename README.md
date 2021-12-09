```
We ussally have a requirement as a spreadsheet like this.
To reduce gap of writing those requirement down on a json like this,
I decide to add a feature in to the code to read directly from the spreadsheet

Let get down to the demo, here the bit buckket link https://bitbucket.org/truedmp/nutanix-automation/src/master/

Steps
1. clone the master banch
2. go to nutanix-client folder
3. edit this conf/tfvars-generators-env.sh 
	| export SAMPLE_SPREADSHEET_ID='17H1DsGj-fpIMrLBlz4CbWY9jS4RDAoLtrbCqrqTz-1c'
	| export SAMPLE_RANGE_NAME='Util VMs hosts!A4:I7'
	| export CLOUDINIT_TEMPLATE='conf/cloud-init.j2.yml'
	| export TFVAR_PATH='conf/terraform.tfvars' # output path

4. run cmd `python tfvars-generators.py` you will get `conf/terraform.tfvars` that can be used to provision the vms acc. to your requirement

5. run terraform as ussual
6. as you can see the data disk is not comming up as the 1st run
7. do the 2nd run to add the data disk
8. use the vms
```
