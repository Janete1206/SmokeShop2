import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import {AuthGuard} from "./shared";


const routes: Routes = [
  {
    path: '',
    loadChildren: () => import('./layout/layout.module').then((m) => m.LayoutModule),
    canActivate: [AuthGuard]
  },
  { path: '', redirectTo: 'login', pathMatch: 'full'},
  { path: 'login', loadChildren: () => import('./login/login.module').then((m) => m.LoginModule) },
  { path: 'registrar', loadChildren: () => import('./layout/registrar/registrar.module').then((m) => m.RegistrarModule) },
  { path: 'dashboard', loadChildren: () => import('./layout/dashboard/dashboard.module').then((m) => m.DashboardModule)},
  { path: 'productos', loadChildren: () => import('./layout/productos/productos.module').then((m) => m.ProductosModule)},
  { path: 'ventas', loadChildren: () => import('./layout/ventas/ventas.module').then((m) => m.VentasModule)},
  { path: 'AP', loadChildren: () => import('./layout/registrar-producto/registrar-producto.module').then((m) => m.RegistrarProductoModule)},
  { path: 'agotar', loadChildren: () => import('./layout/productos-agotar/productos-agotar.module').then((m) => m.ProductosAgotarModule)},
  { path: 'agregar-venta', loadChildren: () => import('./layout/agregar-venta/agregar-venta.module').then((m) => m.AgregarVentaModule)},
  { path: 'perfil', loadChildren: () => import('./layout/perfil/perfil.module').then((m) => m.PerfilModule)},
  {
    path: 'punto-venta', loadChildren: () => import('./layout/punto-venta/punto-venta.module').then(
      (m) => m.PuntoVentaModule)
  },
  { path: 'password_recovery', loadChildren: () => import('./password_recovery/password_recovery.module').then((m) => m.Password_recoveryModule) },
  {
    path: 'lector', loadChildren: () => import('./layout/lector/lector.module').then(
      (m) => m.LectorModule)
  },
  {
    path: 'ganancias', loadChildren: () => import('./layout/ganancias/ganancias.module').then(
      (m) => m.GananciasModule)
  }

];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
