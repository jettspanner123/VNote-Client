

interface Workout {
    id: String,
    userId: String,
    name: String,
    exercises: Array<String>,
}

interface User {
    id: String,
    name: String,
    workoutId: String,
}
