package ink.mxm.eopl;

import static ink.mxm.eopl.model.Environment.INIT_ENV;
import static ink.mxm.eopl.model.Environment.applyEnv;

import ink.mxm.eopl.model.Bounce;
import ink.mxm.eopl.model.Bounce.Snapshot;
import ink.mxm.eopl.model.Continuation;
import ink.mxm.eopl.model.Continuation.Diff1Cont;
import ink.mxm.eopl.model.Continuation.Diff2Cont;
import ink.mxm.eopl.model.Continuation.EndCont;
import ink.mxm.eopl.model.Continuation.IfTestCont;
import ink.mxm.eopl.model.Continuation.LetExpCont;
import ink.mxm.eopl.model.Continuation.RandCont;
import ink.mxm.eopl.model.Continuation.RatorCont;
import ink.mxm.eopl.model.Continuation.Zero1Cont;
import ink.mxm.eopl.model.Environment;
import ink.mxm.eopl.model.Environment.ExtendEnv;
import ink.mxm.eopl.model.Environment.ExtendEnvRec;
import ink.mxm.eopl.model.ExpVal;
import ink.mxm.eopl.model.ExpVal.BoolVal;
import ink.mxm.eopl.model.ExpVal.NumVal;
import ink.mxm.eopl.model.ExpVal.ProcVal;
import ink.mxm.eopl.model.Expression;
import ink.mxm.eopl.model.Expression.CallExp;
import ink.mxm.eopl.model.Expression.ConstExp;
import ink.mxm.eopl.model.Expression.DiffExp;
import ink.mxm.eopl.model.Expression.IfExp;
import ink.mxm.eopl.model.Expression.IsZeroExp;
import ink.mxm.eopl.model.Expression.LetExp;
import ink.mxm.eopl.model.Expression.LetrecExp;
import ink.mxm.eopl.model.Expression.ProcExp;
import ink.mxm.eopl.model.Expression.VarExp;
import ink.mxm.eopl.model.Proc;
import ink.mxm.eopl.model.Proc.Procedure;

/**
 *
 * @author Mu Xian Ming (Sam)
 */
@SuppressWarnings("ALL")
public final class Interpreter {
    public static ExpVal valueOfExpression(Expression exp1) {
        return trampoline(valueOf(exp1, INIT_ENV, new EndCont()));
    }

    private static ExpVal trampoline(Bounce bounce) {
        while (!(bounce instanceof ExpVal)) {
            Snapshot snapshot = (Snapshot) bounce;
            bounce = snapshot.getBounce();
        }
        return (ExpVal) bounce;
    }

    private static Bounce valueOf(Expression exp, Environment env, Continuation cont) {
        if (exp instanceof ConstExp) {
            ConstExp constExp = (ConstExp) exp;
            return applyCont(cont, new NumVal(constExp.getNum()));
        } else if (exp instanceof VarExp) {
            VarExp varExp = (VarExp) exp;
            return applyCont(cont, applyEnv(env, varExp.getVar()));
        } else if (exp instanceof ProcExp) {
            ProcExp procExp = (ProcExp) exp;
            return applyCont(cont,
                             new ProcVal(
                                     new Procedure(procExp.getVar(), procExp.getBody(), env)));
        } else if (exp instanceof LetrecExp) {
            LetrecExp letrecExp = (LetrecExp) exp;
            return valueOf(letrecExp.getBody(),
                           new ExtendEnvRec(letrecExp.getPname(), letrecExp.getPvar(), letrecExp.getBody(), env),
                           cont);
        } else if (exp instanceof IsZeroExp) {
            IsZeroExp isZeroExp = (IsZeroExp) exp;
            return valueOf(isZeroExp.getExp1(), env, new Zero1Cont(cont));
        } else if (exp instanceof LetExp) {
            LetExp letExp = (LetExp) exp;
            return valueOf(letExp.getExp1(), env,
                           new LetExpCont(letExp.getVar(), letExp.getBody(), env, cont));
        } else if (exp instanceof IfExp) {
            IfExp ifExp = (IfExp) exp;
            return valueOf(ifExp.getExp1(), env,
                           new IfTestCont(ifExp.getExp2(), ifExp.getExp3(), env, cont));
        } else if (exp instanceof DiffExp) {
            DiffExp diffExp = (DiffExp) exp;
            return valueOf(diffExp.getExp1(), env,
                           new Diff1Cont(diffExp.getExp2(), env, cont));
        } else if (exp instanceof CallExp) {
            CallExp callExp = (CallExp) exp;
            return valueOf(callExp.getExp1(), env, new RatorCont(callExp.getExp2(), env, cont));
        } else {
            throw new RuntimeException("Unknown expression:" + exp);
        }
    }

    private static Bounce applyCont(Continuation cont, ExpVal val) {
        if (cont instanceof EndCont) {
            System.out.println("End of computation.");
            return val;
        } else if (cont instanceof Zero1Cont) {
            Zero1Cont zero1Cont = (Zero1Cont) cont;
            return applyCont(zero1Cont.getSavedCont(), new BoolVal(val.toNum() == 0));
        } else if (cont instanceof LetExpCont) {
            LetExpCont letExpCont = (LetExpCont) cont;
            return valueOf(letExpCont.getBody(),
                           new ExtendEnv(letExpCont.getVar(), val, letExpCont.getSavedEnv()),
                           letExpCont.getSavedCont());
        } else if (cont instanceof IfTestCont) {
            IfTestCont ifTestCont = (IfTestCont) cont;
            if (val.toBool()) {
                return valueOf(ifTestCont.getExp2(), ifTestCont.getSavedEnv(), ifTestCont.getSavedCont());
            } else {
                return valueOf(ifTestCont.getExp3(), ifTestCont.getSavedEnv(), ifTestCont.getSavedCont());
            }
        } else if (cont instanceof Diff1Cont) {
            Diff1Cont diff1Cont = (Diff1Cont) cont;
            return valueOf(diff1Cont.getExp2(), diff1Cont.getSavedEnv(),
                           new Diff2Cont(val, diff1Cont.getSavedCont()));
        } else if (cont instanceof Diff2Cont) {
            Diff2Cont diff2Cont = (Diff2Cont) cont;
            return applyCont(diff2Cont.getSavedCont(),
                             new NumVal(diff2Cont.getVal1().toNum() - val.toNum()));
        } else if (cont instanceof RatorCont) {
            RatorCont ratorCont = (RatorCont) cont;
            return valueOf(ratorCont.getRand(), ratorCont.getSavedEnv(),
                           new RandCont(val, ratorCont.getSavedCont()));
        } else if (cont instanceof RandCont) {
            RandCont randCont = (RandCont) cont;
            Proc proc = randCont.getVal1().toProc();
            return applyProcedure(proc, val, randCont.getSavedCont());
        } else {
            throw new RuntimeException("Unknown cont: " + cont);
        }
    }

    private static Snapshot applyProcedure(Proc proc, ExpVal arg, Continuation cont) {
        if (proc instanceof Procedure) {
            Procedure p = (Procedure) proc;
            return new Snapshot(
                    valueOf(p.getBody(),
                            new ExtendEnv(p.getVar(), arg, p.getEnv()),
                            cont));
        } else {
            throw new RuntimeException("Unknown proc: " + proc);
        }
    }
}
