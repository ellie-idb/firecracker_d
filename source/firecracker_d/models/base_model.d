module firecracker_d.models.base_model;
public import requests;
public import jsonizer;
public import firecracker_d.models.client_models;
public import firecracker_d.core.client;
public import std.json;

/*** 
*   This file is meant to provide all of the imports to the models, as well as
*   providing a 'mixin' template for converting the model's struct to a string
*   containing a JSON object representing the fields.
***/

mixin template BaseModel() {
	string toString() {
		return this.toJSON.toString;
	}
}




