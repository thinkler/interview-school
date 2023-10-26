
[TeacherSubject, StudentSection, Section, Teacher, Student, Subject, Classroom].each(&:delete_all)

5.times do |i|
  Student.create!(first_name: "Student #{i}", email: "student#{i}@example.com")
  teacher = Teacher.create!(first_name: "Teacher #{i}", last_name: "Teacher last #{i}")
  teacher.subjects << Subject.create!(name: "Subject #{i}")
  teacher.subjects << Subject.create!(name: "Alt Subject #{i}")
  Classroom.create!(name: "Classroom #{i}")
end

if ENV['sections']

  t1 = Teacher.first
  t1s1 = Section.create!(
    teacher: t1,
    subject: t1.subjects.first,
    classroom: Classroom.first,
    start_time: '10:00',
    end_time: '11:00',
    weekdays: [1, 0, 0, 0, 0, 0, 0]
  )

  t1s2 = Section.create!(
    teacher: t1,
    subject: t1.subjects.last,
    classroom: Classroom.second,
    start_time: '10:00',
    end_time: '11:00',
    weekdays: [0, 1, 1, 1, 1, 0, 0]
  )

  t2 = Teacher.second
  s2 = Section.create!(
    teacher: t2,
    subject: t2.subjects.take,
    classroom: Classroom.third,
    start_time: '10:30',
    end_time: '12:00',
    weekdays: [1, 1, 1, 1, 1, 0, 0]
  )

  t3 = Teacher.third
  s3 = Section.create!(
    teacher: t3,
    subject: t3.subjects.take,
    classroom: Classroom.second,
    start_time: '12:00',
    end_time: '13:00',
    weekdays: [1, 0, 1, 0, 1, 0, 0]
  )

  t4 = Teacher.fourth
  s4 = Section.create!(
    teacher: t4,
    subject: t4.subjects.take,
    classroom: Classroom.first,
    start_time: '12:30',
    end_time: '14:00',
    weekdays: [1, 0, 1, 0, 1, 0, 0]
  )

  StudentSection.create!(student: Student.first, section: t1s1)
  StudentSection.create!(student: Student.first, section: s4)

  StudentSection.create!(student: Student.second, section: s2)
  StudentSection.create!(student: Student.second, section: s4)
end
