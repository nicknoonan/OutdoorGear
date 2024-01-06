using Microsoft.EntityFrameworkCore;
using Microsoft.AspNetCore.Http.HttpResults;
using Microsoft.AspNetCore.OpenApi;
using OutdoorGearApi.Models;
using OutdoorGearApi.Models.Entity;
using OutdoorGearApi.Models.Request;
namespace OutdoorGearApi.Controllers;

public static class GearEndpoints
{
    public static void MapGearEndpoints (this IEndpointRouteBuilder routes)
    {
        var group = routes.MapGroup("/api/Gear").WithTags(nameof(Gear));

        group.MapGet("/", async (GearDbContext db) =>
        {
            return await db.Gear.ToListAsync();
        })
        .WithName("GetAllGear")
        .WithOpenApi();

        group.MapGet("/{id}", async Task<Results<Ok<Gear>, NotFound>> (Guid id, GearDbContext db) =>
        {
            return await db.Gear.AsNoTracking()
                .FirstOrDefaultAsync(model => model.Id == id)
                is Gear model
                    ? TypedResults.Ok(model)
                    : TypedResults.NotFound();
        })
        .WithName("GetGearById")
        .WithOpenApi();

        group.MapPut("/{id}", async Task<Results<Ok, NotFound, BadRequest>> (Guid id, Gear gear, GearDbContext db) =>
        {
            if (id != gear.Id) { return TypedResults.BadRequest(); }
            var affected = await db.Gear
                .Where(model => model.Id == id)
                .ExecuteUpdateAsync(setters => setters
                    .SetProperty(m => m.Id, gear.Id)
                    .SetProperty(m => m.Name, gear.Name)
                    .SetProperty(m => m.Brand, gear.Brand)
                    .SetProperty(m => m.Weight, gear.Weight)
                    .SetProperty(m => m.Type, gear.Type)
                    .SetProperty(m => m.Category, gear.Category)
                    .SetProperty(m => m.Description, gear.Description)
                    .SetProperty(m => m.Tags, gear.Tags)
                    );
            return affected == 1 ? TypedResults.Ok() : TypedResults.NotFound();
        })
        .WithName("UpdateGear")
        .WithOpenApi();

        group.MapPost("/", async (Gear gear, GearDbContext db) =>
        {
            //Gear gear = postGearRequest.toGear();
            db.Gear.Add(gear);
            await db.SaveChangesAsync();
            return TypedResults.Created($"/api/Gear/{gear.Id}",gear);
        })
        .WithName("CreateGear")
        .WithOpenApi();

        group.MapDelete("/{id}", async Task<Results<Ok, NotFound>> (Guid id, GearDbContext db) =>
        {
            var affected = await db.Gear
                .Where(model => model.Id == id)
                .ExecuteDeleteAsync();
            return affected == 1 ? TypedResults.Ok() : TypedResults.NotFound();
        })
        .WithName("DeleteGear")
        .WithOpenApi();
    }
}
