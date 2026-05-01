"use client";

import { useRef, useState } from "react";
import { Paperclip, X, FileText, Upload } from "lucide-react";
import { cn } from "@/lib/utils";

type FileAttachmentProps = {
  onChange: (file: File | null) => void;
  file: File | null;
  error?: boolean;
  disabled?: boolean;
};

function formatBytes(bytes: number): string {
  if (bytes < 1024) return `${bytes} B`;
  if (bytes < 1024 * 1024) return `${(bytes / 1024).toFixed(1)} KB`;
  return `${(bytes / (1024 * 1024)).toFixed(1)} MB`;
}

export function FileAttachment({
  onChange,
  file,
  error,
  disabled,
}: FileAttachmentProps) {
  const inputRef = useRef<HTMLInputElement>(null);
  const [dragging, setDragging] = useState(false);

  function handleFiles(files: FileList | null) {
    if (!files || files.length === 0) return;
    onChange(files[0]);
  }

  function handleDrop(e: React.DragEvent<HTMLDivElement>) {
    e.preventDefault();
    setDragging(false);
    if (disabled) return;
    handleFiles(e.dataTransfer.files);
  }

  function handleDragOver(e: React.DragEvent<HTMLDivElement>) {
    e.preventDefault();
    if (!disabled) setDragging(true);
  }

  function handleDragLeave() {
    setDragging(false);
  }

  function handleClick() {
    if (!disabled) inputRef.current?.click();
  }

  function handleRemove(e: React.MouseEvent) {
    e.stopPropagation();
    onChange(null);
    if (inputRef.current) inputRef.current.value = "";
  }

  if (file) {
    return (
      <div
        className={cn(
          "flex items-center gap-3 rounded-lg border border-[#B12B35]/30 bg-[#B12B35]/5 px-4 py-3",
          disabled && "opacity-60"
        )}
      >
        <div className="flex h-9 w-9 shrink-0 items-center justify-center rounded-md bg-[#B12B35]/10">
          <FileText className="h-4 w-4 text-[#B12B35]" />
        </div>
        <div className="min-w-0 flex-1">
          <p className="truncate text-sm font-medium text-[#232222]">
            {file.name}
          </p>
          <p className="text-xs text-[#5D5D5D]">{formatBytes(file.size)}</p>
        </div>
        {!disabled && (
          <button
            type="button"
            onClick={handleRemove}
            className="flex h-7 w-7 shrink-0 items-center justify-center rounded-md text-[#5D5D5D] hover:bg-[#B12B35]/10 hover:text-[#B12B35] transition-colors"
            aria-label="Remove attachment"
          >
            <X className="h-4 w-4" />
          </button>
        )}
      </div>
    );
  }

  return (
    <div
      role="button"
      tabIndex={disabled ? -1 : 0}
      onClick={handleClick}
      onKeyDown={(e) => e.key === "Enter" && handleClick()}
      onDrop={handleDrop}
      onDragOver={handleDragOver}
      onDragLeave={handleDragLeave}
      className={cn(
        "flex cursor-pointer flex-col items-center justify-center gap-2 rounded-lg border-2 border-dashed px-6 py-8 text-center transition-colors",
        dragging
          ? "border-[#B12B35] bg-[#B12B35]/5"
          : error
          ? "border-red-400 bg-red-50"
          : "border-[#C5C5C5] hover:border-[#B12B35] hover:bg-[#B12B35]/5",
        disabled && "cursor-not-allowed opacity-60"
      )}
    >
      <div className="flex h-10 w-10 items-center justify-center rounded-full bg-[#B12B35]/10">
        <Upload className="h-5 w-5 text-[#B12B35]" />
      </div>
      <div>
        <p className="text-sm font-medium text-[#232222]">
          <span className="text-[#B12B35]">Click to upload</span> or drag and
          drop
        </p>
        <p className="text-xs text-[#5D5D5D] mt-0.5">
          PDF, Word (.doc/.docx), Excel (.xls/.xlsx) — max 20 MB
        </p>
      </div>
      {error && (
        <p className="text-xs font-medium text-red-600 flex items-center gap-1">
          <Paperclip className="h-3 w-3" /> A supporting document is required.
        </p>
      )}
      <input
        ref={inputRef}
        type="file"
        className="sr-only"
        onChange={(e) => handleFiles(e.target.files)}
        disabled={disabled}
        accept=".pdf,.doc,.docx,.xls,.xlsx,application/pdf,application/msword,application/vnd.openxmlformats-officedocument.wordprocessingml.document,application/vnd.ms-excel,application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
      />
    </div>
  );
}
