$kk = ["/tmp",
       "/tmp/a",
       "/tmp/a/b"
]

file {$kk:
  ensure  => directory,
}
