using ILEARN.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Globalization;
using System.Linq;
using System.Text;

namespace ILEARN.Controllers
{
    public class CourseController : Controller
    {
        public IActionResult Index(int? page)
        {
            using IlearnDbContext db = new();
            //var pageSize = 20;
            //var pageIndex = page ?? 1;
            var items = db.Courses.OrderBy(x => x.Id).ToList();
            return View(items);
        }

        public IActionResult GetCourse(int ID)
        {
            using IlearnDbContext db = new();
            var course = db.Courses.FirstOrDefault(m => m.Id == ID);
            if (course == null)
            {
                return RedirectToAction("NullPage", "Error");
            }
            else
            {
                return View(course);
            }
        }

        public IActionResult PriceIncreased(int? page)
        {
            using IlearnDbContext db = new();
            //var pageSize = 20;
            //var pageIndex = page ?? 1;
            var items = db.Courses.OrderBy(x => x.CoursePrice).ToList();
            return View(items);
        }

        public IActionResult PriceDecreased(int? page)
        {
            using IlearnDbContext db = new();
            //var pageSize = 20;
            //var pageIndex = page ?? 1;
            var items = db.Courses.OrderByDescending(x => x.CoursePrice).ToList();
            return View(items);
        }

        [HttpGet]
        public IActionResult Search(string search, int? page)
        {
            using IlearnDbContext db = new();
            //var pageSize = 20;
            //var pageIndex = page ?? 1;
            var items = db.Courses
                .AsEnumerable()
                .Where(c => RemoveDiacritics(c.CourseName.ToLower()).Contains(RemoveDiacritics(search.ToLower())))
                .OrderBy(c => c.Id)
                .ToList();
            TempData["count"] = items.Count;
            TempData["value"] = search;
            return View(items);
        }

        private static string RemoveDiacritics(string text)
        {
            var normalizedString = text.Normalize(NormalizationForm.FormD);
            var stringBuilder = new System.Text.StringBuilder();

            foreach (char c in normalizedString)
            {
                var unicodeCategory = CharUnicodeInfo.GetUnicodeCategory(c);
                if (unicodeCategory != UnicodeCategory.NonSpacingMark)
                {
                    stringBuilder.Append(c);
                }
            }

            return stringBuilder.ToString().Normalize(NormalizationForm.FormC);
        }

        public bool FunctionCheck(int functionID)
        {
            using IlearnDbContext db = new();
            var userName = TempData["user"]?.ToString()?.Trim();
            var gv = db.Accounts.First(item => item.Username == userName);
            if (gv != null)
            {
                int count = db.Decentralizations.Count(m => m.AccountId == gv.Id && m.FunctionId == functionID);
                if (count == 0)
                {
                    //báo không có quyền
                    return false;
                }
                else
                {
                    return true;
                }
            }

            return false;
        }

        public IActionResult CourseList()
        {
            if (FunctionCheck(5) == false)
            {
                //báo không có quyền
                return RedirectToAction("NoPrivilege", "Error");
            }

            using IlearnDbContext db = new IlearnDbContext();
            var courseList = db.Courses.Include(c => c.Lecturer).Include(c => c.Category).ToList();
            return View(courseList);
        }

        public IActionResult AddCourse()
        {
            if (FunctionCheck(6) == false)
            {
                //báo không có quyền
                return RedirectToAction("NoPrivilege", "Error");
            }

            return View();
        }

        [HttpPost]
        public IActionResult AddNewCourse(string name, decimal price, decimal discountPrice, int discount, int lecturesCount, string introduction, string description, int lecturerID, int categoryID)
        {
            IlearnDbContext db = new();
            Course course = new() { CourseName = name, CoursePrice = price, Description = description, DiscountPrice = discountPrice, Discount = discount, NumberOfLectures = lecturesCount, Introduction = introduction, LecturerId = lecturerID, CategoryId = categoryID };
            db.Courses.Add(course);
            db.SaveChanges();
            TempData["message"] = "Thêm thành công.";
            return RedirectToAction("CourseList");
        }

        public IActionResult UpdateCourse(int ID)
        {
            if (FunctionCheck(7) == false)
            {
                //báo không có quyền
                return RedirectToAction("NoPrivilege", "Error");
            }
            using IlearnDbContext db = new();
            var course = db.Courses.FirstOrDefault(m => m.Id == ID);
            return View(course);
        }

        [HttpPost]
        public IActionResult UpdateCurrentCourse(int ID, string name, decimal price, decimal discountPrice, int discount, int lecturesCount, string introduction, string description, int lecturerID, int categoryID)
        {
            using IlearnDbContext db = new();
            Course course = db.Courses.Find(ID);

            course.CourseName = name;
            course.CoursePrice = price;
            course.DiscountPrice = discountPrice;
            course.Discount = discount;
            course.NumberOfLectures = lecturesCount;
            course.Description = description;
            course.Introduction = introduction;
            course.LecturerId = lecturerID;
            course.CategoryId = categoryID;

            db.SaveChanges();

            TempData["message"] = "Cập nhật thành công.";
            return RedirectToAction("CourseList");
        }

        public IActionResult DeleteCourse(int ID)
        {
            if (FunctionCheck(8) == false)
            {
                //báo không có quyền
                return RedirectToAction("NoPrivilege", "Error");
            }

            using IlearnDbContext db = new();
            var course = db.Courses.Find(ID);
            db.Courses.Remove(course);
            db.SaveChanges();
            TempData["message"] = "Xóa thành công.";
            return RedirectToAction("CourseList");
        }
    }
}