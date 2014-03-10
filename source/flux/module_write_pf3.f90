module module_write_pf3

!-----------------------------------------------------------------------
! Module to manage PF3 (Flux) files
!
! Licensing: This code is distributed under the GNU GPL license.
! Author: Victor Sande, victor(dot)sande(at)usc(dot)es
! Last update: 21/02/2014
!
! PUBLIC PROCEDURES:
! write_line:          write a line in the PF3 file
! write_comment:       write a comment in the PF3 file
! write_empty_line:    write an empty line in the PF3 file
! write_string:        write string data in the PF3 file
!-----------------------------------------------------------------------

use module_COMPILER_DEPENDANT, only: real64
use module_os_dependant, only: maxpath
use module_report, only:error
use module_convers
use module_mesh
use module_pmh

implicit none


contains


!-----------------------------------------------------------------------
! write_line(iu,line,ch,comm): write a line in the PF3 file
!-----------------------------------------------------------------------
! iu:   unit number of the PF3 file
! line: text included in one line
! ch:   comments character (Optional)
! comm: commentary (Optional)
!-----------------------------------------------------------------------

subroutine write_line(iu,line,ch,comm)
  integer, intent(in) :: iu ! File unit number
  character(len=*), intent(in) :: line ! String
  character(len=*), optional, intent(in) :: ch ! String: Comment character
  character(len=*), optional, intent(in) :: comm ! String: Comment
  character(len=MAXPATH) :: aux
  integer :: ios

  if(present(comm)) then
    if(present(ch)) then
      aux = trim(ch)//' '//trim(comm)
    else
      aux = '# '//trim(comm)
    endif
  else
    aux = ''
  endif


  write(unit=iu, fmt='(a)', iostat = ios) trim(line)//' '//trim(aux)
  if (ios /= 0) call error('write_pf3/header, #'//trim(string(ios)))

end subroutine


!-----------------------------------------------------------------------
! write_comment(iu,ch,line): write a comment in the PF3 file
!-----------------------------------------------------------------------
! iu:   unit number of the PF3 file
! ch:   comments character
! line: commentary
!-----------------------------------------------------------------------

subroutine write_comment(iu,ch,line)
  integer, intent(in) :: iu            ! File unit number
  character(len=*), intent(in) :: ch   ! String: Comment character
  character(len=*), intent(in) :: line ! String

  call write_line(iu,trim(ch)//' '//trim(line))

end subroutine


!-----------------------------------------------------------------------
! write_empty_line(iu): write an empty line in the PF3 file
!-----------------------------------------------------------------------
! iu:   unit number of the PF3 file
!-----------------------------------------------------------------------

subroutine write_empty_line(iu)
  integer, intent(in) :: iu ! File unit number

  call write_line(iu,'')

end subroutine


!-----------------------------------------------------------------------
! write_string(iu,str,ch,comm): write a string in the PF3 file
!-----------------------------------------------------------------------
! iu:   unit number of the PF3 file
! str:  string to write to the file
! ch:   comments character (Optional)
! line: commentary (Optional)
!-----------------------------------------------------------------------

subroutine write_string(iu,str,ch,comm)
  integer, intent(in) :: iu ! File unit number
  character(len=*), intent(in) :: str ! String
  character(len=*), optional, intent(in) :: ch ! String: Comment character
  character(len=*), optional, intent(in) :: comm ! String: Comment
  character(len=MAXPATH) :: aux1, aux2

  if(present(ch)) then
    aux1 = trim(ch)
  else
    aux1 = ''
  endif

  if(present(comm)) then
    aux2 = trim(comm)
  else
    aux2 = ''
  endif

  call write_line(iu,trim(string(len_trim(str)))//' '//trim(str),trim(aux1),trim(aux2))

end subroutine


end module