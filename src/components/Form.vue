<template>
  <v-container fill-height>
    <v-col align="center" justify="center">
      <v-img :src="require('../assets/logo.png')" max-height="120px" contain />
      <div class="headline text-h3 mb-10 font-weight-medium">DOFFA</div>
      <v-row>
        <v-col>
          <div class="instructions text-h6">Start date</div>
          <v-date-picker
            @click:date="fetchFromData"
            v-model="fromDateVal"
            :show-current="false"
            color="#4288f5"
            class="mb-5 mx-xl-5 mx-lg-5 mx-md-5 mx-sm-5"
            elevation="2"
            :first-day-of-week="1"
          />
        </v-col>
        <v-col>
          <div class="instructions text-h6">End date</div>
          <v-date-picker
            @click:date="fetchToData"
            v-model="toDateVal"
            :show-current="false"
            color="#4288f5"
            class="mb-5 mx-xl-5 mx-lg-5 mx-md-5 mx-sm-5"
            elevation="2"
            :first-day-of-week="1"
          />
        </v-col>
      </v-row>

      <v-row>
        <v-textarea
          v-model="areaTextFrom"
          :disabled="true"
          :auto-grow="true"
          :filled="true"
          :solo="true"
          class="mx-xl-5 mx-lg-5 mx-md-5 mx-sm-5"
        />
        <v-textarea
          v-model="areaTextTo"
          :disabled="true"
          :auto-grow="true"
          :filled="true"
          :solo="true"
          class="mx-xl-5 mx-lg-5 mx-md-5 mx-sm-5"
        />
      </v-row>
      <v-textarea
        v-model="areaTextDiff"
        :disabled="true"
        :auto-grow="true"
        :filled="true"
        :solo="true"
      />
      <v-btn
        @click="calculate"
        class="m-10 white--text"
        color="#4288f5"
        elevation="2"
        x-large
      >
        Calculate</v-btn
      >
      <v-text-field
        solo
        v-model="areaTextRatio"
        :disabled="true"
        :auto-grow="true"
        :filled="true"
      />
    </v-col>
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
      areaTextTo: "Click a date above to fetch data",
      areaTextDiff: "Will show progress after calculated",
      areaTextRatio: "Will show ratio after calculated",
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

    mapObject(data) {
      if (!data) {
        return data;
      }
      var date = data.date;
      var kg = data.weight;
      var fat = kg * (data.fat / 100);
      var lean = kg - fat;
      var bmi = data.bmi;

      var text =
        "{" +
        '"date": "' +
        date +
        '",' +
        '"kg":"' +
        kg +
        '",' +
        '"fat":"' +
        fat +
        '",' +
        '"lean":"' +
        lean +
        '",' +
        '"bmi":"' +
        bmi +
        '"' +
        "}";
      return JSON.stringify(JSON.parse(text), "", 4);
    },

    isValidJSONString(str) {
      try {
        JSON.parse(str);
      } catch (e) {
        return false;
      }
      return true;
    },

    dateDiff(string1, string2) {
      const date1 = new Date(string1);
      const date2 = new Date(string2);
      const diffTime = Math.abs(date2 - date1);
      const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24));
      return diffDays;
    },

    diff(d1, d2) {
      d1 = JSON.parse(d1);
      d2 = JSON.parse(d2);

      var days = this.dateDiff(d1.date, d2.date);
      var kg = d2.kg - d1.kg;
      var fat = d2.fat - d1.fat;
      var lean = d2.lean - d1.lean;
      var bmi = d2.bmi - d1.bmi;

      var text =
        "{" +
        '"days": "' +
        days +
        '",' +
        '"kg":"' +
        kg +
        '",' +
        '"fat":"' +
        fat +
        '",' +
        '"lean":"' +
        lean +
        '",' +
        '"bmi":"' +
        bmi +
        '"' +
        "}";
      return JSON.stringify(JSON.parse(text), "", 4);
    },

    ratio(diffData) {
      diffData = JSON.parse(diffData);
      var lean = Math.round((diffData.lean / diffData.kg) * 100 + 0.5);
      var fat = Math.round((diffData.fat / diffData.kg) * 100 + 0.5);
      return "" + lean + "/" + fat;
    },

    calculate() {
      if (
        this.isValidJSONString(this.areaTextFrom) &&
        this.isValidJSONString(this.areaTextTo)
      ) {
        var diffJson = this.diff(this.areaTextFrom, this.areaTextTo);
        this.areaTextDiff = diffJson;
        this.areaTextRatio = this.ratio(diffJson);
      } else {
        this.areaTextDiff = "Invalid data. Try another date";
        this.areaTextRatio = "Invalid data- Try another date";
      }
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
        var data = JSON.parse(this.response);
        self.areaTextFrom =
          self.mapObject(data.weight[0]) ||
          "Not enought data for date: " + date;
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
        var data = JSON.parse(this.response);
        self.areaTextTo =
          self.mapObject(data.weight[0]) ||
          "Not enought data for date: " + date;
      };
      request.err = this.reqError;
      request.send();
    },

    reqError(err) {
      console.log("Fetch Error :-S", err);
    },
  },
};
</script>
