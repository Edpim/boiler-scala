name := BuildConfig.name

version := "0.1"

scalaVersion := ScalaConfig.version

scalacOptions := ScalaConfig.compilerOptions.value

javaOptions := RuntimeConfig.javaRuntimeOptions

libraryDependencies ++= Seq(
  "com.typesafe" % "config" % "1.3.3"
)

libraryDependencies ++= Seq(
  "org.scalamock" %% "scalamock" % "4.1.0" % Test,
  "org.scalatest" %% "scalatest" % "3.0.5" % Test
)

// do not include tests in assembly
test in assembly := {}
