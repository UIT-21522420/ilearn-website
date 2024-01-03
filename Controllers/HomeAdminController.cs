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
                // Retrieve accounts with role == 2 and include related Lecturer data
                List<Lecturer> lecturers = db.Lecturers
                    .Include(l => l.Account)
                    .Where(l => l.Account.Role == 2)
                    .ToList();

                // Retrieve all functions
                List<FunctionT> functions = db.FunctionTs.ToList();

                // Retrieve all decentralization records
                List<Decentralization> decentralizations = db.Decentralizations.ToList();

                // Create a list to hold the view models
                List<DecentralizationViewModel> viewModelList = new List<DecentralizationViewModel>();

                // Iterate through each lecturer
                foreach (var lecturer in lecturers)
                {
                    // Create a new view model for the lecturer
                    var viewModel = new DecentralizationViewModel
                    {
                        AccountID = lecturer.AccountId,
                        LecturerName = lecturer.LecturerName
                    };

                    // Iterate through each function
                    foreach (var function in functions)
                    {
                        // Check if there is a decentralization record for the lecturer's account and function
                        var decentralization = decentralizations.FirstOrDefault(d => d.AccountId == lecturer.AccountId && d.FunctionId == function.Id);

                        // Add the function ID and its permission status to the view model
                        viewModel.FunctionPermissions.Add(function.Id, decentralization != null);
                    }

                    // Add the view model to the list
                    viewModelList.Add(viewModel);
                }

                // Return the view with the list of view models
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
    }
}