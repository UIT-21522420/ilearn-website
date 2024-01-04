using Azure.Core;
using ILEARN.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Diagnostics;

namespace ILEARN.Controllers
{
    public class HomeAdminController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }

        public IActionResult Transaction()
        {
            using IlearnDbContext db = new IlearnDbContext();
            var shoppingSession = db.ShoppingSessions.Include(c => c.Carts).Include(c => c.Account).ToList();
            return View(shoppingSession);
        }

        public IActionResult GetShoppingSessionDetails(int ID)
        {
            using IlearnDbContext db = new IlearnDbContext();
            var cartDetail = db.Carts.Include(m => m.Course).Where(m => m.SessionId == ID).ToList();
            return View(cartDetail);
        }

        public IActionResult Decentralization()
        {
            using (IlearnDbContext db = new IlearnDbContext())
            {
                List<Lecturer> lecturers = db.Lecturers
                    .Include(l => l.Account)
                    .Where(l => l.Account.Role == 2)
                    .ToList();

                List<FunctionT> functions = db.FunctionTs.Where(f => !f.FunctionName.Contains("Tài khoản:") && !f.FunctionName.Contains("Giảng viên:")).ToList();
                List<Decentralization> decentralizations = db.Decentralizations.ToList();
                List<DecentralizationViewModel> viewModelList = new List<DecentralizationViewModel>();

                // Iterate through each lecturer
                foreach (var lecturer in lecturers)
                {
                    var viewModel = new DecentralizationViewModel
                    {
                        AccountID = lecturer.AccountId,
                        LecturerName = lecturer.LecturerName
                    };

                    foreach (var function in functions)
                    {
                        var decentralization = decentralizations.FirstOrDefault(d => d.AccountId == lecturer.AccountId && d.FunctionId == function.Id);
                        viewModel.FunctionPermissions.Add(function.Id, decentralization != null);
                    }
                    viewModelList.Add(viewModel);
                }
                return View(viewModelList);
            }
        }


        [HttpPost]
        public IActionResult UpdateDecentralization(int accountId, int functionId, bool isChecked)
        {
            using IlearnDbContext db = new IlearnDbContext();
            if (isChecked)
            {
                var newDecentralization = new Decentralization
                {
                    AccountId = accountId,
                    FunctionId = functionId
                };
                db.Decentralizations.Add(newDecentralization);
            }
            else
            {
                var existingDecentralization = db.Decentralizations
                    .FirstOrDefault(d => d.AccountId == accountId && d.FunctionId == functionId);

                if (existingDecentralization != null)
                {
                    db.Decentralizations.Remove(existingDecentralization);
                }
            }

            db.SaveChanges();

            return Ok();
        }

        [HttpPost]
        public ActionResult Report(int year)
        {
            using IlearnDbContext db = new();
            var data = db.ShoppingSessions
                .Where(session => session.CreatedAt.Year == year)
                .GroupBy(session => session.CreatedAt.Month)
                .Select(group => new
                {
                    y = group.Key.ToString(),
                    a = group.Sum(session => session.Total)
                })
                .ToList();

            return Json(data);
        }
    }
}