﻿using System.Linq;
using WebApiBomberos.Components;

namespace WebApiBomberos.components
{
    public static class QueryableExtensions
    {
        public static IQueryable<T> Paginar<T>(this IQueryable<T> queryable, Paginate paginacion)
        {
            return queryable
                .Skip((paginacion.pagina - 1) * paginacion.cantidadMostrar)
                .Take(paginacion.cantidadMostrar);
        }
    }
}
