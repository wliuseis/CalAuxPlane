c------------------------------------------------------
c    A simple code to calculate the auxiliary plane
c  from a given plane of the focal mechanism.
c
c  Reference:
c    Stein & Wysession (2003). An introduction to
c  seismology, earthquakes, and Earth structure.
c
c  By: Wei Liu
c  Contact: wliu92@mail.ustc.edu.cn
c  Date: 2021.04.22
c------------------------------------------------------
      program CalAuxPlane
        implicit none
        real p1,d1,l1,p2,d2,l2
        real p1a,d1a,l1a,p2a,d2a,l2a
        real sinl2,cosl2,sindp,cosdp,dpa
        real pi,deg2arc
        pi=4.0*atan2(1.0,1.0)
        deg2arc=pi/180.0
        write(*,*)"input strike, dip and rake of Plane 1:"
        read(*,*)p1,d1,l1
c       make sure strike=[0,360] dip=[0,90] rake=[0,360]
        if((d1.lt.0.0).or.(d1.gt.90.0)) then
          write(*,*)"input dip error (0<=dip<=90)! -- ",p1,d1,l1
          stop
        endif
        if(p1.lt.0.0) p1=p1+360.0
        if(p1.gt.360.0) p1=p1-360.0
        if(l1.lt.0.0) l1=l1+360.0
        if(l1.gt.360.0) l1=l1-360.0
        p1a=p1*deg2arc
        d1a=d1*deg2arc
        l1a=l1*deg2arc
        d2a=acos(sin(l1a)*sin(d1a))
        sinl2=cos(d1a)/sin(d2a)
        cosl2=-sin(d1a)/sin(d2a)*cos(l1a)
        l2a=atan2(sinl2,cosl2)
        sindp=cos(l1a)/sin(d2a)
        cosdp=-1.0/(tan(d1a)*tan(d2a))
        dpa=atan2(sindp,cosdp)
        p2a=p1a-dpa
        p2=p2a/deg2arc
        d2=d2a/deg2arc
        l2=l2a/deg2arc
        if((d2.gt.90.0).and.(d2.lt.180.0))then
          p2=180.0+p2
          d2=180.0-d2
          l2=360.0-l2
        endif
        if(p2.gt.360.0) p2=p2-360.0
        if(p2.lt.0.0) p2=p2+360.0
        if((l2.gt.180.0).and.(l2.lt.360.0)) l2=l2-360.0
        write(*,'(a,3(1x,f7.2))')"Plane 1: ",p1,d1,l1
        write(*,'(a,3(1x,f7.2))')"Plane 2: ",p2,d2,l2
        stop
      end
