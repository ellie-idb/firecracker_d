module models.base_model;
public import requests;
public import jsonizer;
public import models.client_models;
public import core.client;
public import std.json;

mixin template BaseModel() {
	
	string toString() {
		return this.toJSON.toString;
	}
}




