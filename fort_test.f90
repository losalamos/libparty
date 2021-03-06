!
!* Copyright 2014.  Los Alamos National Security, LLC. This material was produced 
!* under U.S. Government contract DE-AC52-06NA25396 for Los Alamos National 
!* Laboratory (LANL), which is operated by Los Alamos National Security, LLC 
!* for the U.S. Department of Energy. The U.S. Government has rights to use, 
!* reproduce, and distribute this software.  NEITHER THE GOVERNMENT NOR 
! LOS ALAMOS NATIONAL SECURITY, LLC MAKES ANY WARRANTY, EXPRESS OR IMPLIED, 
! OR ASSUMES ANY LIABILITY FOR THE USE OF THIS SOFTWARE.  If software is 
! modified to produce derivative works, such modified software should be 
! clearly marked, so as not to confuse it with the version available from LANL.   
! 
! Licensed under the Apache License, Version 2.0 (the "License"); you may not 
! use this file except in compliance with the License. You may obtain a copy 
! of the License at http://www.apache.org/licenses/LICENSE-2.0
! 
! Unless required by applicable law or agreed to in writing, software distributed 
! under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR 
! CONDITIONS OF ANY KIND, either express or implied. See the License for the 
! specific language governing permissions and limitations under the License.
! 
!  Additionally, redistribution and use in source and binary forms, with or without
!  modification, are permitted provided that the following conditions are met:
!     * Redistributions of source code must retain the above copyright
!       notice, this list of conditions and the following disclaimer.
!     * Redistributions in binary form must reproduce the above copyright
!       notice, this list of conditions and the following disclaimer in the
!       documentation and/or other materials provided with the distribution.
!     * Neither the name of the Los Alamos National Security, LLC, Los Alamos 
!       National Laboratory, LANL, the U.S. Government, nor the names of its 
!       contributors may be used to endorse or promote products derived from 
!       this software without specific prior written permission.
!
! LibParty, Version 1.x, Copyright number C114122, LA-CC-14-086
!
! Authors:
!    Matthew Kinsey, kinsey@lanl.gov
!    Verinder Rana, vrana@lanl.gov
!    Bob Robey, XCP-2, LANL, brobey@lanl.gov
!    Jeremy Sauer, EES-16, LANL, jsauer@lanl.gov
!    Jon Reisner, XCP-4 LANL, reisner@lanl.gov
! 

! fort_test.f90
program main
  use libparty 
  use, intrinsic :: ISO_C_Binding
  type(part_sys_type) :: psys
  real(C_DOUBLE), pointer :: x(:), y(:), z(:), vx(:), vy(:), vz(:)

  real*8 :: dt
  integer :: nparts

  nparts = 10
  dt = 0.5

  call psys_new(psys,nparts)

  call psys_xptr(psys,x,nparts)
  call psys_yptr(psys,y,nparts)
  call psys_zptr(psys,z,nparts)
  call psys_vxptr(psys,vx,nparts)
  call psys_vyptr(psys,vy,nparts)
  call psys_vzptr(psys,vz,nparts)

  write(*,*) SIZE(x)

  do i = 1, nparts
         x(i) = i
         y(i) = i
         z(i) = i
         vx(i) = i
         vy(i) = i
         vz(i) = i
  end do

  write(*,*) 'Returned number of particles: ', psys_npart(psys)

  call psys_print_sys(psys)
  call psys_step(psys,dt)
  call psys_print_sys(psys)
  do i = 1, 100
    call psys_step(psys,dt)
    call psys_output_h5part(psys)
  end do

  call psys_delete(psys)
end program main
