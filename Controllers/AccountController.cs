using ILEARN.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace ILEARN.Controllers
{
    public class AccountController : Controller
    {
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

        public IActionResult AccountList()
        {
            if (FunctionCheck(9) == false)
            {
                //báo không có quyền
                return RedirectToAction("NoPrivilege", "Error");
            }

            using IlearnDbContext db = new IlearnDbContext();
            var accountList = db.Lecturers.Include(m => m.Account).Where(m => m.Account.Role == 3).ToList();
            return View(accountList);
        }

        public IActionResult UpdateAccountStatus(int ID)
        {
            if (FunctionCheck(11) == false)
            {
                //báo không có quyền
                return RedirectToAction("NoPrivilege", "Error");
            }
            using IlearnDbContext db = new();
            var account = db.Lecturers.Include(m => m.Account).FirstOrDefault(m => m.Account.Role == 3);
            return View(account);
        }

        [HttpPost]
        public IActionResult UpdateAccountStatus(int ID, string status)
        {
            using IlearnDbContext db = new();
            Account account = db.Accounts.Find(ID);

            if (status == "true")
            {
                account.UserStatus = 1;
                account.Role = 2;
                db.SaveChanges();

                TempData["message"] = "Cập nhật thành công.";
            }
            return RedirectToAction("AccountList");
        }

        public IActionResult DeleteLecturer(int ID)
        {
            if (FunctionCheck(12) == false)
            {
                //báo không có quyền
                return RedirectToAction("NoPrivilege", "Error");
            }

            using IlearnDbContext db = new();
            var account = db.Accounts.Find(ID);
            db.Accounts.Remove(account);
            db.SaveChanges();
            TempData["message"] = "Xoá thành công.";
            return RedirectToAction("AccountList");
        }
    }
}
