module firecracker_d.models.base_model;
public import requests;
public import asdf;
public import firecracker_d.models.client_models;
public import firecracker_d.core.client;

/*** 
*   This file is meant to provide all of the imports to the models, as well as
*   providing a 'mixin' template for converting the model's struct to a string
*   containing a JSON object representing the fields.
***/

mixin template BaseModel() {
	string stringify() {
        return serializeToJson(this);
	}
}




