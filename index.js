/* Discord Dungeons API Wrapper for NodeJS 

 Copyright Mackan & The Discord Dungeons Team

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.

*/

const http = require("http");
const bases = {
	URL: "api.discorddungeons.me"
	RES: "res.discorddungeons.me/images"
};

const reqHandle = function(path, cb){

	let options = {
		host: bases.URL,
		path: path,
		headers: {
			'User-Agent': DDApi.API_AGENT,
			'X-Api-Key': DDApi.API_KEY
		}
	};

	http.request(options).on("response", (resp) => {
		let data = '';
		resp.on('data', (chunk) => {
			data += chunk;
		});
		resp.on('end', () => {
			cb(data);
		});
	}).end();
}

const crafts = {
	getAll: function(cb){
		reqHandle("/all/crafts", cb);
	},
	searchByName: function(name, cb){
		reqHandle("/search/craft/"+name, cb);
	}
};

const guilds = {
	getAll: function(cb){
		reqHandle("/all/guilds", cb);
	},
	getById: function(id,cb){
		reqHandle("/guild/"+id, cb);
	},
	searchByName: function(name, cb){
		reqHandle("/search/guild/"+name, cb);
	},
	items: {
		getById: function(id, cb){
			reqHandle("/gitem/"+id, cb);
		},
		getAll: function(cb){
			reqHandle("/all/gitems", cb);
		},
		searchByName: function(name, cb){
			reqHandle("/search/gitem/"+name, cb);
		}
	}
};

const items = {
	getAll: function(cb){
		reqHandle("/all/items", cb);
	},
	getById: function(id, cb){
		reqHandle("/item/"+id, cb);
	},
	searchByName: function(name, cb){
		reqHandle("/search/item/"+name, cb);
	}
};

const users = {
	getById: function(id, cb){
		reqHandle("/user/"+id, cb);
	},
	getAll: function(cb){
		reqHandle("/all/users", cb);
	},
	getLead: function(field, amt, cb){
		if(typeof amt === "function"){
			reqHandle('/lead/'+field, amt);
		}else{
			reqHandle('/lead/'+field+"/"+amt, cb);
		}
	},
	searchByName: function(name, cb){
		reqHandle("/search/user/"+name, cb);
	}
};

const DDApi = {
	init: function(API_KEY, API_AGENT){
		this.API_KEY = API_KEY;
		this.API_AGENT = API_AGENT;
	},
	crafts: crafts,
	guilds: guilds,
	items: items,
	users: users,
	getBotStats: function(cb){
		reqHandle("/stats/", cb);
	}
};

module.exports = DDApi;
