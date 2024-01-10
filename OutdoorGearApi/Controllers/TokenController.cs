using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.IdentityModel.Tokens;
using NuGet.Protocol;
using OutdoorGearApi.Models;
using OutdoorGearApi.Shared;
using OutdoorGearApi.Models.Entity;
using OutdoorGearApi.Models.Request;
using System.Configuration;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Cryptography;
using System.Text;
using Microsoft.EntityFrameworkCore;

namespace OutdoorGearApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class TokenController : ControllerBase
    {
        private readonly GearDbContext _context;
        private static readonly DateTime tokenLifetime = DateTime.Now.AddHours(12);
        private readonly IConfiguration _configuration;

        public TokenController(GearDbContext context, IConfiguration configuration)
        {
            _context = context;
            _configuration = configuration;
        }

        private string createToken(CreateTokenRequest request)
        {
            var tokenHandler = new JwtSecurityTokenHandler();
            byte[] key = Encoding.UTF8.GetBytes(_configuration["JwtSettings:Key"]!);
            SigningCredentials signingCredentials = new SigningCredentials(new SymmetricSecurityKey(key), "http://www.w3.org/2001/04/xmldsig-more#hmac-sha256");
            SecurityTokenDescriptor tokenDescriptor = new SecurityTokenDescriptor
            {
                Expires = tokenLifetime,
                SigningCredentials = signingCredentials,
                Audience = _configuration["JwtSettings:Audience"]!,
                Issuer = _configuration["JwtSettings:Issuer"]
            };
            SecurityToken token = tokenHandler.CreateToken(tokenDescriptor);
            return tokenHandler.WriteToken(token);
        }
        [HttpPost]
        public async Task<ActionResult<string>> PostCreateToken(CreateTokenRequest request)
        {
            User user = await _context.GearUsers.SingleAsync(user => user.Email == request.Email);
            if (user == null)
            {
                return BadRequest();
            }
            else
            {
                string passwordHash = HashPassword.Hash(request.Password);
                if (passwordHash == user.HMACSHA256)
                {
                    return Ok(createToken(request));
                }
                else
                {
                    return BadRequest();
                }
            }
        }
    }
}
