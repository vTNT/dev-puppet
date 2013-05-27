class test::files inherits test {
        file {"/tmp/bb/aa":
          ensure  => directory,
        }
}
