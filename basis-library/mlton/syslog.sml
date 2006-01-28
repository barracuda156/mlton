(* Copyright (C) 1999-2005 Henry Cejtin, Matthew Fluet, Suresh
 *    Jagannathan, and Stephen Weeks.
 * Copyright (C) 1997-2000 NEC Research Institute.
 *
 * MLton is released under a BSD-style license.
 * See the file MLton-LICENSE for details.
 *)

(* From Tom 7 <twm@andrew.cmu.edu>. *)
(* Implementation of the SYSLOG interface using MLton FFI.
 * This will only work in MLton.
 *)

structure MLtonSyslog :> MLTON_SYSLOG =
struct

open PrimitiveFFI.MLton.Syslog

type openflag = C.Int.t

local 
   open Logopt
in
   val CONS = LOG_CONS
   val NDELAY = LOG_NDELAY
   val NOWAIT = LOG_NOWAIT
   val ODELAY = LOG_ODELAY
   val PID = LOG_PID
end

type facility = C.Int.t

local
   open Facility
in
   val AUTHPRIV = LOG_AUTH
   val CRON = LOG_CRON
   val DAEMON = LOG_DAEMON
   val KERN = LOG_KERN
   val LOCAL0 = LOG_LOCAL0
   val LOCAL1 = LOG_LOCAL1
   val LOCAL2 = LOG_LOCAL2
   val LOCAL3 = LOG_LOCAL3
   val LOCAL4 = LOG_LOCAL4
   val LOCAL5 = LOG_LOCAL5
   val LOCAL6 = LOG_LOCAL6
   val LOCAL7 = LOG_LOCAL7
   val LPR = LOG_LPR
   val MAIL = LOG_MAIL
   val NEWS = LOG_NEWS
(*
   val SYSLOG = LOG_SYSLOG
*)
   val USER = LOG_USER
   val UUCP = LOG_UUCP
end

type loglevel = C.Int.t

local
   open Severity
in
   val ALERT = LOG_ALERT
   val CRIT = LOG_CRIT
   val DEBUG = LOG_DEBUG
   val EMERG = LOG_EMERG
   val ERR = LOG_ERR
   val INFO = LOG_INFO
   val NOTICE = LOG_NOTICE
   val WARNING = LOG_WARNING
end

fun zt s = s ^ "\000"

val openlog = fn (s, opt, fac) =>
   let 
      val optf = 
         Word32.toInt (foldl Word32.orb 0w0 (map Word32.fromInt opt))
   in
     openlog (NullString.fromString (zt s), optf, fac)
   end

val closelog = fn () => 
   closelog ()

val log = fn (lev, msg) => 
   syslog (lev, NullString.fromString (zt msg))

end
