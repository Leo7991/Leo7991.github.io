# 添加脚本到 cron job

你可以添加cron job 在 `bin/gen_cronjobs.rb`, 样例如下.

```
puts [
  "59 * * * * ruby script",
  "*/10 * * * * ruby script"
].map { |job|
  *schedule, cmd = job.split(' ')
  "#{schedule.join(' ')} cd /usr/src/app; rails runner \"Util.run_once('#{cmd}')\""
}.join("\n")
```

如果你想运行 bash 脚本,你可以把 `cd /usr/src/app; rails runner \"Util.run_once('#{cmd}')\"` 替换为你自定义的命令.