#!/usr/bin/env bash
set -euo pipefail

# Create a minimal Gradle project that compiles & runs examples in .github/examples/java
cat > build.gradle <<'EOF'
plugins {
    id 'java'
}

repositories {
    mavenCentral()
}

dependencies {
    implementation 'com.hedera.hashgraph:sdk:2.60.0'
    implementation 'com.google.code.gson:gson:2.11.0'
    implementation 'io.grpc:grpc-netty-shaded:1.61.0'
}

sourceSets {
    examples {
        java.srcDirs = ['.github/examples/java']
        compileClasspath += sourceSets.main.output + configurations.implementation
        runtimeClasspath += output + compileClasspath
    }
}

configurations {
    examplesImplementation.extendsFrom implementation
    examplesRuntimeOnly.extendsFrom runtimeOnly
}

def examplesDir = file('.github/examples/java')

// Derive a fully-qualified class name from a .java file by reading its 'package ...;' line (if present)
def fqnFor = { File f ->
    def pkgLine = f.readLines().find { it =~ /^\s*package\s+[\w\.]+\s*;/ }
    def pkg = pkgLine ? pkgLine.replaceAll(/^\s*package\s+/, '').replace(';','').trim() : null
    def cls = f.name.replaceFirst(/\.java$/, '')
    pkg ? "${pkg}.${cls}" : cls
}

def exampleFiles = examplesDir.exists()
        ? fileTree(examplesDir) { include '**/*.java' }.files
        : [] as Set<File>

/**
 * Run a single example via:
 *   ./gradlew runExample -PexampleClass=<fully.qualified.ClassName>
 * If your example has no 'package' line, use just the class name (e.g., CreateAccountDemo).
 */
tasks.register('runExample', JavaExec) {
    group = 'examples'
    description = 'Run a single Java example (use -PexampleClass=<FQN>)'
    classpath = sourceSets.examples.runtimeClasspath

    doFirst {
        if (!project.hasProperty('exampleClass')) {
            throw new GradleException("Missing -PexampleClass=<fully.qualified.ClassName>")
        }
        // Set to a concrete String value at execution time
        mainClass.set(project.property('exampleClass').toString())
    }
}

// Create a JavaExec task per discovered example: run_<FQN with dots replaced by underscores>
exampleFiles.each { f ->
    def fqn = fqnFor(f)
    tasks.register("run_${fqn.replace('.', '_')}", JavaExec) {
        group = 'examples'
        description = "Run example ${fqn}"
        classpath = sourceSets.examples.runtimeClasspath
        mainClass.set(fqn)
    }
}

// Aggregate task: run all discovered examples
tasks.register('runAllExamples') {
    group = 'examples'
    description = 'Run all Java examples in .github/examples/java'
    dependsOn tasks.matching { it.name.startsWith('run_') }
}
EOF

echo "rootProject.name = 'docs-examples-runner'" > settings.gradle

# Gradle wrapper (works on GitHub runners)
if [ ! -f gradlew ]; then
  curl -sL https://services.gradle.org/distributions/gradle-8.9-bin.zip -o gradle.zip
  mkdir -p .gradle/wrapper/dists
  unzip -q gradle.zip -d .gradle >/dev/null || true
  rm -f gradle.zip
  if command -v gradle >/dev/null 2>&1; then
    gradle wrapper -q
  else
    curl -s https://raw.githubusercontent.com/gradle/gradle/master/gradlew -o gradlew
    chmod +x gradlew
  fi
fi

chmod +x gradlew
echo "✅ Gradle bootstrap complete"
