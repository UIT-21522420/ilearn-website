using ILEARN.Models;
using Microsoft.AspNetCore.Mvc;
using System.Diagnostics;
using System.Drawing.Printing;

namespace ILEARN.Controllers
{
    public class LecturerController : Controller
    {
        public IActionResult Index(int ID)
        {
            using IlearnDbContext db = new();
            var lecturer = db.Lecturers.FirstOrDefault(m => m.Id == ID);
            return View(lecturer);
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
        public IActionResult LecturerList()
        {
            if (FunctionCheck(1) == false)
            {
                //báo không có quyền
                return RedirectToAction("NoPrivilege", "Error");
            }

            using IlearnDbContext db = new();
            var items = db.Lecturers.OrderBy(x => x.Id).ToList();
            return View(items);
        }

        public IActionResult AddLecturer()
        {
            if (FunctionCheck(2) == false)
            {
                //báo không có quyền
                return RedirectToAction("NoPrivilege", "Error");
            }

            return View();
        }

        [HttpPost]
        [ActionName("AddNewLecturer")]
        public IActionResult AddNewLecturer(string name, string email, string description, string phone, string img)
        {
            IlearnDbContext db = new();
            Lecturer lecturer = new() { LecturerName = name, Email = email, Description = description, Phone = phone, Img = img };
            db.Lecturers.Add(lecturer);
            db.SaveChanges();
            TempData["message"] = "Thêm thành công.";
            return RedirectToAction("LecturerList");
        }

        public IActionResult UpdateLecturer(int ID)
        {
            if (FunctionCheck(3) == false)
            {
                //báo không có quyền
                return RedirectToAction("NoPrivilege", "Error");
            }
            using IlearnDbContext db = new();
            var lecturer = db.Lecturers.FirstOrDefault(m => m.Id == ID);
            return View(lecturer);
        }

        [HttpPost]
        public IActionResult UpdateCurrentLecturer(int ID, string name, string email, string description, string phone, string img)
        {
            using IlearnDbContext db = new();
            Lecturer lecturer = db.Lecturers.Find(ID);

            lecturer.Description = description;
            lecturer.Phone = phone;
            lecturer.Img = img;

            db.SaveChanges();

            TempData["message"] = "Cập nhật thành công.";
            return RedirectToAction("LecturerList");
        }

        public IActionResult DeleteLecturer(int ID)
        {
            if (FunctionCheck(4) == false)
            {
                //báo không có quyền
                return RedirectToAction("NoPrivilege", "Error");
            }

            using IlearnDbContext db = new();
            var lecturer = db.Lecturers.Find(ID);
            db.Lecturers.Remove(lecturer);
            db.SaveChanges();
            TempData["message"] = "Xoá thành công.";
            return RedirectToAction("LecturerList");
        }
    }
}