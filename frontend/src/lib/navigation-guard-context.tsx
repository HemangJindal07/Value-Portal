"use client";

import React, { createContext, useContext, useRef, useState, useCallback } from "react";
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
  DialogDescription,
  DialogFooter,
} from "@/components/ui/dialog";
import { Button } from "@/components/ui/button";

type NavigationGuardContextValue = {
  /** Register a guard. Returns an unregister function. */
  registerGuard: (isDirty: () => boolean) => () => void;
  /** Call before any programmatic navigation. Returns true if safe to proceed. */
  requestNavigate: (proceed: () => void) => void;
};

const NavigationGuardContext = createContext<NavigationGuardContextValue | null>(null);

export function NavigationGuardProvider({ children }: { children: React.ReactNode }) {
  const guardRef = useRef<(() => boolean) | null>(null);
  const [open, setOpen] = useState(false);
  const pendingRef = useRef<(() => void) | null>(null);

  const registerGuard = useCallback((isDirty: () => boolean) => {
    guardRef.current = isDirty;
    return () => { guardRef.current = null; };
  }, []);

  const requestNavigate = useCallback((proceed: () => void) => {
    if (guardRef.current?.()) {
      pendingRef.current = proceed;
      setOpen(true);
    } else {
      proceed();
    }
  }, []);

  function handleDiscard() {
    setOpen(false);
    const fn = pendingRef.current;
    pendingRef.current = null;
    fn?.();
  }

  function handleKeep() {
    setOpen(false);
    pendingRef.current = null;
  }

  return (
    <NavigationGuardContext.Provider value={{ registerGuard, requestNavigate }}>
      {children}

      <Dialog open={open} onOpenChange={(o) => { if (!o) handleKeep(); }}>
        <DialogContent showCloseButton={false}>
          <DialogHeader>
            <DialogTitle>Discard unsaved changes?</DialogTitle>
            <DialogDescription>
              You have unsaved changes in this form. If you leave now, all entered data will be lost.
            </DialogDescription>
          </DialogHeader>
          <DialogFooter>
            <Button variant="outline" onClick={handleKeep}>
              Keep Editing
            </Button>
            <Button className="bg-[#B12B35] hover:bg-[#9a2330] text-white" onClick={handleDiscard}>
              Discard &amp; Leave
            </Button>
          </DialogFooter>
        </DialogContent>
      </Dialog>
    </NavigationGuardContext.Provider>
  );
}

export function useNavigationGuard() {
  const ctx = useContext(NavigationGuardContext);
  if (!ctx) throw new Error("useNavigationGuard must be used inside NavigationGuardProvider");
  return ctx;
}
