<template>
  <v-container>
    <v-row class="text-center">
      <v-col cols="12">
        <v-img :src="require('../assets/logo.svg')" class="my-3" contain height="80" />
      </v-col>
      <v-col cols="12">
        <v-card class="mx-auto" max-width="100%">
          <h3>Start Date</h3>
          <v-date-picker
            @click:date="fetchFromData"
            v-model="fromDateVal"
            :show-current="false"
            no-title
          ></v-date-picker>
          <v-textarea
            v-model="areaTextFrom"
            :disabled="true"
            :auto-grow="true"
            :filled="true"
            :outlined="true"
            :solo="true"
          ></v-textarea>
          <h3>End Date</h3>
          <v-date-picker
            @click:date="fetchToData"
            v-model="toDateVal"
            :show-current="false"
            no-title
          ></v-date-picker>
          <v-textarea
            v-model="areaTextTo"
            :disabled="true"
            :auto-grow="true"
            :filled="true"
            :outlined="true"
            :solo="true"
          ></v-textarea>
        </v-card>
      </v-col>
      <!-- <v-col cols="12">
        <v-card class="mx-auto" max-width="344">
          <h3>End Date</h3>
          <br />
          <v-date-picker v-model="toDateVal" no-title :show-current="false"></v-date-picker>
          <v-textarea :value="toDateVal"></v-textarea>
        </v-card>
      </v-col>-->

      <v-col cols="12">
        <!-- <v-btn></v-btn> -->
        <!-- <v-textarea dense="true" auto-grow="true" filled="true" rounded="true"></v-textarea>
        <v-textarea dense="true" auto-grow="true" filled="true" rounded="true"></v-textarea>-->
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
export default {
  name: "Form",

  data() {
    return {
      toDateVal: new Date().toISOString().substring(0, 10),
      fromDateVal: new Date(new Date().setDate(new Date().getDate() - 7))
        .toISOString()
        .substring(0, 10),
      areaTextFrom: "Click a date above to fetch data",
      areaTextTo: "Click a date above to fetch data"
    };
  },

  computed: {},

  methods: {
    getToken: () => {
      var arr = window.location.hash
        .substring(1)
        .split(/&|=/)
        .reduce(function(result, value, index, array) {
          //Array to map
          // Even index-elements will be keys and the following will be the value
          if (index % 2 === 0) result[array[index]] = array[index + 1];
          return result;
        }, {});
      return arr.access_token;
    },

    fetchFromData(date) {
      var self = this;
      var request = new XMLHttpRequest();
      request.open(
        "GET",
        "https://api.fitbit.com/1/user/-/body/log/weight/date/" +
          date +
          ".json",
        true
      );
      request.setRequestHeader("Authorization", "Bearer " + this.getToken());
      request.setRequestHeader("accept", "application/json");
      request.onload = function() {
        var data = JSON.parse(this.response).weight[0];
        self.areaTextFrom =
          JSON.stringify(data, "", 4) || "Not enought data for date: " + date;
      };
      request.err = this.reqError;
      request.send();
    },

    fetchToData(date) {
      var self = this;
      var request = new XMLHttpRequest();
      request.open(
        "GET",
        "https://api.fitbit.com/1/user/-/body/log/weight/date/" +
          date +
          ".json",
        true
      );
      request.setRequestHeader("Authorization", "Bearer " + this.getToken());
      request.setRequestHeader("accept", "application/json");
      request.onload = function() {
        var data = JSON.parse(this.response).weight[0];
        self.areaTextTo =
          JSON.stringify(data, "", 4) || "Not enought data for date: " + date;
      };
      request.err = this.reqError;
      request.send();
    },

    reqError(err) {
      console.log("Fetch Error :-S", err);
    }
  }
};

// function calculate() {
//   var input1 = document.getElementById("startArea").innerHTML;
//   var input2 = document.getElementById("endArea").innerHTML;
//   var ratioArea = document.getElementById("ratioArea");
//   var diffArea = document.getElementById("diffArea");
//   if (input1 === "" || input2 == "") {
//     diffArea.innerHTML = "Make sure you have fetched start and end data";
//   } else {
//     var diffJson = diff(input1, input2);
//     diffArea.innerHTML = diffJson;
//     ratioArea.innerHTML = ratio(diffJson);
//   }
// }

// function dateDiff(string1, string2) {
//   const date1 = new Date(string1);
//   const date2 = new Date(string2);
//   const diffTime = Math.abs(date2 - date1);
//   const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24));
//   return diffDays;
// }

// function diff(d1, d2) {
//   d1 = JSON.parse(d1);
//   d2 = JSON.parse(d2);

//   var days = dateDiff(d1.date, d2.date);
//   var kg = d2.kg - d1.kg;
//   var fat = d2.fat - d1.fat;
//   var lean = d2.lean - d1.lean;
//   var bmi = d2.bmi - d1.bmi;

//   var text =
//     "{" +
//     '"days": "' +
//     days +
//     '",' +
//     '"kg":"' +
//     kg +
//     '",' +
//     '"fat":"' +
//     fat +
//     '",' +
//     '"lean":"' +
//     lean +
//     '",' +
//     '"bmi":"' +
//     bmi +
//     '"' +
//     "}";
//   return JSON.stringify(JSON.parse(text), "", 4);
// }

// function mapObject(data) {
//   var date = data.date;
//   var kg = data.weight;
//   var fat = kg * (data.fat / 100);
//   var lean = kg - fat;
//   var bmi = data.bmi;

//   var text =
//     "{" +
//     '"date": "' +
//     date +
//     '",' +
//     '"kg":"' +
//     kg +
//     '",' +
//     '"fat":"' +
//     fat +
//     '",' +
//     '"lean":"' +
//     lean +
//     '",' +
//     '"bmi":"' +
//     bmi +
//     '"' +
//     "}";
//   return JSON.stringify(JSON.parse(text), "", 4);
// }

// function ratio(diffData) {
//   diffData = JSON.parse(diffData);
//   var lean = Math.round((diffData.lean / diffData.kg) * 100 + 0.5);
//   var fat = Math.round((diffData.fat / diffData.kg) * 100 + 0.5);
//   return "" + lean + "/" + fat;
// }

// function callRest(date, area) {
//   var paramStr = window.location.hash.substring(1); // substring removes the initial "#"
//   var paramArray = paramStr.split(/&|=/); //Split string into array on prelimiter '&' and '='
//   var paramMap = paramArray.reduce(function(result, value, index, array) {
//     //Array to map
//     // Even index-elements will be keys and the following will be the value
//     if (index % 2 === 0) result[array[index]] = array[index + 1];
//     return result;
//   }, {});
//   // Setup request towards Fitbit REST api
//   var request = new XMLHttpRequest();
//   request.open(
//     "GET",
//     "https://api.fitbit.com/1/user/-/body/log/weight/date/" + date + ".json",
//     true
//   );
//   request.setRequestHeader("Authorization", "Bearer " + paramMap.access_token);
//   request.setRequestHeader("accept", "application/json");
//   request.onload = function() {
//     var data = JSON.parse(this.response);
//     if (request.status >= 200 && request.status < 400) {
//       area.innerHTML = mapObject(data.weight[0]);
//     } else {
//       console.log("Request Fitbit api returned error");
//     }
//   };
//   request.send();
// }
</script>
