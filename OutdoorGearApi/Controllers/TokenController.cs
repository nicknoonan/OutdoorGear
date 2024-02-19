using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.IdentityModel.Tokens;
using NuGet.Protocol;
using OutdoorGearApi.Models;
using OutdoorGearApi.Models.Entity;
using OutdoorGearApi.Models.Request;
using System.Configuration;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Cryptography;
using System.Text;
using Microsoft.EntityFrameworkCore;
using System.Security.Claims;
using System.Security.Principal;
using IdentityModel;
using Azure.Core;

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

        private string createToken(User user)
        {
            var tokenHandler = new JwtSecurityTokenHandler();
            byte[] key = Encoding.UTF8.GetBytes(_configuration["JwtSettings:Key"]!);
            SigningCredentials signingCredentials = new SigningCredentials(new SymmetricSecurityKey(key), "http://www.w3.org/2001/04/xmldsig-more#hmac-sha256");
            Guid id = Guid.NewGuid();
            SecurityTokenDescriptor tokenDescriptor = new SecurityTokenDescriptor
            {
                Expires = tokenLifetime,
                SigningCredentials = signingCredentials,
                Audience = _configuration["JwtSettings:Audience"]!,
                Issuer = _configuration["JwtSettings:Issuer"],
                Subject = new ClaimsIdentity(),
                Claims =
                {
                    { "id", id.ToString() }
                }
            };
            SecurityToken securityToken = tokenHandler.CreateToken(tokenDescriptor);
            Token token = new Token()
            {
                Id = id,
                UserId = user.Id
            };
            //_context.Token;
            return tokenHandler.WriteToken(securityToken);
        }

        private async Task<Token?> refreshToken(string token)
        {
            TokenValidationParameters tokenValidationParameters = new TokenValidationParameters
            {
                ValidateAudience = false,
                ValidateIssuer = false,
                ValidateIssuerSigningKey = true,
                IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(_configuration["JwtSettings:Key"]!)),
                ValidateLifetime = false
            };
            JwtSecurityTokenHandler tokenHandler = new JwtSecurityTokenHandler();
            try
            {

                ClaimsPrincipal claim = tokenHandler.ValidateToken(token, tokenValidationParameters, out SecurityToken validatedToken);
                if (validatedToken != null && claim != null)
                {
                    Guid id = Guid.Parse(claim.FindFirstValue("id")!);
                    Token oldToken = await _context.Tokens.SingleAsync(t => t.Id == id);
                    Token newToken = new Token
                    {
                        Id = id,
                        UserId = oldToken.UserId,
                        IsValid = true
                    };
                    await _context.Tokens.AddAsync(newToken);
                    _context.Tokens.Remove(oldToken);
                    await _context.SaveChangesAsync();
                    return newToken;
                }
            }
            catch
            {
                return null;
            }
            return null;
        }


        [HttpPost]
        [Route("create")]
        public async Task<ActionResult<string>> PostCreateToken(CreateTokenRequest request)
        {
            User? user = await _context.GearUsers.SingleOrDefaultAsync(user => user.Email == request.Email);
            if (user == null)
            {
                return BadRequest();
            }
            else
            {
                string passwordHash = HashPassword.Hash(request.Password);
                if (passwordHash == user.HMACSHA256)
                {
                    return Ok(createToken(user));
                }
                else
                {
                    return BadRequest();
                }
            }
        }

        [HttpPost]
        [Route("refresh")]
        public async Task<ActionResult<string>> PostRefreshToken(RefreshTokenRequest request)
        {
            Token? token = await refreshToken(request.Token);
            if (token == null)
            {
                return BadRequest();
            }
            else
            {
                return Ok(token);
            }
        }
    }
}
