<template>
  <div class="title-form">
    <form action="" id="instruction-information">
      <label for="instructor-name">Instructor Name: </label>
      <input type="text" id="instructor-name" v-model="instructorName">

      <label for="date-of-flights">Date: </label>
      <input type="date" id="date-of-flights" v-model="date">

      <label for="supervisory-instructor">Supervisory Instructor: </label>
      <input type="text" id="supervisory-instructor" v-model="supervisoryInstructor">
    </form>

    <button v-if="!addNewFlight" @click="addNewFlight = !addNewFlight">Add New Flight</button>
    <flight-card v-if="addNewFlight"
    @save-form="saveInputForm"
    @cancel-form="addNewFlight = false" />
    <table>
      <colgroup>
       <col span="1" style="width: 15%;">
       <col span="1" style="width: 15%;">
       <col span="1" style="width: 15%;">
       <col span="1" style="width: 15%;">
       <col span="1" style="width: 40%;">
      </colgroup>
      <tr>
        <th>Student</th>
        <th>Level of Training</th>
        <th>TC exercise</th>
        <th>Aircraft</th>
        <th>Comments</th>
      </tr>
      <tr v-for="flight in this.flights" :key="flight.student">
        <td>{{ flight.student }}</td>
        <td>{{ flight.levelOfTraining }}</td>
        <td>{{ transportCanadaExerciseNumberFromName(flight.exercises) }}</td>
        <td>{{ aircraftStringFromRegistration(flight.aircraft) }}</td>
        <td class="comments">{{ commentsForFlight(flight) }}</td>
      </tr>
    </table>

    <vue-html2pdf
    :show-layout="false"
    :float-layout="true"
    :enable-download="true"
    :preview-modal="false"
    :paginate-elements-by-height="2000"
    :filename="this.date"
    :pdf-quality="2"
    :manual-pagination="false"
    pdf-format="letter"
    pdf-orientation="portrait"
    pdf-content-width="800px"
    ref="html2Pdf">
      <section slot="pdf-content">
        <PDFCard
        :instructor="this.instructorName"
        :supervisor="this.supervisoryInstructor"
        :date="this.date"
        :flights="this.flights" />
      </section>
    </vue-html2pdf>

    <button @click="generatePdf()" :disabled="generatePdfButtonDisabled">Generate PDF</button>
    <a :href="this.emailLink" target="_blank"><button :disabled="generatePdfButtonDisabled">Open Email</button></a>
  </div>
</template>

<script>
import FlightCard from './FlightCard';
import PDFCard from './PDFCard';
import VueHtml2pdf from 'vue-html2pdf'

import aircraftData from '@/data/aircraft';
import exerciseData from '@/data/exercise';
import blockData from '@/data/blocks';

export default {
  name: 'TitleForm',
  components: {
    FlightCard,
    PDFCard,
    VueHtml2pdf
  },
  computed: {
    generatePdfButtonDisabled() {
      return this.flights.length <= 0 || this.instructorName == null || this.date == null || this.supervisoryInstructor == null
    },
    emailLink() {
      return `https://outlook.office.com/mail/deeplink/compose?to=satkinson@wwfc.ca&subject=Daily Reporting for ${this.date}`
    }
  },
  data() {
    return {
      addNewFlight: false,
      instructorName: null,
      date: null,
      supervisoryInstructor: null,
      flights: []
    }
  },
  methods: {
    saveInputForm(data) {
      this.flights.push(data);
      this.addNewFlight = false;
    },
    generatePdf() {
      console.log(`Generating Daily Report for ${this.instructorName} on ${this.date} for supervisory instructor ${this.supervisoryInstructor} for ${this.flights.length}`)
      this.flights.forEach(flight => console.log(flight));
      this.$refs.html2Pdf.generatePdf()
    },
    aircraftStringFromRegistration(registration) {
      const currentAircraft = aircraftData.aircraft.find(plane => plane.registration === registration);
      return `${currentAircraft.type} ${currentAircraft.registration}`;
    },
    transportCanadaExerciseNumberFromName(exercises) {
      return exercises.map(exercise => `${exerciseData.exercises.find(exz => exz.name === exercise).id} - ${exercise}`).join(', ');
    },
    commentsForFlight(flight) {
      const block = blockData.blocks.find(block => block.code === flight.blockCode);
      return `${block.shortName} ${block.name}

      Dual Hours: ${flight.dualHours == null ? 'N/A' : `${flight.dualHours} / ${block.hours.dual}`}
      Solo Hours: ${flight.soloHours == null ? 'N/A' : `${flight.soloHours} / ${block.hours.solo}`}
      VFR Sim Hours: ${flight.vfrSimHours == null ? 'N/A' : `${flight.vfrSimHours} / ${block.hours.vfrSimHours}`}

      ${flight.comments}`;
    }
  }
}
</script>

<style scoped>
form {
  display: flex;
  flex-direction: row;
  margin: 1rem;
}

form > * {
  margin: 1rem;
}

h3 {
  margin: 40px 0 0;
}

ul {
  list-style-type: none;
  padding: 0;
}

li {
  display: inline-block;
  margin: 0 10px;
}

a {
  color: #42b983;
}

table {
  width: 100%;
}

table, th, td {
  border: 1px solid black;
  border-collapse: collapse;
}

td {
  padding: 0.5rem;
  text-align: center;
}
</style>
