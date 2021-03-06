# DangerFile
# https://danger.systems/reference.html

require_relative 'tools/lib/helper'
helper = Helper.new

# get list of old names that were renamed
renamed_files = (git.renamed_files.collect{|r| r[:before]})
# get list of all files changes minus the old files renamed
# remove list of renamed files to prevent errors on files that don't exist
changed_files = (git.added_files + git.modified_files - renamed_files)
has_app_changes = changed_files.select{ |file| file.end_with? "plugin" or file.end_with? "rb"  and !file.start_with?("tools/") }
has_new_plugin = git.added_files.select{ |file| file.end_with? "plugin" or file.end_with? "rb" and !file.start_with?("tools/") }
md_files = changed_files.select{ |file| file.end_with? "md" }

# Changelog entries are required for changes to plugin files.
no_changelog_entry = (changed_files.grep(/[\w]+CHANGELOG.md/i)+changed_files.grep(/CHANGELOG.md/i)).empty?
if (has_app_changes.length != 0) && no_changelog_entry
  fail "Please add a CHANGELOG.md file"
end

missing_doc_changes = (changed_files.grep(/[\w]+README.md/i)+changed_files.grep(/README.md/i)).empty?
if (has_app_changes.length != 0) && missing_doc_changes
  warn("Should this include readme changes")
end

if (has_new_plugin.length != 0) && missing_doc_changes
  fail "A README.md is required for new templates"
end

fail 'Please provide a summary of your Pull Request.' if github.pr_body.length < 10

fail 'Please add labels to this Pull Request' if github.pr_labels.empty?

# check for lowercase files and directories
has_app_changes.each do |file|
  if file.scan(/^[a-z0-9.\/_-]+$/).empty?
    fail "Plugin path should be lowercase. #{file}"
  end
end

# check the plugin syntax and plugin fields
has_app_changes.each do |file|
  if file =~ /plugin/
    puts "Checking CAT #{file}"
    message("Checking CAT #{file}")
    cmd = "./tools/bin/compile #{file}"
    plugin  = `#{cmd}`
    json = {}
    if helper.valid_json?(plugin)
      json = JSON.parse(plugin)
    else
      fail "File syntax check failed. #{file}."
    end
    if json['type'] && json['type']=='plugin'
      fail "Add plugin name" unless json['name']
      fail "Add short_description. #{file}" unless json['short_description']
      if json['info']
        fail "Add info provider. #{file}" unless json['info']['provider']
        fail "Add info service. #{file}"  unless json['info']['service']
      else
        fail "Add info provider and service. #{file}"
      end
      if json['plugins']
        fail "Add plugin version. #{file}" unless helper.nested_hash_value(json['plugins'],'version')
        fail "Add plugin short_description. #{file}" unless helper.nested_hash_value(json['plugins'],'short_description')
        fail "Add plugin documentation_link for readme. #{file}" unless helper.nested_hash_value(json['plugins'],'readme')
        fail "Add plugin documentation_link for source. #{file}" unless helper.nested_hash_value(json['plugins'],'source')
      end
    end
  end
end

# Lint added and modified files only

textlint.max_severity = "warn"
textlint.lint
