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
          class="mx-7"
        />
        <v-textarea
          v-model="areaTextTo"
          :disabled="true"
          :auto-grow="true"
          :filled="true"
          :solo="true"
          class="mx-7"
        />
      </v-row>
      <v-textarea
        v-model="areaTextDiff"
        :disabled="true"
        :auto-grow="true"
        :filled="true"
        :solo="true"
        class="mx-4"
      />
      <div class="ratio text-h4 mw-10">
        {{ areaTextRatio }}
      </div>
    </v-col>
  </v-container>
</template>

<script>
import * as Compute from "../compute";

export default {
  name: "Form",

  data() {
    return {
      toDateVal: new Date().toISOString().substring(0, 10),
      fromDateVal: localStorage.getItem("startDate")
        ? localStorage.getItem("startDate")
        : new Date(new Date().setDate(new Date().getDate() - 7))
            .toISOString()
            .substring(0, 10),
      areaTextFrom: "Select a start date above to fetch data",
      areaTextTo: "Select a end date above to fetch data",
      areaTextDiff: "Will show progress after calculated",
      areaTextRatio: "Will show ratio after calculation",
    };
  },

  computed: {},

  methods: {
    isValidJSONString(str) {
      try {
        JSON.parse(str);
      } catch (e) {
        return false;
      }
      return true;
    },

    calculate() {
      if (
        this.isValidJSONString(this.areaTextFrom) &&
        this.isValidJSONString(this.areaTextTo)
      ) {
        var diffJson = Compute.calculateDiff(
          this.areaTextFrom,
          this.areaTextTo
        );
        this.areaTextDiff = diffJson;
        this.areaTextRatio = Compute.getRatio(diffJson);
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
      request.setRequestHeader(
        "Authorization",
        "Bearer " + Compute.getAccessTokenFromWindowHashLocation()
      );
      request.setRequestHeader("accept", "application/json");
      request.onload = function() {
        var data = JSON.parse(this.response);
        self.areaTextFrom =
          Compute.mapObject(data.weight[0]) ||
          "Not enought data for date: " + date;

        self.calculate();
        localStorage.setItem("startDate", date);
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
      request.setRequestHeader(
        "Authorization",
        "Bearer " + Compute.getAccessTokenFromWindowHashLocation()
      );
      request.setRequestHeader("accept", "application/json");
      request.onload = function() {
        var data = JSON.parse(this.response);
        self.areaTextTo =
          Compute.mapObject(data.weight[0]) ||
          "Not enought data for date: " + date;
        self.calculate();
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
