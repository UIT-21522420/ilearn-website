using ILEARN.Models;
using Microsoft.AspNetCore.Mvc;
using System.Diagnostics;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Authorization;
using System.Linq;

namespace ILEARN.Controllers
{
    public class HomeController : Controller
    {
        public IActionResult Index()
        {
            using IlearnDbContext db = new();
            var items = db.Courses.OrderBy(x => x.Id).ToList();
            return View(items);
        }

        public IActionResult UserProfile(int ID)
        {
            using IlearnDbContext db = new();
            Student user = db.Students.FirstOrDefault(m => m.AccountId == ID);
            return View(user);
        }

        public IActionResult RegisteredCourses(int ID)
        {
            using IlearnDbContext db = new();
            var shoppingSession = db.ShoppingSessions.Where(m=>m.AccountId == ID).ToList();
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
                return View(courseList);
            }
            return View();
        }

        public async Task<IActionResult> Logout()
        {
            await HttpContext.SignOutAsync(CookieAuthenticationDefaults.AuthenticationScheme);
            return RedirectToAction("Index");
        }
    }
}
