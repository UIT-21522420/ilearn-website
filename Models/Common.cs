namespace ILEARN.Models
{
    public class Common
    {
        public static Course GetCourseByID(int id)
        {
            using IlearnDbContext db = new();
            return db.Courses.FirstOrDefault(item => item.Id == id);
        }
        public static string GetLecturerNameFromCourse(Course course)
        {
            using IlearnDbContext db = new();
            return db.Lecturers.First(p => p.Id == course.LecturerId).LecturerName;
        }

        public static Lecturer GetLecturerFromID(Course course)
        {
            using IlearnDbContext db = new();
            return db.Lecturers.First(p => p.Id == course.LecturerId);
        }

        public static Student GetStudentByID(int id)
        {
            using IlearnDbContext db = new();
            return db.Students.FirstOrDefault(item => item.AccountId == id);
        }

        public static int GetCourseTeachedNumber(Lecturer lecturer)
        {
            using IlearnDbContext db = new();
            return db.Courses.Count(m => m.LecturerId == lecturer.Id);
        }

        public static List<Course> GetCourseTeachedByLecturer(Lecturer lecturer)
        {
            using IlearnDbContext db = new();
            List<Course> courseList = db.Courses.Where(p => p.LecturerId == lecturer.Id).OrderBy(p => p.CourseName).ToList();
            return courseList;
        }

        public static decimal GetTotal(List<int> courseIDs)
        {
            decimal total = 0;
            using IlearnDbContext db = new();
            foreach (var courseID in courseIDs)
            {
                var temp = db.Courses.FirstOrDefault(m => m.Id == courseID);
                if (temp.DiscountPrice != null)
                {
                    total += (decimal)temp.DiscountPrice;
                }     
            }
            return total;
        }

        public static List<int>? GetRegisteredCourses(int ID)
        {
            using IlearnDbContext db = new();
            var shoppingSession = db.ShoppingSessions.Where(m => m.AccountId == ID).ToList();
            List<int> courseList = new List<int>();
            if (shoppingSession != null)
            {

                foreach (var session in shoppingSession)
                {
                    var courses = db.Carts.Where(m => m.SessionId == session.Id)
                                            .Select(m => m.CourseId)
                                            .ToList();
                    courseList.AddRange(courses);
                }
                return courseList;
            }
            return null;
        }

        public static List<Lecturer> GetLecturers()
        {
            using IlearnDbContext db = new();
            var lecturers = db.Lecturers.ToList();
            return lecturers;
        }

        public static List<Category> GetCategories()
        {
            using IlearnDbContext db = new();
            var items = db.Categories.ToList();
            return items;
        }
    }
}
