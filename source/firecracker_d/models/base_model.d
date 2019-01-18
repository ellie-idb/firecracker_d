module firecracker_d.models.base_model;
public import requests;
public import jsonizer;
public import firecracker_d.models.client_models;
public import firecracker_d.core.client;
public import std.json;

mixin template BaseModel() {
	
	string toString() {
		return this.toJSON.toString;
	}
}




