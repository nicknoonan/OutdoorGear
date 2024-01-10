using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using OutdoorGearApi.Models;
using OutdoorGearApi.Models.Entity;

namespace OutdoorGearApi.Controllers
{
    [Authorize]
    [Route("api/[controller]")]
    [ApiController]
    public class GearController : ControllerBase
    {
        private readonly GearDbContext _context;

        public GearController(GearDbContext context)
        {
            _context = context;
        }

        // GET: api/Gear
        [HttpGet]
        public async Task<ActionResult<IEnumerable<Gear>>> GetGear()
        {
            return await _context.Gear.ToListAsync();
        }

        // GET: api/Gear/5
        [HttpGet("{id}")]
        public async Task<ActionResult<Gear>> GetGear(Guid id)
        {
            var gear = await _context.Gear.FindAsync(id);

            if (gear == null)
            {
                return NotFound();
            }

            return gear;
        }

        // PUT: api/Gear/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutGear(Guid id, Gear gear)
        {
            if (id != gear.Id)
            {
                return BadRequest();
            }

            _context.Entry(gear).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!GearExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return NoContent();
        }

        // POST: api/Gear
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<Gear>> PostGear(Gear gear)
        {
            _context.Gear.Add(gear);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetGear", new { id = gear.Id }, gear);
        }

        // DELETE: api/Gear/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteGear(Guid id)
        {
            var gear = await _context.Gear.FindAsync(id);
            if (gear == null)
            {
                return NotFound();
            }

            _context.Gear.Remove(gear);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool GearExists(Guid id)
        {
            return _context.Gear.Any(e => e.Id == id);
        }
    }
}
