using ILEARN.Models;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace ILEARN.Controllers
{
    public class HomeLecturerController : Controller
    {
        public IActionResult Index() { return View(); }
        public IActionResult CourseList(int ID)
        {
            using IlearnDbContext db = new IlearnDbContext();
            var lecturer = db.Lecturers.FirstOrDefault(m=>m.AccountId == ID);
            var courseList = db.Courses.Include(m=>m.Category).Where(item => item.LecturerId == lecturer.Id).ToList();
            return View(courseList);
        }

        public IActionResult ChangePassword()
        {
            return View();
        }

        [HttpPost]
        public IActionResult ChangePassword(string password1, string password2, int ID)
        {
            if (password1 != password2)
            {
                TempData["error"] = "Mật khẩu không trùng nhau";
                return RedirectToAction("ChangePassword");
            }
            using IlearnDbContext db = new IlearnDbContext();
            var account = db.Accounts.Find(ID);
            account.Password = password1;
            db.SaveChanges();
            TempData["message"] = "Cập nhật thành công.";
            return RedirectToAction("Index");
        }
    }
}
