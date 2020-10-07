import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { LayoutComponent} from "./layout.component";

const routes: Routes = [
  {
    path: '', component: LayoutComponent,
    children: [
      { path:'', redirectTo: 'dashboard', pathMatch:'prefix'},
      {
        path: 'dashboard', loadChildren:() => import('./dashboard/dashboard.module').then(
          (m)=> m.DashboardModule)
      },
      {
        path: 'productos', loadChildren:() => import('./productos/productos.module').then(
          (m)=> m.ProductosModule)
      },
     {
       path: 'registrar', loadChildren: () => import('./registrar/registrar.module').then(
         (m) => m.RegistrarModule)
     },
      {
        path: 'ventas', loadChildren:() => import('./ventas/ventas.module').then(
          (m)=> m.VentasModule)
      },
      {
        path: 'AP', loadChildren:() => import('./registrar-producto/registrar-producto.module').then(
          (m)=> m.RegistrarProductoModule)
      },
      {
        path: 'agotar', loadChildren:() => import('./productos-agotar/productos-agotar.module').then(
          (m)=> m.ProductosAgotarModule)
      },
      {
        path: 'agregar-venta', loadChildren: () => import('./agregar-venta/agregar-venta.module').then(
          (m) => m.AgregarVentaModule)
      },
      {
        path: 'punto-venta', loadChildren: () => import('./punto-venta/punto-venta.module').then(
          (m) => m.PuntoVentaModule)
      },
      {
        path: 'lector', loadChildren: () => import('./lector/lector.module').then(
          (m) => m.LectorModule)
      }

    ]

  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class LayoutRoutingModule { }
