using ILEARN.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System.Diagnostics;
using System.Net;
using System.Security.Claims;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Authorization;

namespace ILEARN.Controllers
{
    public class AuthenticationController : Controller
    {
        public IActionResult Signin()
        {
            ClaimsPrincipal claimUser = HttpContext.User;

            if (claimUser != null && claimUser.Identity.IsAuthenticated)
            {
                return RedirectToAction("Index", "Home");
            }
            else
            {
                return View();
            }
        }


        [HttpPost]
        public async Task<IActionResult> SignIn(VMLogin modelLogin)
        {
            if (!ModelState.IsValid)
            {
                return View();
            }

            IlearnDbContext db = new();
            var account = db.Accounts.FirstOrDefault(m => m.Username == modelLogin.Email && m.Password == modelLogin.Password);
            
            if (account != null)
            {
                TempData["user"] = modelLogin.Email;

                if (account.Role == 0)
                {
                    return RedirectToAction("Index", "HomeAdmin");
                }
                else
                {
                    List<Claim> claims = new()
                    {
                        new Claim(ClaimTypes.NameIdentifier, (string)account.Id.ToString()),
                        new Claim(ClaimTypes.Name, modelLogin.Email),
                        new Claim("id", account.Id.ToString(), ClaimValueTypes.Integer),
                        new Claim("role", account.Role.ToString(), ClaimValueTypes.Integer),
                    };

                    ClaimsIdentity claimsIdentity = new(claims,
                        CookieAuthenticationDefaults.AuthenticationScheme
                    );

                    foreach (var claim in claims)
                    {
                        Console.WriteLine($"{claim.Type}: {claim.Value}");
                    }

                    AuthenticationProperties properties = new()
                    {
                        AllowRefresh = true,
                        IsPersistent = modelLogin.KeepLoggedIn
                    };

                    await HttpContext.SignInAsync(CookieAuthenticationDefaults.AuthenticationScheme,
                        new ClaimsPrincipal(claimsIdentity), properties);

                    if (account.Role == 2 || account.Role == 3)
                    {
                        return RedirectToAction("Index", "HomeLecturer", account.Id);
                    }
                    return RedirectToAction("Index", "Home");
                }
            }
            else
            {
                TempData["error"] = "Tài khoản đăng nhập không đúng !";
                return RedirectToAction("Signin");
            }
        }

        public IActionResult Signup()
        {
            return View();
        }

        [HttpPost]
        public IActionResult SignUp(string name, string username, string phone, string password1, string password2)
        {
            IlearnDbContext db = new();
            if (password1 != password2)
            {
                Account account = new() { Username = username, Password = password1, Role = 1, UserStatus = 1};
                db.Accounts.Add(account);
                db.SaveChanges();
                Account acc = db.Accounts.First(a => a.Username == username);
                Student student = new() { Email = username, Name = name, Phone = phone, AccountId = acc.Id };
                db.Students.Add(student);
                db.SaveChanges();
                return RedirectToAction("Signin", "Authentication");
            }
            else
            {
                TempData["error"] = "Mật khẩu không giống nhau.";
                return RedirectToAction("Signup");
            }
        }

        public IActionResult SignUpForLecturer()
        {
            return View();
        }

        [HttpPost]
        public IActionResult SignUpForLecturer(string name, string username, string phone, string password1, string password2)
        {
            IlearnDbContext db = new();
            if (password1 != password2)
            {
                Account account = new() { Username = username, Password = password1, Role = 3, UserStatus = 0 };
                db.Accounts.Add(account);
                db.SaveChanges();
                Account acc = db.Accounts.First(a => a.Username == username);
                Lecturer lecturer = new() { Email = username, LecturerName = name, Phone = phone, AccountId = acc.Id };
                db.Lecturers.Add(lecturer);
                db.SaveChanges();
                return RedirectToAction("Signin", "Authentication");
            }
            else
            {
                TempData["error"] = "Mật khẩu không giống nhau.";
                return RedirectToAction("Signup");
            }
        }
    }
}