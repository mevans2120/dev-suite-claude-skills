# Installation Guide - Digital Product Development Skill Suite

Complete installation instructions for using the skill suite with Claude.

## Prerequisites

- Claude Pro, Max, Team, or Enterprise subscription
- For Claude Code: Claude Code CLI installed
- For local testing: Bash shell (macOS/Linux) or Git Bash (Windows)

## Quick Start

### Option 1: Claude.ai Web/Desktop (Easiest)

**1. Download the skill suite:**
```bash
# Clone the repository
git clone https://github.com/mevans2120/dev-suite-claude-skills.git
cd dev-suite-claude-skills

# Or download and extract the ZIP from GitHub
```

**2. Create a ZIP file (if not already done):**
```bash
zip -r dev-suite-skills.zip . \
  -x "*.git*" \
  -x ".claude-memory/*" \
  -x "node_modules/*" \
  -x ".DS_Store"
```

**3. Upload to Claude.ai:**
1. Open Claude.ai in your browser or desktop app
2. Click the **Skills** icon (puzzle piece) in the left sidebar
3. Click **Upload Skill** or **Add Skill**
4. Select `dev-suite-skills.zip`
5. Wait for upload to complete (may take a minute)
6. Skills are now available!

**4. Verify installation:**
- Start a new conversation
- Try a test prompt (see [Verification](#verification) below)
- Claude should automatically load the relevant skill

### Option 2: Claude Code CLI

**Method A: Install as Plugin**

```bash
# Navigate to the skill suite directory
cd /path/to/dev-suite-claude-skills

# Verify skills are valid
./scripts/validate-skills.sh

# Add as a plugin
# (This method allows the skills to be available across projects)
# Note: Adjust command based on Claude Code version
claude plugin add .
```

**Method B: Install as Project Skills**

```bash
# In your project directory
mkdir -p .claude/skills

# Copy each skill directory
cp -r /path/to/dev-suite-claude-skills/product-research .claude/skills/
cp -r /path/to/dev-suite-claude-skills/technical-architecture .claude/skills/
cp -r /path/to/dev-suite-claude-skills/software-development .claude/skills/
cp -r /path/to/dev-suite-claude-skills/quality-engineering .claude/skills/

# Verify installation
ls -la .claude/skills/
```

**Method C: Install as Personal Skills (All Projects)**

```bash
# Create personal skills directory (if it doesn't exist)
mkdir -p ~/.claude/skills

# Copy each skill directory
cp -r /path/to/dev-suite-claude-skills/product-research ~/.claude/skills/
cp -r /path/to/dev-suite-claude-skills/technical-architecture ~/.claude/skills/
cp -r /path/to/dev-suite-claude-skills/software-development ~/.claude/skills/
cp -r /path/to/dev-suite-claude-skills/quality-engineering ~/.claude/skills/

# Verify installation
ls -la ~/.claude/skills/
```

### Option 3: API Usage

If using Claude via API, skills must be uploaded to your account via Claude.ai first (see Option 1), then they'll automatically be available in API calls.

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

### Skills Not Loading

**Symptom:** Claude doesn't seem to use the skills

**Solutions:**

1. **Verify installation location:**
   ```bash
   # For project skills
   ls -la .claude/skills/

   # For personal skills
   ls -la ~/.claude/skills/

   # For plugins
   claude plugin list
   ```

2. **Check skill format:**
   ```bash
   ./scripts/validate-skills.sh
   ```

3. **Try explicit skill invocation:**
   ```
   Using the product-research skill, help me analyze...
   ```

4. **Ensure descriptions include trigger keywords:**
   - Each skill's description includes keywords Claude uses for matching
   - Check frontmatter in SKILL.md files

5. **Restart Claude (if using CLI):**
   ```bash
   # Exit and restart
   exit
   claude
   ```

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
