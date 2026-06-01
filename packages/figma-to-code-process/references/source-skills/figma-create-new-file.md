# figma-create-new-file

## Goal

Create a new blank Figma Design or FigJam file when a downstream workflow
needs a fresh workspace.

This is a setup utility. It should create the file and return the link;
it should not make design, implementation, or design-system decisions.

## When to use

- A workflow needs a new Figma Design file before `figma-use`,
  `figma-generate-design`, or `figma-generate-library` can write to the
  canvas.
- The user explicitly asks to create a new Figma file or FigJam board.
- A code-to-canvas or library-generation workflow needs an empty target
  file and the user has not provided one.

## When not to use

- The user already provided a target Figma file.
- The task is to edit an existing file — use `figma-use` or the relevant
  higher-level skill.
- The task is to generate code from Figma — use `figma-implement-design`.
- The task is to decide component rules or build a library. Create the
  file first only if a fresh target file is actually needed.

## Required context

- File type: `design` or `figjam`.
- File name. If missing, use a short descriptive name or ask when naming
  matters to the workflow.
- Organization/team choice when the account has multiple eligible
  destinations and the tool cannot infer the target.

## Inputs

- `editorType`: `design` or `figjam`.
- `fileName`: requested file name.
- Optional: target organization/team if required by the creation tool.

## Outputs

- URL of the created Figma or FigJam file.
- Any destination/permission note returned by the creation step.

## Workflow

1. Confirm that a new file is needed instead of using an existing target.
2. Resolve `editorType`:
   - use `design` for Figma Design workflows
   - use `figjam` for FigJam boards
3. Resolve a concise file name.
4. Create the file with the available Figma new-file tool.
5. Return the file URL and route the user to the next requested skill.

## Clarification policy

Ask before proceeding when:
- The account requires choosing between multiple organizations or teams.
- The file type is ambiguous and affects the downstream workflow.
- The user expects the new file to contain initial content, but has not
  said what should be created.

Do not ask when:
- The user clearly requested a blank file with a name and type.
- A downstream workflow already determines the file type.

## Gotchas

- Do not create duplicate blank files when an existing file URL is already
  available in the conversation.
- Do not treat a new blank file as evidence that a design system exists.
  `figma-generate-design` and `figma-generate-library` still need
  component, variable, and style discovery.
- If the user wants a FigJam board, do not create a Figma Design file by
  default.

## Verification

- The returned URL opens the expected file type.
- The file name matches the requested or inferred name.
- No extra canvas content was added unless the downstream workflow asked
  for it.
