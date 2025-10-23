# Installation Guide - Digital Product Development Skill Suite

Complete, step-by-step installation instructions for using the skill suite with Claude.

## What You'll Get

After installation, you'll have **4 expert skills** available in Claude:
- 🔍 **Product Research** - Market analysis & technology evaluation
- 🏗️ **Technical Architecture** - System design & architecture decisions
- 💻 **Software Development** - React/TypeScript/Next.js/Python implementation
- ✅ **Quality Engineering** - Testing strategy & test implementation

## Prerequisites

**Required:**
- Claude Pro, Team, or Enterprise subscription
- 5-10 minutes

**Optional (for Claude Code CLI):**
- Git installed
- Terminal access (macOS/Linux) or Git Bash (Windows)

## Choose Your Installation Method

Pick the option that matches how you use Claude:

| Method | Best For | Difficulty | Time |
|--------|----------|------------|------|
| [Option 1](#option-1-claudeai-webdesktop-easiest) | Claude.ai web/desktop users | ⭐ Easiest | 5 min |
| [Option 2](#option-2-claude-code-cli) | Claude Code CLI users | ⭐⭐ Moderate | 8 min |
| [Option 3](#option-3-api-usage) | API developers | ⭐ Easy | 5 min |

---

## Option 1: Claude.ai Web/Desktop (Easiest)

**Perfect for:** Most users, especially those using Claude via web browser or desktop app

### Step-by-Step Instructions

**Step 1: Download the skills**
```bash
# Option A: Clone with Git (recommended)
git clone https://github.com/mevans2120/dev-suite-claude-skills.git
cd dev-suite-claude-skills

# Option B: Download ZIP from GitHub
# Visit: https://github.com/mevans2120/dev-suite-claude-skills
# Click: Code → Download ZIP
# Extract the ZIP file
# Open terminal in extracted folder
```

**Step 2: Validate the skills**
```bash
# Make the validation script executable
chmod +x scripts/validate-skills.sh

# Run validation
./scripts/validate-skills.sh

# You should see:
# ✅ All 49 checks passed!
```

**Step 3: Create a distribution ZIP**
```bash
# Create ZIP excluding unnecessary files
zip -r dev-suite-skills.zip . \
  -x "*.git*" \
  -x ".claude-memory/session/*" \
  -x "node_modules/*" \
  -x ".DS_Store"

# The ZIP will be created in the current directory
ls -lh dev-suite-skills.zip
```

**Step 4: Upload to Claude.ai**

1. Open [Claude.ai](https://claude.ai) in your browser (or open the desktop app)
2. Look for the **Skills** icon in the left sidebar (looks like a puzzle piece 🧩)
3. Click **"Upload Skill"** or **"Add Skill"**
4. Browse and select `dev-suite-skills.zip`
5. Wait for the upload to complete (usually 30-60 seconds)
6. You'll see a confirmation when it's done

**Step 5: Test it works!**
- Start a new conversation in Claude
- Type: **"Research the market for task management apps"**
- Claude should automatically use the Product Research skill
- You'll see detailed market analysis in the response

**✅ Done!** The skills are now available in all your Claude.ai conversations.

## Option 2: Claude Code CLI

**Perfect for:** Developers using Claude via command-line interface

### Choose Your Scope

| Scope | When to Use | Command |
|-------|-------------|---------|
| **Global** ✅ | Want skills in ALL projects (recommended) | [Method A](#method-a-global-installation-recommended) |
| **Project** | Want skills in ONE specific project only | [Method B](#method-b-project-specific) |

### Method A: Global Installation (Recommended)

**Makes skills available in all your projects**

**Step 1: Download and validate**
```bash
# Clone the repository
git clone https://github.com/mevans2120/dev-suite-claude-skills.git
cd dev-suite-claude-skills

# Validate
chmod +x scripts/validate-skills.sh
./scripts/validate-skills.sh
# Should show: ✅ All 49 checks passed!
```

**Step 2: Create skills directory**
```bash
# Create the global skills directory if it doesn't exist
mkdir -p ~/.claude/skills
```

**Step 3: Install with symlinks (keeps skills auto-updated)**
```bash
# Get the full path to your cloned repository
REPO_PATH="$(pwd)"

# Create symlinks (this way updates to the repo automatically sync)
ln -s "$REPO_PATH/product-research" ~/.claude/skills/product-research
ln -s "$REPO_PATH/technical-architecture" ~/.claude/skills/technical-architecture
ln -s "$REPO_PATH/software-development" ~/.claude/skills/software-development
ln -s "$REPO_PATH/quality-engineering" ~/.claude/skills/quality-engineering
```

**Step 4: Verify installation**
```bash
# Check that all 4 skills are linked
ls -la ~/.claude/skills/ | grep -E "product-research|technical-architecture|software-development|quality-engineering"

# You should see 4 symlinks (arrows →) pointing to your repo
```

**Step 5: Test it works!**
```bash
# Start Claude Code in any project
cd ~/your-project
claude

# Then type: "Design architecture for a blog platform"
# Claude should load the Technical Architecture skill
```

**✅ Done!** Skills are now available globally across all your projects.

**Benefits of symlinks:**
- ✅ Updates to the repo automatically available
- ✅ No file duplication
- ✅ Easy to manage (one copy, many uses)

---

### Method B: Project-Specific

**Makes skills available in ONE project only**

```bash
# 1. Navigate to your project
cd ~/your-project

# 2. Create project skills directory
mkdir -p .claude/skills

# 3. Copy skill directories (not symlink, since project-specific)
cp -r /path/to/dev-suite-claude-skills/product-research .claude/skills/
cp -r /path/to/dev-suite-claude-skills/technical-architecture .claude/skills/
cp -r /path/to/dev-suite-claude-skills/software-development .claude/skills/
cp -r /path/to/dev-suite-claude-skills/quality-engineering .claude/skills/

# 4. Verify
ls -la .claude/skills/
# Should see 4 directories
```

**When to use this:**
- Testing skills before global installation
- Project has unique skill requirements
- Don't want skills in other projects

### Option 3: API Usage

If using Claude via API, skills must be uploaded to your account via Claude.ai first (see Option 1), then they'll automatically be available in API calls.

---

## Install the Complete Ecosystem (Optional)

This Development Suite is one of three complementary skill suites. For the complete product development experience:

| Suite | Skills | Repository |
|-------|--------|------------|
| 🎨 Design | 4 skills (UI/UX, Design Systems) | [design-suite-claude-skills](https://github.com/mevans2120/design-suite-claude-skills) |
| 📋 Project | 3 skills (Planning, Management) | [project-suite-claude-skills](https://github.com/mevans2120/project-suite-claude-skills) |
| 💻 Development | 4 skills (this repo) | [dev-suite-claude-skills](https://github.com/mevans2120/dev-suite-claude-skills) |

**Install all three (11 total skills):**

```bash
# 1. Clone all repositories
git clone https://github.com/mevans2120/design-suite-claude-skills.git
git clone https://github.com/mevans2120/project-suite-claude-skills.git
git clone https://github.com/mevans2120/dev-suite-claude-skills.git

# 2. Validate each
cd design-suite-claude-skills && ./scripts/validate-skills.sh && cd ..
cd project-suite-claude-skills && ./scripts/validate-skills.sh && cd ..
cd dev-suite-claude-skills && ./scripts/validate-skills.sh && cd ..

# 3. Install all globally
mkdir -p ~/.claude/skills

# Design Suite
cd design-suite-claude-skills
for skill in design-*; do ln -s "$(pwd)/$skill" ~/.claude/skills/$skill; done
cd ..

# Project Suite
cd project-suite-claude-skills
for skill in project-*; do ln -s "$(pwd)/$skill" ~/.claude/skills/$skill; done
cd ..

# Development Suite
cd dev-suite-claude-skills
ln -s "$(pwd)/product-research" ~/.claude/skills/product-research
ln -s "$(pwd)/technical-architecture" ~/.claude/skills/technical-architecture
ln -s "$(pwd)/software-development" ~/.claude/skills/software-development
ln -s "$(pwd)/quality-engineering" ~/.claude/skills/quality-engineering
cd ..

# 4. Verify all 11 skills
ls -la ~/.claude/skills/ | wc -l
# Should show 11+ lines (11 skills + directory entries)
```

**Benefits of complete ecosystem:**
- 🎨 Design skills for UI/UX
- 📋 Project skills for planning & coordination
- 💻 Development skills for implementation & testing
- 🚀 Complete product lifecycle coverage

**See README for detailed ecosystem integration examples.**

```python
import anthropic

client = anthropic.Client(api_key="your-api-key")

# Skills will be automatically loaded based on prompt content
response = client.messages.create(
    model="claude-3-5-sonnet-20241022",
    max_tokens=4096,
    messages=[{
        "role": "user",
        "content": "Research the market for task management apps"
    }]
)

# The product-research skill should be loaded automatically
```

## Verification

After installation, verify the skills are working:

### Test 1: Product Research Skill

**Prompt:**
```
I want to build a task management app. Can you research the market?
```

**Expected:** Claude should load the `product-research` skill and provide comprehensive market analysis.

### Test 2: Technical Architecture Skill

**Prompt:**
```
Design the architecture for a real-time chat application using modern tech.
```

**Expected:** Claude should load the `technical-architecture` skill and propose specific technologies.

### Test 3: Software Development Skill

**Prompt:**
```
Implement a React component for user authentication with TypeScript.
```

**Expected:** Claude should load the `software-development` skill and write clean, typed code.

### Test 4: Quality Engineering Skill

**Prompt:**
```
Analyze test coverage and recommend testing improvements.
```

**Expected:** Claude should load the `quality-engineering` skill and provide detailed testing analysis.

### Test 5: Multi-Skill Workflow

**Prompt:**
```
Help me build a blog platform from scratch. I need research, architecture,
implementation, and testing.
```

**Expected:** Claude should use multiple skills in sequence to deliver a complete solution.

## Validation

Run the validation script to ensure proper installation:

```bash
cd /path/to/dev-suite-claude-skills
./scripts/validate-skills.sh
```

**Expected output:**
```
========================================
Validation Summary
========================================
Total checks:   49
Passed:         49
Failed:         0
Warnings:       0

✅ All critical validations passed!
```

## Troubleshooting

### Issue 1: Skills Not Loading

**Problem:** You ask Claude something but the skills don't seem to activate

**How to tell:** The response is generic, doesn't mention using a specific skill

**Example:**
```
You: "Research the task management market"
Claude: [gives brief generic answer without deep market analysis]
❌ Product Research skill didn't load
```

**Solutions:**

**1. Verify installation:**
```bash
# For Claude.ai: Check the Skills panel shows your skills

# For Claude Code CLI (Global):
ls -la ~/.claude/skills/ | grep dev-suite

# For Claude Code CLI (Project):
ls -la .claude/skills/

# You should see the 4 skill directories
```

**2. Check the skills are valid:**
```bash
cd /path/to/dev-suite-claude-skills
./scripts/validate-skills.sh

# Should show: ✅ All 49 checks passed
```

**3. Try being more explicit:**
```
Instead of: "Research task management"
Try: "Using the product-research skill, conduct comprehensive market research on task management apps including competitive analysis"
```

**4. Restart Claude (CLI users):**
```bash
# Exit current session
exit

# Start fresh
claude
```

**5. Check frontmatter has trigger keywords:**
```bash
head -5 product-research/SKILL.md

# Should show:
# ---
# name: product-research
# description: Conduct comprehensive product research including...
# ---
```

---

### Issue 2: "Permission Denied" When Running Scripts

**Problem:** Can't execute `./scripts/validate-skills.sh`

**Error message:**
```
-bash: ./scripts/validate-skills.sh: Permission denied
```

**Solution:**
```bash
# Make the script executable
chmod +x scripts/validate-skills.sh

# Now run it
./scripts/validate-skills.sh
```

---

### Issue 3: Symlinks Not Working (Windows)

**Problem:** Symlinks fail on Windows

**Error message:**
```
ln: failed to create symbolic link: Operation not supported
```

**Solution:** Use copying instead of symlinking
```bash
# Instead of ln -s, use cp -r
mkdir -p ~/.claude/skills
cp -r product-research ~/.claude/skills/
cp -r technical-architecture ~/.claude/skills/
cp -r software-development ~/.claude/skills/
cp -r quality-engineering ~/.claude/skills/
```

**Note:** With copying, you'll need to manually update if you pull changes from the repo.

---

### Issue 4: ZIP Upload Fails

**Problem:** ZIP file won't upload to Claude.ai

**Possible causes:**
1. File too large
2. Includes unnecessary files

**Solution:**
```bash
# Create a clean ZIP excluding large/unnecessary files
zip -r dev-suite-skills.zip . \
  -x "*.git*" \
  -x ".claude-memory/session/*" \
  -x "node_modules/*" \
  -x ".DS_Store" \
  -x "*.log"

# Check the size
ls -lh dev-suite-skills.zip
# Should be under 5MB
```

---

### Issue 5: Skills Activate But Responses Seem Wrong

**Problem:** Skills load but outputs don't match documentation

**Diagnosis:**
```bash
# Check which version you have
git log --oneline -1

# Update to latest
git pull origin main

# Validate
./scripts/validate-skills.sh
```

**For Claude.ai users:** Re-create and re-upload the ZIP after updating

**For CLI users with symlinks:** Skills auto-update, just restart Claude

---

### Issue 6: Can't Find Skills Directory

**Problem:** `~/.claude/skills/` doesn't exist

**Solution:**
```bash
# Create it
mkdir -p ~/.claude/skills

# Verify
ls -la ~/.claude/skills

# Should show an empty directory ready for skills
```

---

### Issue 7: Multiple Skills Seem to Conflict

**Problem:** Claude uses multiple skills at once causing confusion

**This is normal!** Skills augment Claude's knowledge - they don't replace it. Claude can use multiple skills together when appropriate.

**Example (intended behavior):**
```
You: "Build a task app from scratch"
Claude: [Uses Research + Architecture + Development + QE skills together]
✅ This is correct - comprehensive workflow
```

**If you want only one skill:**
```
You: "Using ONLY the technical-architecture skill, design..."
```

---

### Still Having Issues?

1. **Check GitHub Issues:** https://github.com/mevans2120/dev-suite-claude-skills/issues
2. **Run full diagnostics:**
   ```bash
   # Validate skills
   ./scripts/validate-skills.sh

   # Check installation
   ls -la ~/.claude/skills/

   # Check versions
   git log --oneline -5
   ```
3. **Open a new issue** with:
   - Your installation method (Claude.ai, CLI, etc.)
   - Error messages (full text)
   - Output of `./scripts/validate-skills.sh`
   - Steps you've already tried

### File Permission Errors

**Symptom:** Permission denied when running scripts

**Solution:**
```bash
chmod +x scripts/validate-skills.sh
```

### Skills Conflict

**Symptom:** Multiple skills seem to activate at once causing confusion

**Note:** This is normal behavior. Skills augment Claude's knowledge, they don't replace it. Claude can use multiple skills together when appropriate.

**Best practice:** Be specific in prompts about what you want.

### YAML Parsing Errors

**Symptom:** Errors mentioning frontmatter or YAML

**Solution:**
1. Check YAML syntax in SKILL.md files:
   ```bash
   head -10 product-research/SKILL.md
   ```

2. Ensure proper format:
   ```yaml
   ---
   name: skill-name
   description: Description text
   ---
   ```

3. Validate with script:
   ```bash
   ./scripts/validate-skills.sh
   ```

## Updating Skills

### Update Individual Skill

1. Edit the SKILL.md file
2. Update version number in frontmatter
3. Run validation:
   ```bash
   ./scripts/validate-skills.sh
   ```
4. For Claude.ai: Re-upload the updated ZIP
5. For CLI: Changes take effect immediately

### Update All Skills

```bash
# Pull latest changes (if using git)
git pull origin main

# Validate
./scripts/validate-skills.sh

# For Claude.ai: Re-create ZIP and re-upload
zip -r dev-suite-skills.zip . -x "*.git*" -x ".claude-memory/*"

# For CLI: Skills update automatically
```

## Uninstalling

### Claude.ai Web/Desktop

1. Click Skills icon
2. Find "Digital Product Development Skill Suite"
3. Click Remove or Delete

### Claude Code CLI - Plugin

```bash
claude plugin remove dev-suite-claude-skills
```

### Claude Code CLI - Project Skills

```bash
# In your project directory
rm -rf .claude/skills/product-research
rm -rf .claude/skills/technical-architecture
rm -rf .claude/skills/software-development
rm -rf .claude/skills/quality-engineering
```

### Claude Code CLI - Personal Skills

```bash
rm -rf ~/.claude/skills/product-research
rm -rf ~/.claude/skills/technical-architecture
rm -rf ~/.claude/skills/software-development
rm -rf ~/.claude/skills/quality-engineering
```

## Configuration

### Skill-Specific Tool Restrictions

By default, skills have access to all tools. To restrict tools for a specific skill:

1. Edit the skill's SKILL.md frontmatter:
   ```yaml
   ---
   name: product-research
   description: ...
   allowed-tools: Read, Grep, Glob, WebSearch, WebFetch
   ---
   ```

2. Re-upload or sync the skill

### Plugin Configuration

The `.claude-plugin/plugin.json` file contains plugin-wide settings:

```json
{
  "config": {
    "memoryDir": ".claude-memory",
    "memoryBankDir": "memory-bank",
    "sessionExpiryHours": 24,
    "maxRecentChanges": 20,
    "autoArchiveOnExit": true
  }
}
```

Modify these settings as needed for your workflow.

## Best Practices

### 1. Regular Validation

Run validation periodically:
```bash
./scripts/validate-skills.sh
```

### 2. Keep Skills Updated

- Watch the repository for updates
- Review changelogs before updating
- Test after updates

### 3. Provide Feedback

- Note which prompts work well
- Track skill performance
- Suggest improvements via issues

### 4. Customize for Your Team

- Fork the repository
- Add company-specific guidelines
- Customize technology recommendations
- Add your code standards

## Additional Resources

- [Main README](README.md) - Overview and examples
- [Quick Start Guide](QUICK-START.md) - Quick reference
- [Testing Guide](TESTING.md) - Comprehensive testing procedures
- [Claude Skills Documentation](https://docs.claude.com/en/docs/claude-code/skills.md)
- [GitHub Repository](https://github.com/mevans2120/dev-suite-claude-skills)

## Support

For issues or questions:

1. Check this installation guide
2. Review [TESTING.md](TESTING.md) for troubleshooting
3. Run validation script
4. Check GitHub issues
5. Open a new issue with details

---

**Version:** 1.0.0
**Last Updated:** 2025-01-22
**Maintained By:** mevans2120
