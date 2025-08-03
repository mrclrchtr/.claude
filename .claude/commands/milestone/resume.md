1. Read `@docs/milestones/MILESTONE_MANAGER.md`
2. Take first [WIP] `$MILESTONE_NAME` from the list (if there is a sub-milestone, take the first [WIP] sub-milestone)
3. Understand the milestone (use architecture-planner sub agent)
    - Read `$MILESTONE_NAME`
    - Check what's already implemented
    - Check if the milestone requires refinements through changes between creation of the milestone and now
    - Ask for more context/information if needed to clarify questions
    - Update the `$MILESTONE_NAME` with the new plan if needed
4. Implement the milestone (use implementation-specialist sub agent)
    - Read `$MILESTONE_NAME`
    - Implement the milestone step by step
    - Mark completed steps in `$MILESTONE_NAME` with `[X]`
    - Review all changes
      - Check, if everything of `$MILESTONE_NAME` is implemented - Read `$MILESTONE_NAME` again if needed
      - start over (with `3. Understand the milestone`) if needed
5. Update `@docs/milestones/MILESTONE_MANAGER.md` - mark the milestone as [DONE]
6. Commit by
    - Adding the changes to git
    - Committing the changes using conventional commit message
