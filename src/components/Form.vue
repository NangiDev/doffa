<template>
  <v-container fill-height>
    <v-col class="ma-auto" cols="auto" align="center">
      <v-img :src="require('../assets/prism.svg')" max-height="120px" contain />
      <div class="headline text-h3 mb-10 font-weight-medium">DOFFA</div>

      <v-row>
        <v-col>
          <div class="instructions text-h6">Start date</div>
          <v-date-picker
            id="datePickerFrom"
            @click:date="fetchFromData"
            @load:date="fetchFromData"
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
            id="datePickerTo"
            @click:date="fetchToData"
            @load:date="fetchToData"
            v-model="toDateVal"
            :show-current="false"
            color="#4288f5"
            class="mb-5 mx-xl-5 mx-lg-5 mx-md-5 mx-sm-5"
            elevation="2"
            :first-day-of-week="1"
          />
        </v-col>
      </v-row>

      <v-row class="mb-5 mx-xl-16 mx-lg-16 mx-md-16 mx-sm-16">
        <v-col>
          <v-card>
            <v-row>
              <v-col align="right">
                <div class="text-h8">
                  {{ areaTextFrom.date }}
                </div>
                <div class="text-h8">
                  {{ areaTextFrom.bmi }}
                </div>
                <div class="text-h8">
                  {{ areaTextFrom.kg }}
                </div>
                <div class="text-h8">
                  {{ areaTextFrom.fat }}
                </div>
                <div class="text-h8">
                  {{ areaTextFrom.lean }}
                </div>
              </v-col>
              <v-col align="center">
                <div class="text-h8 font-weight-bold">
                  {{ "DATE" }}
                </div>
                <div class="text-h8 font-weight-bold">
                  {{ "BMI" }}
                </div>
                <div class="text-h8 font-weight-bold">
                  {{ "KG" }}
                </div>
                <div class="text-h8 font-weight-bold">
                  {{ "FAT" }}
                </div>
                <div class="text-h8 font-weight-bold">
                  {{ "LEAN" }}
                </div>
              </v-col>
              <v-col align="left">
                <div class="text-h8">
                  {{ areaTextTo.date }}
                </div>
                <div class="text-h8">
                  {{ areaTextTo.bmi }}
                </div>
                <div class="text-h8">
                  {{ areaTextTo.kg }}
                </div>
                <div class="text-h8">
                  {{ areaTextTo.fat }}
                </div>
                <div class="text-h8">
                  {{ areaTextTo.lean }}
                </div>
              </v-col>
            </v-row>
          </v-card>
        </v-col>
      </v-row>

      <v-row class="mx-xl-16 mx-lg-16 mx-md-16 mx-sm-16">
        <v-col>
          <v-card>
            <v-row>
              <v-col>
                <div class="text-h8">
                  {{ "DAYS: " + areaTextDiff.days }}
                </div>
                <div class="text-h8">
                  {{ "BMI: " + areaTextDiff.bmi }}
                </div>
                <div class="text-h8">
                  {{ "KG: " + areaTextDiff.kg }}
                </div>
              </v-col>
              <v-col>
                <div class="text-h8">
                  {{ "FAT: " + areaTextDiff.fat }}
                </div>
                <div class="text-h8">
                  {{ "LEAN: " + areaTextDiff.lean }}
                </div>
                <div class="ratio text-h8 mw-10">
                  {{ "RATIO: " + areaTextRatio }}
                </div>
              </v-col>
            </v-row>
          </v-card>
        </v-col>
      </v-row>
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
      areaTextFrom: JSON.parse(
        '{"date":"2020-01-01","kg":"10.00","fat":"10.00","lean":"10.00","bmi":"10.00"}'
      ),
      areaTextTo: JSON.parse(
        '{"date":"2020-01-01","kg":"10.00","fat":"10.00","lean":"10.00","bmi":"10.00"}'
      ),
      areaTextDiff: JSON.parse(
        '{"days": 23, "kg": 10.00, "fat": 10.00, "lean": 10.00, "bmi": 10.00}'
      ),
      areaTextRatio: "44/56",
    };
  },

  mounted() {
    // const toDateVal = new Date().toISOString().substring(0, 10);
    // const fromDateVal = localStorage.getItem("startDate")
    //   ? localStorage.getItem("startDate")
    //   : new Date(new Date().setDate(new Date().getDate() - 7))
    //       .toISOString()
    //       .substring(0, 10);
    // this.fetchFromData(fromDateVal);
    // this.fetchToData(toDateVal);
  },

  computed: {},

  methods: {
    calculate() {
      var diffJson = Compute.calculateDiff(this.areaTextFrom, this.areaTextTo);
      this.areaTextDiff = diffJson;
      this.areaTextRatio = Compute.getRatio(diffJson);
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
