[TeacherSubject, StudentSection, Section, Teacher, Student, Subject, Classroom].each(&:delete_all)

5.times do |i|
  Student.create!(first_name: "Student #{i}", email: "student#{i}@example.com")
  teacher = Teacher.create!(first_name: "Teacher #{i}", last_name: "Teacher last #{i}")
  teacher.subjects << Subject.create!(name: "Subject #{i}")
  Classroom.create!(name: "Classroom #{i}")
end

s1 = Section.create!(
  teacher: Teacher.first,
  subject: Teacher.first.subjects.take,
  classroom: Classroom.first,
  start_time: '10:00',
  end_time: '11:00',
  weekdays: [1, 1, 1, 1, 1, 0, 0]
)

s2 = Section.create!(
  teacher: Teacher.second,
  subject: Teacher.second.subjects.take,
  classroom: Classroom.first,
  start_time: '10:30',
  end_time: '13:00',
  weekdays: [1, 1, 1, 1, 1, 0, 0]
)

s3 = Section.create!(
  teacher: Teacher.third,
  subject: Teacher.third.subjects.take,
  classroom: Classroom.first,
  start_time: '12:00',
  end_time: '13:00',
  weekdays: [1, 0, 1, 0, 1, 0, 0]
)

s4 = Section.create!(
  teacher: Teacher.fourth,
  subject: Teacher.fourth.subjects.take,
  classroom: Classroom.first,
  start_time: '12:30',
  end_time: '15:00',
  weekdays: [1, 0, 1, 0, 1, 0, 0]
)

StudentSection.create!(student: Student.first, section: s1)
StudentSection.create!(student: Student.first, section: s4)

StudentSection.create!(student: Student.second, section: s2)
StudentSection.create!(student: Student.second, section: s4)
