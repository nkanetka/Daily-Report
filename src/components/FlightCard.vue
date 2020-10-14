<template>
  <div>
    <form action="" id="flight-information">
      <label for="student">Student: </label>
      <input type="text" id="student" v-model="student">

      <label for="instructor-name">Level of Training: </label>
      <input type="text" id="level-of-training" v-model="levelOfTraining">

      <label for="tc-exercise">TC Excersise: </label>
      <select name="" id="" multiple v-model="exercisesSelected">
        <option v-for="exercise in exercises" :value="exercise.name" :key="exercise.id">{{ exercise.name }}</option>
      </select>

      <label for="aircraft">Aircraft: </label>
      <select name="" id="" v-model="selectedAircraft">
        <option v-for="aircraft in aircraft" :value="aircraft.registration" :key="aircraft.registration">{{ aircraft.registration }}</option>
      </select>

      <label for="comments">Comments: </label>
      <textarea name="" id="comments" cols="30" rows="10" v-model="comments"></textarea>
    </form>
    <button @click="save" :disabled="saveButtonDisabled">Done</button>
    <button @click="$emit('cancel-form')">Cancel</button>
  </div>
</template>

<script>
import aircraftData from '@/data/aircraft';
import exerciseData from '@/data/exercise';

export default {
  name: 'FlightCard',
  computed: {
    aircraft() {
      return aircraftData.aircraft;
    },
    exercises() {
      return exerciseData.exercises;
    },
    saveButtonDisabled () {
      return this.student == null || this.levelOfTraining == null || this.exercisesSelected == null || this.selectedAircraft == null || this.comments == null;
    }
  },
  data() {
    return {
      student: null,
      levelOfTraining: null,
      exercisesSelected: [],
      selectedAircraft: null,
      comments: null
    }
  },
  methods: {
    save() {
      this.$emit('save-form', { student: this.student, levelOfTraining: this.levelOfTraining, exercises: this.exercisesSelected, aircraft: this.selectedAircraft, comments: this.comments });
    }
  }
}
</script>

<style>

</style>