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
        <td>{{ flight.exercises }}</td>
        <td>{{ flight.aircraft }}</td>
        <td>{{ flight.comments }}</td>
      </tr>
    </table>

    <vue-html2pdf
    :show-layout="false"
    :float-layout="true"
    :enable-download="true"
    :preview-modal="false"
    :paginate-elements-by-height="1400"
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
      console.log(data);
      this.flights.push(data);
      this.addNewFlight = false;
    },
    generatePdf() {
      console.log(`Generating Daily Report for ${this.instructorName} on ${this.date} for supervisory instructor ${this.supervisoryInstructor} for ${this.flights.length}`)
      this.flights.forEach(flight => console.log(flight));
      this.$refs.html2Pdf.generatePdf()
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
